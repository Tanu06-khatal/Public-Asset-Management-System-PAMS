<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - PAMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background: linear-gradient(135deg, #0f4c75 0%, #1b262c 100%); min-height: 100vh; }
        .login-card { border: none; border-radius: 16px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); }
        .login-header { background: linear-gradient(135deg, #0f4c75, #3282b8); color: white; border-radius: 16px 16px 0 0; padding: 28px; text-align: center; }
        .btn-primary { background-color: #3282b8; border: none; padding: 12px; font-weight: 600; }
        .btn-primary:hover { background-color: #0f4c75; }
        .form-control:focus { border-color: #3282b8; box-shadow: 0 0 0 0.2rem rgba(50,130,184,0.25); }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <a href="/" class="text-decoration-none text-white mb-3 d-inline-block">
                <i class="fa-solid fa-arrow-left"></i> Back to Home
            </a>
            <div class="card login-card">
                <div class="login-header">
                    <h2><i class="fa-solid fa-shield-halved"></i> PAMS Login</h2>
                    <p class="mb-0">Public Asset Management System</p>
                </div>
                <div class="card-body p-4">

                    <% if(request.getParameter("registered") != null) { %>
                        <div class="alert alert-success"><i class="fa-solid fa-check-circle me-1"></i>Account created! You can now login.</div>
                    <% } %>
                    <% if(request.getParameter("reset") != null) { %>
                        <div class="alert alert-success"><i class="fa-solid fa-check-circle me-1"></i>Password reset successful! Please login.</div>
                    <% } %>
                    <% if(request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation me-1"></i><%= request.getAttribute("error") %></div>
                    <% } %>

                    <form action="/login" method="post" id="loginForm">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Email or Phone Number</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" name="email" id="identifier" class="form-control" required
                                       placeholder="Enter email or phone number">
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-bold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                                <input type="password" name="password" id="password" class="form-control" required
                                       placeholder="Enter your password">
                                <button class="btn btn-outline-secondary" type="button" onclick="togglePass()">
                                    <i class="fa-solid fa-eye" id="passIcon"></i>
                                </button>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <div></div>
                            <a href="/forgot-password" class="text-decoration-none small" style="color:#3282b8;">Forgot password?</a>
                        </div>
                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fa-solid fa-right-to-bracket me-1"></i> Login
                            </button>
                        </div>
                        <div class="text-center">
                            <span class="text-muted">Don't have an account?
                                <a href="/register" class="fw-bold text-decoration-none" style="color:#3282b8;">Register here</a>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function togglePass() {
        const input = document.getElementById('password');
        const icon = document.getElementById('passIcon');
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.replace('fa-eye-slash', 'fa-eye');
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
