package com.pams.controller;

import com.pams.dao.AssetDAO;
import com.pams.dao.MaintenanceLogDAO;
import com.pams.dao.TechnicianDAO;
import com.pams.model.*;
import com.pams.service.ComplaintService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Controller
public class ComplaintController {

    @Autowired
    private ComplaintService complaintService;

    @Autowired
    private TechnicianDAO technicianDAO;

    @Autowired
    private AssetDAO assetDAO;

    @Autowired
    private MaintenanceLogDAO maintenanceLogDAO;

    public static String UPLOAD_DIRECTORY = System.getProperty("user.dir") + "/uploads";

    // ---- USER DASHBOARD ----

    @GetMapping("/dashboard")
    public String userDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        long total   = complaintService.getComplaintsByUser(user.getId()).size();
        long pending  = complaintService.countByUserAndStatus(user.getId(), "PENDING");
        long progress = complaintService.countByUserAndStatus(user.getId(), "IN_PROGRESS");
        long resolved = complaintService.countByUserAndStatus(user.getId(), "RESOLVED");

        model.addAttribute("totalComplaints", total);
        model.addAttribute("pendingComplaints", pending);
        model.addAttribute("inProgressComplaints", progress);
        model.addAttribute("resolvedComplaints", resolved);
        return "dashboard";
    }

    // ---- RAISE COMPLAINT ----

    @GetMapping("/raise-complaint")
    public String showRaiseComplaintForm(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        return "raise-complaint";
    }

    @PostMapping("/raise-complaint")
    public String submitComplaint(
            HttpSession session,
            @RequestParam("assetName") String assetName,
            @RequestParam("location") String location,
            @RequestParam("description") String description,
            @RequestParam("faultDate") String faultDateStr,
            @RequestParam(value = "image", required = false) MultipartFile image,
            Model model) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // --- Validations ---
        if (assetName == null || assetName.trim().isEmpty()) {
            model.addAttribute("error", "Asset name is required.");
            return "raise-complaint";
        }
        if (location == null || location.trim().isEmpty()) {
            model.addAttribute("error", "Location is required.");
            return "raise-complaint";
        }
        if (description == null || description.trim().length() < 10) {
            model.addAttribute("error", "Please provide a detailed description (at least 10 characters).");
            return "raise-complaint";
        }
        if (faultDateStr == null || faultDateStr.isEmpty()) {
            model.addAttribute("error", "Fault date is required.");
            return "raise-complaint";
        }
        LocalDate faultDate;
        try {
            faultDate = LocalDate.parse(faultDateStr);
            if (faultDate.isAfter(LocalDate.now())) {
                model.addAttribute("error", "Fault date cannot be in the future.");
                return "raise-complaint";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Invalid date format.");
            return "raise-complaint";
        }

        Complaint complaint = new Complaint();
        complaint.setAssetName(assetName.trim());
        complaint.setLocation(location.trim());
        complaint.setDescription(description.trim());
        complaint.setFaultDate(faultDate);
        complaint.setStatus("PENDING");
        complaint.setUserId(user.getId());

        // Save image file to /uploads folder
        if (image != null && !image.isEmpty()) {
            String originalFilename = image.getOriginalFilename();
            if (originalFilename != null && (originalFilename.endsWith(".jpg") ||
                    originalFilename.endsWith(".jpeg") || originalFilename.endsWith(".png"))) {
                try {
                    File dir = new File(UPLOAD_DIRECTORY);
                    if (!dir.exists()) dir.mkdirs();
                    String filename = UUID.randomUUID().toString() + "_" + originalFilename;
                    Path filePath = Paths.get(UPLOAD_DIRECTORY, filename);
                    Files.write(filePath, image.getBytes());
                    complaint.setImageUrl(filename);
                } catch (IOException e) {
                    System.out.println("Image upload error: " + e.getMessage());
                }
            } else if (originalFilename != null && !originalFilename.isEmpty()) {
                model.addAttribute("error", "Only JPG, JPEG, and PNG images are allowed.");
                return "raise-complaint";
            }
        }

        boolean saved = complaintService.saveComplaint(complaint);
        if (!saved) {
            model.addAttribute("error", "Failed to submit complaint. Please check your database connection and try again.");
            return "raise-complaint";
        }
        return "redirect:/my-complaints?submitted=true";
    }

    // ---- MY COMPLAINTS (User) ----

    @GetMapping("/my-complaints")
    public String myComplaints(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        List<Complaint> complaints = complaintService.getComplaintsByUser(user.getId());
        model.addAttribute("complaints", complaints);
        return "my-complaints";
    }

    // ---- VIEW COMPLAINT DETAILS ----
    @GetMapping("/complaint/{id}")
    public String viewComplaint(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        Complaint complaint = complaintService.getComplaintById(id);
        // Null-safe check: ensure complaint exists and belongs to this user (or user is ADMIN)
        if (complaint == null) return "redirect:/my-complaints";
        boolean isOwner  = complaint.getUserId() != null && complaint.getUserId().equals(user.getId());
        boolean isAdmin  = "ADMIN".equals(user.getRole());
        if (!isOwner && !isAdmin) return "redirect:/my-complaints";
        List<MaintenanceLog> logs = maintenanceLogDAO.findByComplaintId(id);
        model.addAttribute("complaint", complaint);
        model.addAttribute("logs", logs);
        return "complaint-detail";
    }

    // ---- ADMIN DASHBOARD ----

    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";

        model.addAttribute("totalComplaints",    complaintService.countByStatus("PENDING") +
                                                 complaintService.countByStatus("IN_PROGRESS") +
                                                 complaintService.countByStatus("RESOLVED"));
        model.addAttribute("pendingComplaints",  complaintService.countByStatus("PENDING"));
        model.addAttribute("inProgressComplaints", complaintService.countByStatus("IN_PROGRESS"));
        model.addAttribute("resolvedComplaints", complaintService.countByStatus("RESOLVED"));
        return "admin-dashboard";
    }

    // ---- ADMIN MANAGE COMPLAINTS ----

    @GetMapping("/admin/manage-complaints")
    public String manageComplaints(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        model.addAttribute("complaints", complaintService.getAllComplaints());
        model.addAttribute("technicians", technicianDAO.findAll());
        return "admin-manage";
    }

    // UPDATE complaint status (RESOLVED lock enforced in service/DAO)
    @PostMapping("/admin/update-status")
    public String updateStatus(
            HttpSession session,
            @RequestParam("id") Long id,
            @RequestParam("status") String status,
            @RequestParam(value = "adminMessage", required = false) String adminMessage,
            @RequestParam(value = "technicianId", required = false) Long technicianId) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";

        complaintService.updateStatus(id, status, adminMessage, technicianId);
        return "redirect:/admin/manage-complaints";
    }

    // ---- ADMIN - MANAGE TECHNICIANS ----

    @GetMapping("/admin/technicians")
    public String manageTechnicians(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        model.addAttribute("technicians", technicianDAO.findAll());
        return "admin-technicians";
    }

    @PostMapping("/admin/technicians/add")
    public String addTechnician(
            HttpSession session,
            @RequestParam("name") String name,
            @RequestParam("phoneNumber") String phone,
            @RequestParam("specialization") String spec,
            Model model) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";

        if (!name.matches("[A-Za-z ]+")) {
            model.addAttribute("error", "Technician name must contain only letters.");
            model.addAttribute("technicians", technicianDAO.findAll());
            return "admin-technicians";
        }
        if (!phone.matches("\\d{10}")) {
            model.addAttribute("error", "Phone number must be exactly 10 digits.");
            model.addAttribute("technicians", technicianDAO.findAll());
            return "admin-technicians";
        }

        Technician t = new Technician();
        t.setName(name.trim());
        t.setPhoneNumber(phone.trim());
        t.setSpecialization(spec.trim());
        t.setAvailable(true);
        technicianDAO.insert(t);
        return "redirect:/admin/technicians";
    }

    @GetMapping("/admin/technicians/delete/{id}")
    public String deleteTechnician(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        technicianDAO.delete(id);
        return "redirect:/admin/technicians";
    }

    // ---- ADMIN - MANAGE ASSETS ----

    @GetMapping("/admin/assets")
    public String manageAssets(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        model.addAttribute("assets", assetDAO.findAll());
        return "admin-assets";
    }

    @PostMapping("/admin/assets/add")
    public String addAsset(
            HttpSession session,
            @RequestParam("assetName") String assetName,
            @RequestParam("assetType") String assetType,
            @RequestParam("location") String location,
            @RequestParam(value = "installedOn", required = false) String installedOnStr,
            Model model) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";

        Asset a = new Asset();
        a.setAssetName(assetName.trim());
        a.setAssetType(assetType.trim());
        a.setLocation(location.trim());
        a.setStatus("ACTIVE");
        if (installedOnStr != null && !installedOnStr.isEmpty()) {
            try { a.setInstalledOn(LocalDate.parse(installedOnStr)); } catch (Exception ignored) {}
        }
        assetDAO.insert(a);
        return "redirect:/admin/assets";
    }

    @GetMapping("/admin/assets/delete/{id}")
    public String deleteAsset(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        assetDAO.delete(id);
        return "redirect:/admin/assets";
    }

    // ---- ADMIN - MAINTENANCE LOGS ----

    @GetMapping("/admin/maintenance-logs")
    public String maintenanceLogs(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        model.addAttribute("logs", maintenanceLogDAO.findAll());
        return "admin-logs";
    }
}
