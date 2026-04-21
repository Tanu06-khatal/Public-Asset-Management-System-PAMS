package com.pams.model;

import java.time.LocalDate;

/**
 * Asset - represents a public asset (streetlight, road, pump etc.)
 * Maps to the 'assets' table in MySQL.
 */
public class Asset {

    private Long id;
    private String assetName;
    private String assetType;
    private String location;
    private LocalDate installedOn;
    private String status;  // "ACTIVE", "UNDER_MAINTENANCE", "DECOMMISSIONED"

    public Asset() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }

    public String getAssetType() { return assetType; }
    public void setAssetType(String assetType) { this.assetType = assetType; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public LocalDate getInstalledOn() { return installedOn; }
    public void setInstalledOn(LocalDate installedOn) { this.installedOn = installedOn; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
