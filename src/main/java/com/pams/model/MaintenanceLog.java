package com.pams.model;

import java.time.LocalDateTime;

/**
 * MaintenanceLog - logs every action taken on a complaint by a technician.
 * Maps to the 'maintenance_logs' table in MySQL.
 */
public class MaintenanceLog {

    private Long id;
    private Long complaintId;
    private Long technicianId;
    private String technicianName; // Joined from technicians table for display
    private String actionTaken;
    private LocalDateTime logDate;

    public MaintenanceLog() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getComplaintId() { return complaintId; }
    public void setComplaintId(Long complaintId) { this.complaintId = complaintId; }

    public Long getTechnicianId() { return technicianId; }
    public void setTechnicianId(Long technicianId) { this.technicianId = technicianId; }

    public String getTechnicianName() { return technicianName; }
    public void setTechnicianName(String technicianName) { this.technicianName = technicianName; }

    public String getActionTaken() { return actionTaken; }
    public void setActionTaken(String actionTaken) { this.actionTaken = actionTaken; }

    public LocalDateTime getLogDate() { return logDate; }
    public void setLogDate(LocalDateTime logDate) { this.logDate = logDate; }
}
