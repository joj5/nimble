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
docker compose -f compose-dev.yaml up
```

3. The API will be accessible at: [https://dev.backend.com/api/v1:8443](https://dev.backend.com/api/v1:8443)

### Environment Variables

Make sure to configure environment variables for the backend, either in an `.env` file or in your Docker run command:

```env
POSTGRES_PASSWORD=database password
POSTGRES_USER=database user
POSTGRES_DB=database name
SERVER_PORT=port to serve the application on
MAIL_PORT=XXXX
REDIS_PORT=XXXX
SPRING_DATASOURCE_URL=spring database server url
SPRING_DATASOURCE_USERNAME=spring database username
SPRING_DATASOURCE_PASSWORD=spring database password
SPRING_JPA_HIBERNATE_DDL_AUTO=<create | create-drop | update | validate | none>
JAVA_OPTS=-Xms512m -Xmx1024m
ALLOW_EMPTY_PASSWORD=yes # ALLOW_EMPTY_PASSWORD is recommended only for development.
REDIS_DISABLE_COMMANDS=FLUSHDB,FLUSHALL
ORIGINS=allowed domains
JWT_SECRET=
JWT_EXPIRATION=
RT_EXPIRATION=
API_KEY=
API_SECRET=
MAIL_USERNAME=
MAIL_PASSWORD=
SUPPORT_EMAIL=
SSL_KEY_PASSWORD=
DATASOURCE_CONNECTION_TIMEOUT=
DATASOURCE_MAX_POOL_SIZE=
DATASOURCE_IDLE_TIMEOUT=
DATASOURCE_MIN_IDLE=
MAX_FILE_SIZE=
MAX_REQUEST_SIZE=
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
