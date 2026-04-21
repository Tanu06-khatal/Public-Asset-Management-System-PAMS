<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PAMS - Public Asset Management System</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f4f9f9; color: #333; }
        .navbar { background: linear-gradient(135deg, #0f4c75, #3282b8); }
        .navbar-brand, .nav-link { color: white !important; }
        .nav-link:hover { color: #bbe1fa !important; }
        .hero {
            background: linear-gradient(rgba(15, 76, 117, 0.8), rgba(15, 76, 117, 0.8)), url('https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=2070') no-repeat center center/cover;
            color: white; padding: 100px 0; text-align: center;
        }
        .hero h1 { font-weight: 700; font-size: 3rem; }
        .hero p { font-size: 1.2rem; margin-bottom: 30px; }
        .btn-primary { background-color: #3282b8; border: none; padding: 10px 25px; }
        .btn-primary:hover { background-color: #0f4c75; }
        .feature-icon { font-size: 3rem; color: #3282b8; margin-bottom: 15px; }
        .footer { background-color: #1b262c; color: #ccc; padding: 30px 0; text-align: center; margin-top: 50px; }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand fw-bold" href="/"><i class="fa-solid fa-building-shield"></i> PAMS</a>
            <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="fa-solid fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="/login">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="/register">Register</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <header class="hero">
        <div class="container">
            <h1 class="mb-3">Public Asset Management System</h1>
            <p>Report, manage, and track public infrastructure issues in real-time.</p>
            
            <div class="row mt-5 justify-content-center">
                <!-- Citizen Portal Card -->
                <div class="col-md-5 mb-4">
                    <div class="card h-100 border-0 shadow-sm" style="background: rgba(255,255,255,0.1); backdrop-filter: blur(10px); color: white;">
                        <div class="card-body p-5">
                            <i class="fa-solid fa-users mb-3" style="font-size: 2.5rem;"></i>
                            <h3 class="fw-bold">Citizen Portal</h3>
                            <p>For residents to report issues and track their status.</p>
                            <div class="mt-4">
                                <a href="/login" class="btn btn-light btn-lg text-primary fw-bold px-4 me-2">Citizen Login</a>
                                <a href="/register" class="btn btn-outline-light btn-lg px-4">Sign Up</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Admin Portal Card -->
                <div class="col-md-5 mb-4">
                    <div class="card h-100 border-0 shadow-sm" style="background: rgba(255,255,255,0.1); backdrop-filter: blur(10px); color: white;">
                        <div class="card-body p-5">
                            <i class="fa-solid fa-user-shield mb-3" style="font-size: 2.5rem;"></i>
                            <h3 class="fw-bold">Admin Portal</h3>
                            <p>For authorities to manage reports and update infrastructure status.</p>
                            <div class="mt-4">
                                <a href="/login" class="btn btn-info btn-lg text-white fw-bold px-4">Admin Login</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Features -->
    <section class="container my-5">
        <div class="row text-center">
            <div class="col-md-4 mb-4">
                <i class="fa-solid fa-camera feature-icon"></i>
                <h3>Report Instantly</h3>
                <p>Spotted a broken street light or pothole? Report it instantly by uploading a picture.</p>
            </div>
            <div class="col-md-4 mb-4">
                <i class="fa-solid fa-chart-line feature-icon"></i>
                <h3>Track Progress</h3>
                <p>Monitor the status of your complaints on your personal dashboard.</p>
            </div>
            <div class="col-md-4 mb-4">
                <i class="fa-solid fa-screwdriver-wrench feature-icon"></i>
                <h3>Efficient Resolution</h3>
                <p>Authorities get real-time updates to fix issues faster and smarter.</p>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p class="mb-0">&copy; 2026 Public Asset Management System. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
