package com.pams.dao;

import com.pams.config.DBConnection;
import com.pams.model.Complaint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ComplaintDAO - All database operations for 'complaints' table using raw JDBC.
 */
@Repository
public class ComplaintDAO {

    @Autowired
    private DBConnection dbConnection;

    // Helper: map a ResultSet row to a Complaint object (includes joined user name)
    private Complaint mapRow(ResultSet rs) throws SQLException {
        Complaint c = new Complaint();
        c.setId(rs.getLong("id"));
        c.setAssetName(rs.getString("asset_name"));
        c.setLocation(rs.getString("location"));
        c.setDescription(rs.getString("description"));
        Date fd = rs.getDate("fault_date");
        if (fd != null) c.setFaultDate(fd.toLocalDate());
        c.setImageUrl(rs.getString("image_url"));
        c.setStatus(rs.getString("status"));
        c.setAdminMessage(rs.getString("admin_message"));
        c.setUserId(rs.getLong("user_id"));
        long techId = rs.getLong("technician_id");
        if (!rs.wasNull()) c.setTechnicianId(techId);
        // Joined columns (may be null if not joined)
        try { c.setUserName(rs.getString("user_name")); } catch (SQLException ignored) {}
        try { c.setTechnicianName(rs.getString("tech_name")); } catch (SQLException ignored) {}
        return c;
    }

    // INSERT a new complaint
    public boolean insertComplaint(Complaint c) {
        String sql = "INSERT INTO complaints (asset_name, location, description, fault_date, image_url, status, user_id) VALUES (?, ?, ?, ?, ?, 'PENDING', ?)";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getAssetName());
            ps.setString(2, c.getLocation());
            ps.setString(3, c.getDescription());
            ps.setDate(4, Date.valueOf(c.getFaultDate()));
            ps.setString(5, c.getImageUrl());
            ps.setLong(6, c.getUserId());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("ComplaintDAO insertComplaint error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // SELECT all complaints with JOIN to get user name
    public List<Complaint> findAll() {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT c.*, u.name AS user_name, t.name AS tech_name " +
                     "FROM complaints c " +
                     "LEFT JOIN users u ON c.user_id = u.id " +
                     "LEFT JOIN technicians t ON c.technician_id = t.id " +
                     "ORDER BY c.created_at DESC";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("ComplaintDAO findAll error: " + e.getMessage());
        }
        return list;
    }

    // SELECT complaints by logged-in user
    public List<Complaint> findByUserId(Long userId) {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT c.*, u.name AS user_name, t.name AS tech_name " +
                     "FROM complaints c " +
                     "LEFT JOIN users u ON c.user_id = u.id " +
                     "LEFT JOIN technicians t ON c.technician_id = t.id " +
                     "WHERE c.user_id = ? ORDER BY c.created_at DESC";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("ComplaintDAO findByUserId error: " + e.getMessage());
        }
        return list;
    }

    // SELECT single complaint by ID
    public Complaint findById(Long id) {
        String sql = "SELECT c.*, u.name AS user_name, t.name AS tech_name " +
                     "FROM complaints c " +
                     "LEFT JOIN users u ON c.user_id = u.id " +
                     "LEFT JOIN technicians t ON c.technician_id = t.id " +
                     "WHERE c.id = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.out.println("ComplaintDAO findById error: " + e.getMessage());
        }
        return null;
    }

    // UPDATE complaint status, admin message, and assigned technician
    // BUSINESS RULE: Once RESOLVED, status cannot be changed back
    public boolean updateStatus(Long id, String newStatus, String adminMessage, Long technicianId) {
        // First check: block if already RESOLVED
        Complaint existing = findById(id);
        if (existing != null && "RESOLVED".equals(existing.getStatus())) {
            System.out.println("ComplaintDAO: Cannot change status of already RESOLVED complaint #" + id);
            return false;
        }
        String sql = "UPDATE complaints SET status = ?, admin_message = ?, technician_id = ? WHERE id = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, adminMessage);
            if (technicianId != null) ps.setLong(3, technicianId);
            else ps.setNull(3, Types.BIGINT);
            ps.setLong(4, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("ComplaintDAO updateStatus error: " + e.getMessage());
            return false;
        }
    }

    // Count complaints by status (for dashboard stats)
    public long countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM complaints WHERE status = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getLong(1);
        } catch (SQLException e) {
            System.out.println("ComplaintDAO countByStatus error: " + e.getMessage());
        }
        return 0;
    }

    // Count user's own complaints by status
    public long countByUserAndStatus(Long userId, String status) {
        String sql = "SELECT COUNT(*) FROM complaints WHERE user_id = ? AND status = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getLong(1);
        } catch (SQLException e) {
            System.out.println("ComplaintDAO countByUserAndStatus error: " + e.getMessage());
        }
        return 0;
    }
}
