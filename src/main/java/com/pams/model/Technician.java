package com.pams.model;

/**
 * Technician - represents a field worker who handles complaint resolution.
 * Maps to the 'technicians' table in MySQL.
 */
public class Technician {

    private Long id;
    private String name;
    private String phoneNumber;
    private String specialization;
    private boolean available;

    public Technician() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }
}
