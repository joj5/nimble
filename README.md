# 📦 Nimble Inventory Management Application

An inventory management system with a **Java Spring Boot** backend and a **Flutter** mobile frontend. The backend is containerized using Docker and deployed on **AWS**. The mobile app is compatible with both Android and iOS devices.

## 🧩 Project Structure

```
inventory-app/
│
├── backend/              # Spring Boot backend (Dockerized)
│   ├── src/
│   ├── Dockerfile
│   └── ...
│
├── mobile_app/           # Flutter frontend
│   ├── lib/
│   ├── android/
│   ├── ios/
│   └── ...
│
└── README.md             # Project documentation
```

## 🚀 Backend - Java Spring Boot

### Features

- RESTful API for inventory operations
- Dockerized and deployed on AWS
- Connects to a PostgreSQL database
- Secure and scalable architecture

### Prerequisites

- Java 17+
- Docker
- AWS CLI configured
- PostgreSQL (for local development)

### Running the Backend Locally

1. Navigate to the backend directory:

```bash
cd backend
```

2. Build the Docker image:

```bash
docker build -t inventory-backend .
```

3. Run the container:

```bash
docker run -d -p 8080:8080 --name inventory-api inventory-backend
```

4. The API will be accessible at: [http://localhost:8080](http://localhost:8080)

### Environment Variables

Make sure to configure environment variables for the backend, either in an `.env` file or in your Docker run command:

```env
SPRING_DATASOURCE_URL=jdbc:postgresql://<host>:5432/inventory_db
SPRING_DATASOURCE_USERNAME=your_db_user
SPRING_DATASOURCE_PASSWORD=your_db_password
SPRING_JPA_HIBERNATE_DDL_AUTO=update
```

## ☁️ AWS Deployment

### Docker Image Deployment

1. Authenticate with AWS ECR:

```bash
aws ecr get-login-password | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
```

2. Tag and push the Docker image:

```bash
docker tag inventory-backend:latest <your-ecr-repo>:latest
docker push <your-ecr-repo>:latest
```

3. Deploy the container using ECS (Fargate) or EC2 via the AWS Management Console or CLI.

## 📱 Frontend - Flutter Mobile App

### Features

- User-friendly UI for inventory browsing and management
- Connects seamlessly to the Spring Boot REST API
- Responsive design for Android and iOS

### Prerequisites

- Flutter SDK ([Install Guide](https://docs.flutter.dev/get-started/install))
- Android Studio or Xcode
- Emulator or physical device

### Running the Flutter App

1. Navigate to the Flutter app directory:

```bash
cd mobile_app
```

2. Install dependencies:

```bash
flutter pub get
```

3. Configure the backend API URL:

Open `lib/constants.dart` (or similar config file) and set the correct base URL:

```dart
const String baseUrl = "http://<your-backend-ip>:8080";
```

> ⚠️ If testing on a physical device, use your computer’s local IP, not `localhost`.

4. Run the app:

- On Android:

```bash
flutter run
```

- On iOS:

```bash
flutter run -d ios
```

## 🛠️ Tech Stack

- Backend: Java 17, Spring Boot, PostgreSQL, Docker
- Frontend: Flutter, Dart
- Deployment: AWS (ECR, ECS, RDS, EC2/Fargate)

## 📬 Contact

**Jason Jones**  
📧 jason.oneal.jones@gmail.com  
📱 +1 (246) 240-6117

## 📄 License

This project is licensed under the MIT License.

# nimble
