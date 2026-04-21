# PAMS - Public Asset Management System

[![Java](https://img.shields.io/badge/Java-17-orange)](https://openjdk.java.net/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.3-brightgreen)](https://spring.io/projects/spring-boot)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

A comprehensive web-based Public Asset Management System built with Spring Boot, designed to streamline complaint reporting and management for public infrastructure.

## 🚀 Features

### Core Functionality

- **User Registration & Authentication**: Secure login system with role-based access
- **Complaint Management**: Citizens can report issues with public assets
- **Admin Dashboard**: Comprehensive admin panel for managing complaints and users
- **Asset Tracking**: Manage public assets (roads, streetlights, pumps, etc.)
- **Technician Assignment**: Assign field workers to resolve complaints
- **Maintenance Logs**: Track all actions taken on complaints
- **Email Notifications**: Automated email alerts for status updates
- **File Upload**: Support for complaint images and documents

### User Roles

- **Citizens (Users)**: Register complaints, track status, view history
- **Administrators**: Manage complaints, assign technicians, oversee operations

## 🛠️ Technology Stack

- **Backend**: Spring Boot 3.2.3, Java 17
- **Database**: MySQL 8.0 with JDBC (Raw SQL, no ORM)
- **Frontend**: JSP, HTML5, CSS3, Bootstrap 5, JavaScript
- **Build Tool**: Maven
- **Email**: Spring Mail (SMTP)
- **Server**: Embedded Tomcat

## 📋 Prerequisites

Before running this application, make sure you have the following installed:

- **Java 17** or higher
- **MySQL 8.0** or higher
- **Maven 3.6+** (included via Maven Wrapper)
- **Git** (for version control)

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/pams.git
cd pams
```

### 2. Database Setup

Create a MySQL database and update the connection details:

```sql
-- Create database
CREATE DATABASE pams_db;
```

Update `src/main/resources/application.properties`:

```properties
# MySQL Configuration
spring.datasource.url=jdbc:mysql://localhost:3306/pams_db?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC
spring.datasource.username=your_mysql_username
spring.datasource.password=your_mysql_password
```

### 3. Email Configuration (Optional)

For email notifications, configure SMTP in `application.properties`:

```properties
# Email Configuration (SMTP)
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
```

### 4. Run the Application

```bash
# Using Maven Wrapper (Windows)
mvnw.cmd spring-boot:run

# Using Maven Wrapper (Linux/Mac)
./mvnw spring-boot:run

# Or using Maven directly
mvn spring-boot:run
```

### 5. Access the Application

Open your browser and navigate to: **http://localhost:8083**

## 📁 Project Structure

```
pams/
├── src/main/java/com/pams/
│   ├── PamsApplication.java          # Main Spring Boot application
│   ├── config/                       # Configuration classes
│   │   ├── DBConnection.java         # Database connection utility
│   │   └── WebConfig.java           # Web configuration
│   ├── controller/                   # MVC Controllers
│   │   ├── AuthController.java      # Authentication endpoints
│   │   └── ComplaintController.java # Complaint management
│   ├── dao/                         # Data Access Objects
│   │   ├── UserDAO.java             # User database operations
│   │   ├── ComplaintDAO.java        # Complaint operations
│   │   ├── AssetDAO.java            # Asset management
│   │   ├── TechnicianDAO.java       # Technician operations
│   │   └── MaintenanceLogDAO.java   # Maintenance tracking
│   ├── model/                       # Data Models (POJOs)
│   │   ├── User.java                # User entity
│   │   ├── Complaint.java           # Complaint entity
│   │   ├── Asset.java               # Asset entity
│   │   ├── Technician.java          # Technician entity
│   │   └── MaintenanceLog.java      # Log entity
│   └── service/                     # Business Logic
│       ├── UserService.java         # User management logic
│       ├── ComplaintService.java    # Complaint processing
│       └── EmailService.java        # Email notifications
├── src/main/resources/
│   ├── application.properties       # Application configuration
│   ├── schema.sql                   # Database schema
│   └── data.sql                     # Sample data
├── src/main/webapp/
│   ├── WEB-INF/jsp/                 # JSP view templates
│   └── images/                      # Static assets
├── target/                          # Build output (generated)
├── mvnw & mvnw.cmd                  # Maven wrapper scripts
├── pom.xml                          # Maven configuration
└── README.md                        # This file
```

## 🔧 Configuration

### Application Properties

Key configuration options in `application.properties`:

```properties
# Server Configuration
server.port=8083
spring.application.name=pams

# Database Configuration
spring.datasource.url=jdbc:mysql://localhost:3306/pams_db?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=your_password

# Email Configuration
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password

# File Upload
spring.servlet.multipart.max-file-size=5MB
spring.servlet.multipart.max-request-size=5MB
```

## 🗄️ Database Schema

The application uses 5 main tables:

1. **users**: Citizen and admin accounts
2. **assets**: Public infrastructure assets
3. **complaints**: User-reported issues
4. **technicians**: Field workers
5. **maintenance_logs**: Action history

Database schema is automatically created from `schema.sql` on startup.

## 🌐 API Endpoints

### Authentication

- `GET /` - Home page
- `GET /login` - Login form
- `POST /login` - Process login
- `GET /register` - Registration form
- `POST /register` - Process registration
- `GET /logout` - Logout

### User Dashboard

- `GET /dashboard` - User dashboard
- `GET /raise-complaint` - New complaint form
- `POST /raise-complaint` - Submit complaint
- `GET /my-complaints` - User's complaints

### Admin Dashboard

- `GET /admin/dashboard` - Admin overview
- `GET /admin/complaints` - Manage complaints
- `GET /admin/assets` - Manage assets
- `GET /admin/technicians` - Manage technicians
- `GET /admin/logs` - View maintenance logs

## 🚀 Deployment

### Option 1: Local Deployment

Follow the Quick Start guide above.

### Option 2: Docker Deployment

```dockerfile
# Dockerfile
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8083
ENTRYPOINT ["java","-jar","app.jar"]
```

### Option 3: Cloud Deployment (Railway)

1. Connect your GitHub repository to Railway
2. Set environment variables:
   - `DATABASE_URL` (Railway provides this)
   - `EMAIL_HOST`, `EMAIL_PORT`, `EMAIL_USER`, `EMAIL_PASS`
3. Deploy automatically on push

### Option 4: Heroku Deployment

1. Create `Procfile`:
   ```
   web: java -jar target/pams-0.0.1-SNAPSHOT.jar
   ```
2. Set Heroku environment variables
3. Deploy via Git push

## 🧪 Testing

### Manual Testing

1. Start the application
2. Register a new user account
3. Login and create a complaint
4. Login as admin (create admin user in database)
5. Assign technician and update complaint status

### Sample Test Data

The application includes sample data in `data.sql` for testing.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email: your-email@example.com or create an issue in this repository.

## 🙏 Acknowledgments

- Spring Boot framework
- Bootstrap for UI components
- MySQL for database
- FontAwesome for icons

---

**Built with ❤️ using Spring Boot**
