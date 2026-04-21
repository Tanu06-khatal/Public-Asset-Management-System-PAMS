package com.pams.service;

import com.pams.dao.ComplaintDAO;
import com.pams.dao.MaintenanceLogDAO;
import com.pams.dao.TechnicianDAO;
import com.pams.model.Complaint;
import com.pams.model.MaintenanceLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ComplaintService - Business logic for complaint operations.
 * Uses ComplaintDAO and MaintenanceLogDAO (raw SQL).
 */
@Service
public class ComplaintService {

    @Autowired
    private ComplaintDAO complaintDAO;

    @Autowired
    private MaintenanceLogDAO maintenanceLogDAO;

    @Autowired
    private TechnicianDAO technicianDAO;

    public boolean saveComplaint(Complaint complaint) {
        return complaintDAO.insertComplaint(complaint);
    }

    public List<Complaint> getComplaintsByUser(Long userId) {
        return complaintDAO.findByUserId(userId);
    }

    public List<Complaint> getAllComplaints() {
        return complaintDAO.findAll();
    }

    public Complaint getComplaintById(Long id) {
        return complaintDAO.findById(id);
    }

    /**
     * Updates complaint status. Enforces:
     * - RESOLVED status is final (cannot be changed back).
     * - Auto-creates a maintenance log entry when status changes.
     */
    public boolean updateStatus(Long complaintId, String newStatus, String adminMessage, Long technicianId) {
        // Check resolved lock
        Complaint existing = complaintDAO.findById(complaintId);
        if (existing == null) return false;
        if ("RESOLVED".equals(existing.getStatus())) return false;

        boolean updated = complaintDAO.updateStatus(complaintId, newStatus, adminMessage, technicianId);
        if (updated) {
            // Auto-log status change in maintenance_logs table
            MaintenanceLog log = new MaintenanceLog();
            log.setComplaintId(complaintId);
            log.setTechnicianId(technicianId);
            log.setActionTaken("Status changed to " + newStatus +
                    (adminMessage != null && !adminMessage.isEmpty() ? ". Note: " + adminMessage : ""));
            maintenanceLogDAO.insert(log);

            // Update Technician Availability
            if (technicianId != null) {
                // If technician changed, make old technician available again
                if (existing.getTechnicianId() != null && !existing.getTechnicianId().equals(technicianId)) {
                    technicianDAO.updateAvailability(existing.getTechnicianId(), true);
                }

                if ("RESOLVED".equals(newStatus)) {
                    technicianDAO.updateAvailability(technicianId, true);
                } else {
                    technicianDAO.updateAvailability(technicianId, false);
                }
            } else if (existing.getTechnicianId() != null) {
                 // if technician is unassigned, make previous technician available again
                 technicianDAO.updateAvailability(existing.getTechnicianId(), true);
            }
        }
        return updated;
    }

    public long countByStatus(String status) {
        return complaintDAO.countByStatus(status);
    }

    public long countByUserAndStatus(Long userId, String status) {
        return complaintDAO.countByUserAndStatus(userId, status);
    }

    public List<Complaint> findAll() {
        return complaintDAO.findAll();
    }
}
