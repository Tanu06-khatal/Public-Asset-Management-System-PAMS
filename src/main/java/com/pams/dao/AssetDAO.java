package com.pams.dao;

import com.pams.config.DBConnection;
import com.pams.model.Asset;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * AssetDAO - All SQL operations for the 'assets' table.
 */
@Repository
public class AssetDAO {

    @Autowired
    private DBConnection dbConnection;

    private Asset mapRow(ResultSet rs) throws SQLException {
        Asset a = new Asset();
        a.setId(rs.getLong("id"));
        a.setAssetName(rs.getString("asset_name"));
        a.setAssetType(rs.getString("asset_type"));
        a.setLocation(rs.getString("location"));
        Date d = rs.getDate("installed_on");
        if (d != null) a.setInstalledOn(d.toLocalDate());
        a.setStatus(rs.getString("status"));
        return a;
    }

    // INSERT a new asset
    public boolean insert(Asset a) {
        String sql = "INSERT INTO assets (asset_name, asset_type, location, installed_on, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, a.getAssetName());
            ps.setString(2, a.getAssetType());
            ps.setString(3, a.getLocation());
            if (a.getInstalledOn() != null) ps.setDate(4, Date.valueOf(a.getInstalledOn()));
            else ps.setNull(4, Types.DATE);
            ps.setString(5, a.getStatus());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("AssetDAO insert error: " + e.getMessage());
            return false;
        }
    }

    // SELECT all assets
    public List<Asset> findAll() {
        List<Asset> list = new ArrayList<>();
        String sql = "SELECT * FROM assets ORDER BY asset_name ASC";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("AssetDAO findAll error: " + e.getMessage());
        }
        return list;
    }

    // UPDATE asset status
    public void updateStatus(Long id, String status) {
        String sql = "UPDATE assets SET status = ? WHERE id = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("AssetDAO updateStatus error: " + e.getMessage());
        }
    }

    // DELETE an asset
    public void delete(Long id) {
        String sql = "DELETE FROM assets WHERE id = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("AssetDAO delete error: " + e.getMessage());
        }
    }
}
