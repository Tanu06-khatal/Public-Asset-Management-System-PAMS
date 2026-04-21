<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - PAMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background: linear-gradient(135deg, #0f4c75 0%, #1b262c 100%); min-height: 100vh; }
        .register-card { border: none; border-radius: 16px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); }
        .register-header { background: linear-gradient(135deg, #0f4c75, #3282b8); color: white; border-radius: 16px 16px 0 0; padding: 28px; text-align: center; }
        .btn-primary { background-color: #3282b8; border: none; padding: 12px; font-weight: 600; }
        .btn-primary:hover { background-color: #0f4c75; }
        .form-control:focus { border-color: #3282b8; box-shadow: 0 0 0 0.2rem rgba(50,130,184,0.25); }
        .invalid-feedback { display: block; }
        small.hint { color: #888; font-size: 0.78rem; }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center py-4">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <a href="/" class="text-decoration-none text-white mb-3 d-inline-block">
                <i class="fa-solid fa-arrow-left"></i> Back to Home
            </a>
            <div class="card register-card">
                <div class="register-header">
                    <h2><i class="fa-solid fa-user-plus"></i> Create Account</h2>
                    <p class="mb-0">Join PAMS - Public Asset Management System</p>
                </div>
                <div class="card-body p-4">

                    <!-- Server-side error -->
                    <% if(request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation me-1"></i><%= request.getAttribute("error") %></div>
                    <% } %>

                    <form action="/register" method="post" id="registerForm" novalidate>

                        <!-- Full Name -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Full Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" name="name" id="name" class="form-control" required
                                       placeholder="Enter full name (letters only)"
                                       value="<%= request.getAttribute("nameVal") != null ? request.getAttribute("nameVal") : "" %>">
                            </div>
                            <small class="hint">Only letters and spaces allowed.</small>
                            <div class="invalid-feedback" id="nameError"></div>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                                <input type="email" name="email" id="email" class="form-control" required
                                       placeholder="Enter email address"
                                       value="<%= request.getAttribute("emailVal") != null ? request.getAttribute("emailVal") : "" %>">
                            </div>
                            <div class="invalid-feedback" id="emailError"></div>
                        </div>

                        <!-- Phone Number -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Phone Number</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                                <input type="tel" name="phoneNumber" id="phone" class="form-control" required
                                       placeholder="10-digit mobile number"
                                       maxlength="10"
                                       value="<%= request.getAttribute("phoneVal") != null ? request.getAttribute("phoneVal") : "" %>">
                            </div>
                            <small class="hint">Must be exactly 10 digits. No spaces or dashes.</small>
                            <div class="invalid-feedback" id="phoneError"></div>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                                <input type="password" name="password" id="password" class="form-control" required
                                       placeholder="Create password (6-20 characters)">
                                <button class="btn btn-outline-secondary" type="button" onclick="togglePass('password', this)">
                                    <i class="fa-solid fa-eye"></i>
                                </button>
                            </div>
                            <small class="hint">6 to 20 characters, no spaces.</small>
                            <div class="invalid-feedback" id="passError"></div>
                        </div>

                        <!-- Confirm Password -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Confirm Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                                <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required
                                       placeholder="Re-enter password">
                                <button class="btn btn-outline-secondary" type="button" onclick="togglePass('confirmPassword', this)">
                                    <i class="fa-solid fa-eye"></i>
                                </button>
                            </div>
                            <div class="invalid-feedback" id="confirmError"></div>
                        </div>

                        <!-- Role -->
                        <div class="mb-4">
                            <label class="form-label fw-bold">Register As</label>
                            <select name="role" class="form-select">
                                <option value="USER">Citizen (User)</option>
                                <option value="ADMIN">System Admin</option>
                            </select>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fa-solid fa-user-plus me-1"></i> Create Account
                            </button>
                        </div>
                        <div class="text-center">
                            <span class="text-muted">Already have an account?
                                <a href="/login" class="fw-bold text-decoration-none" style="color:#3282b8;">Login here</a>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function togglePass(id, btn) {
        const input = document.getElementById(id);
        const icon = btn.querySelector('i');
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.replace('fa-eye-slash', 'fa-eye');
        }
    }

    document.getElementById('registerForm').addEventListener('submit', function(e) {
        let valid = true;

        // Name: only letters and spaces
        const name = document.getElementById('name');
        const nameError = document.getElementById('nameError');
        if (!name.value.trim()) {
            nameError.textContent = 'Full name is required.';
            name.classList.add('is-invalid');
            valid = false;
        } else if (!/^[A-Za-z ]+$/.test(name.value.trim())) {
            nameError.textContent = 'Name must contain only letters and spaces.';
            name.classList.add('is-invalid');
            valid = false;
        } else if (name.value.trim().length < 2) {
            nameError.textContent = 'Name must be at least 2 characters.';
            name.classList.add('is-invalid');
            valid = false;
        } else {
            name.classList.remove('is-invalid');
            nameError.textContent = '';
        }

        // Email
        const email = document.getElementById('email');
        const emailError = document.getElementById('emailError');
        const emailRegex = /^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/;
        if (!email.value.trim()) {
            emailError.textContent = 'Email is required.';
            email.classList.add('is-invalid');
            valid = false;
        } else if (!emailRegex.test(email.value.trim())) {
            emailError.textContent = 'Please enter a valid email address.';
            email.classList.add('is-invalid');
            valid = false;
        } else {
            email.classList.remove('is-invalid');
            emailError.textContent = '';
        }

        // Phone: exactly 10 digits
        const phone = document.getElementById('phone');
        const phoneError = document.getElementById('phoneError');
        if (!phone.value.trim()) {
            phoneError.textContent = 'Phone number is required.';
            phone.classList.add('is-invalid');
            valid = false;
        } else if (!/^\d{10}$/.test(phone.value.trim())) {
            phoneError.textContent = 'Phone number must be exactly 10 digits (numbers only, no spaces or dashes).';
            phone.classList.add('is-invalid');
            valid = false;
        } else {
            phone.classList.remove('is-invalid');
            phoneError.textContent = '';
        }

        // Password: 6-20 chars, no spaces
        const password = document.getElementById('password');
        const passError = document.getElementById('passError');
        if (!password.value) {
            passError.textContent = 'Password is required.';
            password.classList.add('is-invalid');
            valid = false;
        } else if (password.value.length < 6) {
            passError.textContent = 'Password must be at least 6 characters.';
            password.classList.add('is-invalid');
            valid = false;
        } else if (password.value.length > 20) {
            passError.textContent = 'Password must not exceed 20 characters.';
            password.classList.add('is-invalid');
            valid = false;
        } else if (password.value.includes(' ')) {
            passError.textContent = 'Password must not contain spaces.';
            password.classList.add('is-invalid');
            valid = false;
        } else {
            password.classList.remove('is-invalid');
            passError.textContent = '';
        }

        // Confirm password match
        const confirmPassword = document.getElementById('confirmPassword');
        const confirmError = document.getElementById('confirmError');
        if (!confirmPassword.value) {
            confirmError.textContent = 'Please confirm your password.';
            confirmPassword.classList.add('is-invalid');
            valid = false;
        } else if (password.value !== confirmPassword.value) {
            confirmError.textContent = 'Passwords do not match.';
            confirmPassword.classList.add('is-invalid');
            valid = false;
        } else {
            confirmPassword.classList.remove('is-invalid');
            confirmError.textContent = '';
        }

        if (!valid) e.preventDefault();
    });

    // Phone: allow only digits while typing
    document.getElementById('phone').addEventListener('input', function() {
        this.value = this.value.replace(/\D/g, '');
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
