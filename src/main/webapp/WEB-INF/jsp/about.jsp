<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - PAMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f4f9f9; color: #333; }
        .navbar { background: linear-gradient(135deg, #0f4c75, #3282b8); }
        .navbar-brand, .nav-link { color: white !important; }
        .nav-link:hover { color: #bbe1fa !important; }
        .hero-mini { background: linear-gradient(135deg, #0f4c75, #3282b8); color: white; padding: 60px 0; text-align: center; }
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
                    <li class="nav-item"><a class="nav-link" href="/about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="/contact">Contact</a></li>
                    <li class="nav-item"><a class="nav-link" href="/login">Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Mini Hero -->
    <header class="hero-mini">
        <div class="container">
            <h1 class="mb-3">About PAMS</h1>
            <p>Empowering citizens to build better cities.</p>
        </div>
    </header>

    <!-- Content Section -->
    <section class="container my-5">
        <div class="row align-items-center">
            <div class="col-md-6 mb-4">
                <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=2069" alt="Office Concept" class="img-fluid rounded shadow">
            </div>
            <div class="col-md-6 mb-4">
                <h3 class="fw-bold mb-3" style="color: #0f4c75;">Our Purpose</h3>
                <p>The Public Asset Management System (PAMS) is designed to bridge the gap between citizens and local authorities. Maintaining public infrastructure is a collective effort, and PAMS provides the perfect platform to streamline this process.</p>
                <p>Whether it's a damaged street lamp, a growing pothole, or a broken park bench, our platform allows you to report issues instantly, attach photo evidence, track the resolution progress, and ensure your community remains safe and beautiful.</p>
                <a href="/register" class="btn btn-outline-primary mt-3" style="color: #3282b8; border-color: #3282b8;">Join Our Mission Today <i class="fa-solid fa-arrow-right"></i></a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer mt-auto">
        <div class="container">
            <p class="mb-0">&copy; 2026 Public Asset Management System. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
