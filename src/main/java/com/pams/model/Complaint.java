package com.pams.model;

import java.time.LocalDate;

/**
 * Complaint - represents a complaint raised by a citizen about a public asset.
 * Maps to the 'complaints' table in MySQL.
 * No JPA annotations - uses plain JDBC via DAOs.
 */
public class Complaint {

    private Long id;
    private String assetName;
    private String location;
    private String description;
    private LocalDate faultDate;
    private String imageUrl;
    private String status;        // "PENDING", "IN_PROGRESS", "RESOLVED"
    private String adminMessage;
    private Long userId;
    private Long technicianId;

    // Joined fields for display (not stored, populated via SQL JOIN)
    private String userName;
    private String technicianName;

    public Complaint() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDate getFaultDate() { return faultDate; }
    public void setFaultDate(LocalDate faultDate) { this.faultDate = faultDate; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAdminMessage() { return adminMessage; }
    public void setAdminMessage(String adminMessage) { this.adminMessage = adminMessage; }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public Long getTechnicianId() { return technicianId; }
    public void setTechnicianId(Long technicianId) { this.technicianId = technicianId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getTechnicianName() { return technicianName; }
    public void setTechnicianName(String technicianName) { this.technicianName = technicianName; }
}
