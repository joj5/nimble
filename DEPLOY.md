# Deploying a Dockerized Spring Boot Application to AWS with S3 Integration

## 1. Spring Boot Setup

### Add Dependencies (pom.xml)
<dependency>
  <groupId>software.amazon.awssdk</groupId>
  <artifactId>s3</artifactId>
</dependency>
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-web</artifactId>
</dependency>

### application.properties
aws.region=us-east-1
aws.s3.bucket=my-upload-bucket

### S3Service.java
package com.example.s3upload;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import java.io.IOException;

@Service
public class S3Service {
    private final S3Client s3Client;

    @Value("${aws.s3.bucket}")
    private String bucketName;

    public S3Service(@Value("${aws.region}") String region) {
        this.s3Client = S3Client.builder().region(Region.of(region)).build();
    }

    public void uploadFile(MultipartFile file) throws IOException {
        PutObjectRequest request = PutObjectRequest.builder()
            .bucket(bucketName)
            .key(file.getOriginalFilename())
            .build();
        s3Client.putObject(request, RequestBody.fromBytes(file.getBytes()));
    }
}

### UploadController.java
package com.example.s3upload;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/upload")
public class UploadController {
    private final S3Service s3Service;

    public UploadController(S3Service s3Service) {
        this.s3Service = s3Service;
    }

    @PostMapping
    public ResponseEntity<String> upload(@RequestParam("file") MultipartFile file) {
        try {
            s3Service.uploadFile(file);
            return ResponseEntity.ok("Uploaded!");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Upload failed");
        }
    }
}

## 2. Dockerize the App

### Dockerfile
FROM eclipse-temurin:17-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]

### Build Commands
./mvnw clean package -DskipTests
docker build -t springboot-s3-app .

## 3. Push Image to AWS ECR

aws ecr create-repository --repository-name springboot-s3-app

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account_id>.dkr.ecr.us-east-1.amazonaws.com

docker tag springboot-s3-app:latest <account_id>.dkr.ecr.us-east-1.amazonaws.com/springboot-s3-app

docker push <account_id>.dkr.ecr.us-east-1.amazonaws.com/springboot-s3-app

## 4. IAM Policy for ECS Task Role

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::my-upload-bucket/*"
    }
  ]
}

## 5. ECS Setup Steps

1. Go to ECS > Clusters > Create Cluster > Fargate
2. Create Task Definition (FARGATE):
   - Container name: springboot
   - Image: <account_id>.dkr.ecr.us-east-1.amazonaws.com/springboot-s3-app
   - Port: 8080
   - Assign IAM task role with S3 access
3. Create ECS Service:
   - Launch Type: Fargate
   - Cluster: select your cluster
   - Task Definition: your definition
   - Subnets: public
   - Security group: allow inbound on port 80 or 8080
4. (Optional) Set up Application Load Balancer

## 6. Test Upload

curl -F "file=@myphoto.jpg" http://<public-ecs-endpoint>/upload

## 7. GitHub Actions CI/CD (.github/workflows/deploy.yml)

name: Deploy to ECR

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Configure AWS
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Login to ECR
        run: |
          aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account_id>.dkr.ecr.us-east-1.amazonaws.com

      - name: Build and Push Docker Image
        run: |
          docker build -t springboot-s3-app .
          docker tag springboot-s3-app:latest <account_id>.dkr.ecr.us-east-1.amazonaws.com/springboot-s3-app
          docker push <account_id>.dkr.ecr.us-east-1.amazonaws.com/springboot-s3-app

## 8. Security Best Practices

- Use IAM roles for ECS tasks instead of hardcoded AWS credentials
- Ensure S3 bucket has the least privilege access
- Use HTTPS via ALB or API Gateway for real-world deployments

