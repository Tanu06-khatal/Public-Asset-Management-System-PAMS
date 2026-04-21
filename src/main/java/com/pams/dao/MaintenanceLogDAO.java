package com.pams.dao;

import com.pams.config.DBConnection;
import com.pams.model.MaintenanceLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * MaintenanceLogDAO - SQL operations for 'maintenance_logs' table.
 */
@Repository
public class MaintenanceLogDAO {

    @Autowired
    private DBConnection dbConnection;

    private MaintenanceLog mapRow(ResultSet rs) throws SQLException {
        MaintenanceLog log = new MaintenanceLog();
        log.setId(rs.getLong("id"));
        log.setComplaintId(rs.getLong("complaint_id"));
        long techId = rs.getLong("technician_id");
        if (!rs.wasNull()) log.setTechnicianId(techId);
        log.setActionTaken(rs.getString("action_taken"));
        Timestamp ts = rs.getTimestamp("log_date");
        if (ts != null) log.setLogDate(ts.toLocalDateTime());
        try { log.setTechnicianName(rs.getString("tech_name")); } catch (SQLException ignored) {}
        return log;
    }

    // INSERT a new maintenance log entry
    public boolean insert(MaintenanceLog log) {
        String sql = "INSERT INTO maintenance_logs (complaint_id, technician_id, action_taken) VALUES (?, ?, ?)";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, log.getComplaintId());
            if (log.getTechnicianId() != null) ps.setLong(2, log.getTechnicianId());
            else ps.setNull(2, Types.BIGINT);
            ps.setString(3, log.getActionTaken());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("MaintenanceLogDAO insert error: " + e.getMessage());
            return false;
        }
    }

    // SELECT all logs for a specific complaint (with JOIN to get technician name)
    public List<MaintenanceLog> findByComplaintId(Long complaintId) {
        List<MaintenanceLog> list = new ArrayList<>();
        String sql = "SELECT ml.*, t.name AS tech_name " +
                     "FROM maintenance_logs ml " +
                     "LEFT JOIN technicians t ON ml.technician_id = t.id " +
                     "WHERE ml.complaint_id = ? " +
                     "ORDER BY ml.log_date DESC";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, complaintId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("MaintenanceLogDAO findByComplaintId error: " + e.getMessage());
        }
        return list;
    }

    // SELECT all logs (admin view)
    public List<MaintenanceLog> findAll() {
        List<MaintenanceLog> list = new ArrayList<>();
        String sql = "SELECT ml.*, t.name AS tech_name FROM maintenance_logs ml " +
                     "LEFT JOIN technicians t ON ml.technician_id = t.id ORDER BY ml.log_date DESC";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("MaintenanceLogDAO findAll error: " + e.getMessage());
        }
        return list;
    }
}
