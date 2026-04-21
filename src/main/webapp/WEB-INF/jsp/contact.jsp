<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - PAMS</title>
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
        .contact-card { border: none; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
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
            <h1 class="mb-3">Get in Touch</h1>
            <p>We'd love to hear from you. Here's how you can reach us.</p>
        </div>
    </header>

    <!-- Content Section -->
    <section class="container my-5">
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card contact-card h-100">
                    <div class="card-body p-4 p-md-5">
                        <h4 class="fw-bold mb-4" style="color: #0f4c75;">Send us a Message</h4>
                        <form action="/" method="get">
                            <div class="mb-3">
                                <label class="form-label text-muted fw-bold">Name</label>
                                <input type="text" class="form-control" placeholder="Your full name" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted fw-bold">Email</label>
                                <input type="email" class="form-control" placeholder="Your email address" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label text-muted fw-bold">Message</label>
                                <textarea class="form-control" rows="5" placeholder="How can we help you?" required></textarea>
                            </div>
                            <button type="button" class="btn text-white w-100 p-2 fw-bold" style="background-color: #3282b8;">Submit Message</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6 mb-4">
                <div class="card contact-card h-100">
                    <div class="card-body p-4 p-md-5 d-flex flex-column justify-content-center">
                        <h4 class="fw-bold mb-4" style="color: #0f4c75;">Contact Information</h4>
                        <ul class="list-unstyled">
                            <li class="mb-4 d-flex align-items-center">
                                <i class="fa-solid fa-location-dot fa-2x ms-2 me-4" style="color: #3282b8;"></i>
                                <div>
                                    <h6 class="mb-0 fw-bold">Headquarters</h6>
                                    <span class="text-muted">123 Gov Administration Block, City Center</span>
                                </div>
                            </li>
                            <li class="mb-4 d-flex align-items-center">
                                <i class="fa-solid fa-phone fa-2x ms-2 me-4" style="color: #3282b8;"></i>
                                <div>
                                    <h6 class="mb-0 fw-bold">Phone Support</h6>
                                    <span class="text-muted">+1 (555) 123-4567</span>
                                </div>
                            </li>
                            <li class="mb-4 d-flex align-items-center">
                                <i class="fa-solid fa-envelope fa-2x ms-2 me-4" style="color: #3282b8;"></i>
                                <div>
                                    <h6 class="mb-0 fw-bold">Email Address</h6>
                                    <span class="text-muted">support@pams-gov.org</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
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
