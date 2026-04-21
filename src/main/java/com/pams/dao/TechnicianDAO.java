package com.pams.dao;

import com.pams.config.DBConnection;
import com.pams.model.Technician;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * TechnicianDAO - All SQL operations for the 'technicians' table.
 */
@Repository
public class TechnicianDAO {

    @Autowired
    private DBConnection dbConnection;

    private Technician mapRow(ResultSet rs) throws SQLException {
        Technician t = new Technician();
        t.setId(rs.getLong("id"));
        t.setName(rs.getString("name"));
        t.setPhoneNumber(rs.getString("phone_number"));
        t.setSpecialization(rs.getString("specialization"));
        t.setAvailable(rs.getBoolean("available"));
        return t;
    }

    // INSERT a new technician
    public boolean insert(Technician t) {
        String sql = "INSERT INTO technicians (name, phone_number, specialization, available) VALUES (?, ?, ?, ?)";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getName());
            ps.setString(2, t.getPhoneNumber());
            ps.setString(3, t.getSpecialization());
            ps.setBoolean(4, t.isAvailable());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("TechnicianDAO insert error: " + e.getMessage());
            return false;
        }
    }

    // SELECT all technicians
    public List<Technician> findAll() {
        List<Technician> list = new ArrayList<>();
        String sql = "SELECT * FROM technicians ORDER BY name ASC";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("TechnicianDAO findAll error: " + e.getMessage());
        }
        return list;
    }

    // SELECT only available technicians (for assigning)
    public List<Technician> findAvailable() {
        List<Technician> list = new ArrayList<>();
        String sql = "SELECT * FROM technicians WHERE available = TRUE ORDER BY name ASC";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("TechnicianDAO findAvailable error: " + e.getMessage());
        }
        return list;
    }

    // SELECT technician by ID
    public Technician findById(Long id) {
        String sql = "SELECT * FROM technicians WHERE id = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.out.println("TechnicianDAO findById error: " + e.getMessage());
        }
        return null;
    }

    // UPDATE technician availability
    public void updateAvailability(Long id, boolean available) {
        String sql = "UPDATE technicians SET available = ? WHERE id = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, available);
            ps.setLong(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("TechnicianDAO updateAvailability error: " + e.getMessage());
        }
    }

    // DELETE a technician
    public void delete(Long id) {
        String sql = "DELETE FROM technicians WHERE id = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("TechnicianDAO delete error: " + e.getMessage());
        }
    }
}
