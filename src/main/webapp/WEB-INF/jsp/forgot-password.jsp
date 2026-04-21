<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - PAMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f4f9f9; }
        .reset-card { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .reset-header { background: linear-gradient(135deg, #0f4c75, #3282b8); color: white; border-radius: 15px 15px 0 0; padding: 25px; text-align: center; }
        .btn-primary { background-color: #3282b8; border: none; padding: 10px; font-weight: 600; }
        .btn-primary:hover { background-color: #0f4c75; }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <a href="/login" class="text-decoration-none text-secondary mb-3 d-inline-block"><i class="fa-solid fa-arrow-left"></i> Back to Login</a>
                <div class="card reset-card">
                    <div class="reset-header">
                        <h2><i class="fa-solid fa-key"></i> Reset Password</h2>
                        <p class="mb-0">Enter your email to receive a reset link</p>
                    </div>
                    <div class="card-body p-4">
                        <% if(request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                        <% } %>
                        <% if(request.getAttribute("message") != null) { %>
                            <div class="alert alert-success"><%= request.getAttribute("message") %></div>
                        <% } %>
                        <form action="/forgot-password" method="post">
                            <div class="mb-4">
                                <label class="form-label text-muted fw-bold">Email Address</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                                    <input type="email" name="email" class="form-control" required placeholder="name@example.com">
                                </div>
                                <small class="text-muted">A password reset link will be sent to this email if it exists in our system.</small>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">Send Reset Link</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
