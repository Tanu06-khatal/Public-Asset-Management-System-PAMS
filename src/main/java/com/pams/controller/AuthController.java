package com.pams.controller;

import com.pams.model.User;
import com.pams.service.EmailService;
import com.pams.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private EmailService emailService;

    @GetMapping("/")
    public String home() { return "index"; }

    @GetMapping("/about")
    public String about() { return "about"; }

    @GetMapping("/contact")
    public String contact() { return "contact"; }

    // ---- LOGIN ----

    @GetMapping("/login")
    public String showLoginForm() { return "login"; }

    @PostMapping("/login")
    public String processLogin(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session, Model model) {

        // Basic empty-field check
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Email/Phone and Password are required.");
            return "login";
        }

        User user = userService.validateLogin(email.trim(), password);
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            if ("ADMIN".equals(user.getRole())) return "redirect:/admin/dashboard";
            return "redirect:/dashboard";
        }

        model.addAttribute("error", "Invalid email/phone or password. Please try again.");
        return "login";
    }

    // ---- REGISTER ----

    @GetMapping("/register")
    public String showRegisterForm() { return "register"; }

    @PostMapping("/register")
    public String processRegister(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String phoneNumber,
            @RequestParam String password,
            @RequestParam(defaultValue = "USER") String role,
            Model model) {

        // UserService handles all validations and returns error string or null
        String error = userService.registerUser(name, email, phoneNumber, password, role);
        if (error != null) {
            model.addAttribute("error", error);
            // Pass back what user typed so they don't retype everything
            model.addAttribute("nameVal", name);
            model.addAttribute("emailVal", email);
            model.addAttribute("phoneVal", phoneNumber);
            return "register";
        }

        model.addAttribute("success", "Account created successfully! You can now login.");
        return "redirect:/login?registered=true";
    }

    // ---- FORGOT PASSWORD ----

    @GetMapping("/forgot-password")
    public String showForgotPassword() { return "forgot-password"; }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam String email, Model model) {
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("error", "Please enter your email address.");
            return "forgot-password";
        }
        String token = userService.createPasswordResetToken(email.trim().toLowerCase());
        if (token != null) {
            emailService.sendPasswordResetLink(email.trim(), token);
            model.addAttribute("message", "Password reset link has been sent to your email.");
        } else {
            model.addAttribute("error", "No account found with that email address.");
        }
        return "forgot-password";
    }

    // ---- RESET PASSWORD ----

    @GetMapping("/reset-password")
    public String showResetPassword(@RequestParam String token, Model model) {
        model.addAttribute("token", token);
        return "reset-password";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(
            @RequestParam String token,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            Model model) {

        if (password == null || password.length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters.");
            model.addAttribute("token", token);
            return "reset-password";
        }
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match.");
            model.addAttribute("token", token);
            return "reset-password";
        }

        if (userService.resetPassword(token, password)) {
            return "redirect:/login?reset=success";
        }
        model.addAttribute("error", "Invalid or expired reset link. Please request a new one.");
        model.addAttribute("token", token);
        return "reset-password";
    }

    // ---- LOGOUT ----

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
