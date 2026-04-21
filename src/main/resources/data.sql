-- 1. Insert dummy users
INSERT IGNORE INTO users (id, name, email, phone_number, password, role, created_at) VALUES 
(100, 'Admin User', 'admin@pams.com', '9999999999', 'admin123', 'ADMIN', NOW()),
(101, 'Vedant Joshi', 'vedant@example.com', '9876543210', 'password123', 'USER', NOW()),
(102, 'Priya Kulkarni', 'priya.k@example.com', '8888888888', 'password123', 'USER', NOW()),
(103, 'Saurabh Deshmukh', 'saurabh.d@example.com', '7777777777', 'password123', 'USER', NOW()),
(104, 'Neha Chavan', 'neha.c@example.com', '6666666666', 'password123', 'USER', NOW()),
(105, 'Tanuja Khatal', 'tanuja@example.com', '5555555555', 'password123', 'USER', NOW());

-- 2. Insert dummy technicians
INSERT IGNORE INTO technicians (id, name, phone_number, specialization, available, created_at) VALUES 
(100, 'Ramesh Patil', '8111111111', 'Electrical', TRUE, NOW()),
(101, 'Suresh Kadam', '8111111112', 'Plumbing', TRUE, NOW()),
(102, 'Ganesh Shinde', '8111111113', 'Road Maintenance', FALSE, NOW()),
(103, 'Santosh Pawar', '8111111114', 'Civil', TRUE, NOW()),
(104, 'Amit Gaikwad', '8111111115', 'Electrical', TRUE, NOW());

-- 3. Insert dummy assets
INSERT IGNORE INTO assets (id, asset_name, asset_type, location, installed_on, status, created_at) VALUES 
(100, 'Street Light Pole A1', 'Streetlight', 'Karve Road, Kothrud, Pune', '2022-01-15', 'ACTIVE', NOW()),
(101, 'Water Pump 5HP', 'Water Supply', 'FC Road, Shivajinagar, Pune', '2021-05-20', 'MAINTENANCE', NOW()),
(102, 'Public Park Bench', 'Furniture', 'Saras Baug, Swargate, Pune', '2020-11-10', 'ACTIVE', NOW()),
(103, 'Road Junction Signal', 'Signal', 'Hinjewadi Phase 1, Pune', '2023-02-05', 'DAMAGED', NOW()),
(104, 'Drainage Cover', 'Infrastructure', 'Baner Road, near D Mart, Pune', '2019-08-14', 'ACTIVE', NOW()),
(105, 'Street Light Pole B2', 'Streetlight', 'Viman Nagar, Pune', '2022-06-11', 'ACTIVE', NOW()),
(106, 'Bus Stop Shelter', 'Infrastructure', 'Magarpatta City, Hadapsar, Pune', '2018-03-22', 'ACTIVE', NOW()),
(107, 'Water Tank Valve', 'Water Supply', 'Wakad Bridge, Pune', '2021-09-30', 'MAINTENANCE', NOW());

-- 4. Insert dummy complaints
INSERT IGNORE INTO complaints (id, asset_name, location, description, fault_date, status, user_id, technician_id, created_at) VALUES 
(100, 'Street Light Pole A1', 'Karve Road, Kothrud, Pune', 'The light is flickering continuously since last night.', '2024-05-01', 'RESOLVED', 101, 100, NOW()),
(101, 'Water Pump 5HP', 'FC Road, Shivajinagar, Pune', 'Water pump is leaking heavily, wasting water.', '2024-05-15', 'IN_PROGRESS', 102, 101, NOW()),
(102, 'Road Junction Signal', 'Hinjewadi Phase 1, Pune', 'The red light on the signal is completely broken.', '2024-05-20', 'PENDING', 103, NULL, NOW()),
(103, 'Drainage Cover', 'Baner Road, near D Mart, Pune', 'The cover is cracked, potential accident risk.', '2024-05-22', 'PENDING', 104, NULL, NOW()),
(104, 'Water Tank Valve', 'Wakad Bridge, Pune', 'Valve is stuck and no water is coming through.', '2024-05-18', 'IN_PROGRESS', 101, 101, NOW());

-- 5. Insert dummy maintenance_logs
INSERT IGNORE INTO maintenance_logs (id, complaint_id, technician_id, action_taken, log_date) VALUES 
(100, 100, 100, 'Inspected the connection, replaced the faulty bulb.', '2024-05-02 10:30:00'),
(101, 100, 100, 'Testing done, issues resolved and case closed.', '2024-05-02 11:45:00'),
(102, 101, 101, 'Visited the site, need to bring a replacement valve sealing kit.', '2024-05-16 14:00:00'),
(103, 104, 101, 'Applied rust remover on valve, will need a day to check if it loosens up.', '2024-05-19 09:30:00'),
(104, 105, 105, 'Inspected fountain, scheduled repair.', '2024-06-02 10:00:00');

-- Additional dummy users
INSERT IGNORE INTO users (id, name, email, phone_number, password, role, created_at) VALUES 
(106, 'Arjun Patel', 'arjun@example.com', '3333333333', 'password123', 'USER', NOW()),
(107, 'Kavita Rao', 'kavita@example.com', '2222222222', 'password123', 'USER', NOW()),
(108, 'Mohan Gupta', 'mohan@example.com', '1111111111', 'password123', 'USER', NOW()),
(109, 'Sneha Iyer', 'sneha@example.com', '0000000000', 'password123', 'USER', NOW()),
(110, 'Vikram Singh', 'vikram@example.com', '9999999998', 'password123', 'USER', NOW());

-- Additional dummy technicians
INSERT IGNORE INTO technicians (id, name, phone_number, specialization, available, created_at) VALUES 
(105, 'Vikram Singh', '8111111116', 'Mechanical', TRUE, NOW()),
(106, 'Anita Desai', '8111111117', 'Electrical', TRUE, NOW()),
(107, 'Rajesh Kumar', '8111111118', 'Plumbing', FALSE, NOW()),
(108, 'Poonam Sharma', '8111111119', 'Civil', TRUE, NOW()),
(109, 'Deepak Jain', '8111111120', 'Road Maintenance', TRUE, NOW());

-- Additional dummy assets
INSERT IGNORE INTO assets (id, asset_name, asset_type, location, installed_on, status, created_at) VALUES 
(108, 'Park Fountain', 'Water Feature', 'Central Park, Pune', '2023-07-10', 'ACTIVE', NOW()),
(109, 'Traffic Light C3', 'Signal', 'Aundh Road, Pune', '2022-09-15', 'DAMAGED', NOW()),
(110, 'Garden Lamp Post', 'Streetlight', 'Botanical Garden, Pune', '2021-12-01', 'ACTIVE', NOW()),
(111, 'Sewage Pump', 'Water Supply', 'Koregaon Park, Pune', '2020-04-20', 'MAINTENANCE', NOW()),
(112, 'Playground Swing', 'Furniture', 'Children Park, Hadapsar, Pune', '2019-06-30', 'ACTIVE', NOW()),
(113, 'Bridge Rail', 'Infrastructure', 'Mula River Bridge, Pune', '2018-11-05', 'DAMAGED', NOW()),
(114, 'Public Toilet', 'Facility', 'Station Road, Pune', '2023-01-10', 'ACTIVE', NOW()),
(115, 'Fire Hydrant', 'Safety', 'Market Yard, Pune', '2022-03-25', 'ACTIVE', NOW());

-- Additional dummy complaints
INSERT IGNORE INTO complaints (id, asset_name, location, description, fault_date, status, user_id, technician_id, created_at) VALUES 
(105, 'Park Fountain', 'Central Park, Pune', 'Fountain not working, no water flow.', '2024-06-01', 'PENDING', 105, NULL, NOW()),
(106, 'Traffic Light C3', 'Aundh Road, Pune', 'Light is stuck on red.', '2024-06-05', 'IN_PROGRESS', 106, 106, NOW()),
(107, 'Garden Lamp Post', 'Botanical Garden, Pune', 'Lamp flickering intermittently.', '2024-06-10', 'RESOLVED', 107, 100, NOW()),
(108, 'Sewage Pump', 'Koregaon Park, Pune', 'Pump making loud noise.', '2024-06-12', 'PENDING', 108, NULL, NOW()),
(109, 'Playground Swing', 'Children Park, Hadapsar, Pune', 'Swing chain broken.', '2024-06-15', 'IN_PROGRESS', 109, 108, NOW()),
(110, 'Bridge Rail', 'Mula River Bridge, Pune', 'Rail rusted and loose.', '2024-06-18', 'PENDING', 110, NULL, NOW());

-- Additional dummy maintenance_logs
INSERT IGNORE INTO maintenance_logs (id, complaint_id, technician_id, action_taken, log_date) VALUES 
(105, 106, 106, 'Inspected traffic light, replaced faulty bulb.', '2024-06-06 09:00:00'),
(106, 107, 100, 'Fixed wiring, lamp now stable.', '2024-06-11 14:30:00'),
(107, 109, 108, 'Replaced swing chain, tested for safety.', '2024-06-16 11:00:00'),
(108, 110, 109, 'Applied anti-rust coating to bridge rail.', '2024-06-19 13:00:00');

-- Even more dummy users
INSERT IGNORE INTO users (id, name, email, phone_number, password, role, created_at) VALUES 
(111, 'Ravi Kumar', 'ravi@example.com', '7777777776', 'password123', 'USER', NOW()),
(112, 'Meera Joshi', 'meera@example.com', '8888888887', 'password123', 'USER', NOW()),
(113, 'Amit Verma', 'amit@example.com', '9999999997', 'password123', 'USER', NOW()),
(114, 'Priya Singh', 'priya.s@example.com', '6666666667', 'password123', 'USER', NOW()),
(115, 'Sandeep Rao', 'sandeep@example.com', '5555555556', 'password123', 'USER', NOW()),
(116, 'Anjali Gupta', 'anjali@example.com', '4444444445', 'password123', 'USER', NOW()),
(117, 'Rohit Sharma', 'rohit@example.com', '3333333334', 'password123', 'USER', NOW()),
(118, 'Kiran Patel', 'kiran@example.com', '2222222223', 'password123', 'USER', NOW()),
(119, 'Nisha Jain', 'nisha@example.com', '1111111112', 'password123', 'USER', NOW()),
(120, 'Vivek Desai', 'vivek@example.com', '0000000001', 'password123', 'USER', NOW());

-- Even more dummy technicians
INSERT IGNORE INTO technicians (id, name, phone_number, specialization, available, created_at) VALUES 
(110, 'Sunil Mehta', '8111111121', 'Electrical', TRUE, NOW()),
(111, 'Rekha Nair', '8111111122', 'Plumbing', TRUE, NOW()),
(112, 'Karan Yadav', '8111111123', 'Civil', FALSE, NOW()),
(113, 'Lata Choudhary', '8111111124', 'Mechanical', TRUE, NOW()),
(114, 'Harish Tiwari', '8111111125', 'Road Maintenance', TRUE, NOW()),
(115, 'Geeta Saxena', '8111111126', 'Electrical', TRUE, NOW()),
(116, 'Manoj Pandey', '8111111127', 'Plumbing', FALSE, NOW()),
(117, 'Shweta Agarwal', '8111111128', 'Civil', TRUE, NOW()),
(118, 'Rajiv Kapoor', '8111111129', 'Mechanical', TRUE, NOW()),
(119, 'Pallavi Bose', '8111111130', 'Road Maintenance', TRUE, NOW());

-- Even more dummy assets
INSERT IGNORE INTO assets (id, asset_name, asset_type, location, installed_on, status, created_at) VALUES 
(116, 'Community Hall Light', 'Streetlight', 'Wadgaon Sheri, Pune', '2023-08-20', 'ACTIVE', NOW()),
(117, 'Water Fountain', 'Water Supply', 'Lal Mahal, Pune', '2022-11-15', 'MAINTENANCE', NOW()),
(118, 'Park Bench Set', 'Furniture', 'Empress Garden, Pune', '2021-09-10', 'ACTIVE', NOW()),
(119, 'Pedestrian Crossing Signal', 'Signal', 'Sinhagad Road, Pune', '2020-12-05', 'DAMAGED', NOW()),
(120, 'Storm Drain', 'Infrastructure', 'Bund Garden Road, Pune', '2019-07-14', 'ACTIVE', NOW()),
(121, 'LED Billboard', 'Information', 'MG Road, Pune', '2023-04-11', 'ACTIVE', NOW()),
(122, 'Public Clock', 'Utility', 'Shivaji Nagar Square, Pune', '2018-02-22', 'MAINTENANCE', NOW()),
(123, 'Bike Stand', 'Furniture', 'Pune Station, Pune', '2022-10-30', 'ACTIVE', NOW()),
(124, 'Elevated Walkway', 'Infrastructure', 'FC Road Underpass, Pune', '2021-06-05', 'DAMAGED', NOW()),
(125, 'Solar Panel Array', 'Energy', 'Roof of Municipal Building, Pune', '2023-01-15', 'ACTIVE', NOW()),
(126, 'Garbage Bin Station', 'Sanitation', 'Camp Area, Pune', '2020-03-20', 'ACTIVE', NOW()),
(127, 'WiFi Hotspot Pole', 'Technology', 'Deccan Gymkhana, Pune', '2022-05-25', 'MAINTENANCE', NOW()),
(128, 'Public Art Sculpture', 'Aesthetic', 'Jana Gana Mana Square, Pune', '2019-11-10', 'ACTIVE', NOW()),
(129, 'Emergency Phone Booth', 'Safety', 'Lonavala Highway, Pune', '2021-08-14', 'ACTIVE', NOW()),
(130, 'Tree Guard', 'Environmental', 'Aga Khan Palace Grounds, Pune', '2020-04-30', 'DAMAGED', NOW());

-- Even more dummy complaints
INSERT IGNORE INTO complaints (id, asset_name, location, description, fault_date, status, user_id, technician_id, created_at) VALUES 
(111, 'Community Hall Light', 'Wadgaon Sheri, Pune', 'Light not turning on.', '2024-06-20', 'PENDING', 111, NULL, NOW()),
(112, 'Water Fountain', 'Lal Mahal, Pune', 'Fountain clogged.', '2024-06-22', 'IN_PROGRESS', 112, 111, NOW()),
(113, 'Park Bench Set', 'Empress Garden, Pune', 'Bench legs broken.', '2024-06-25', 'RESOLVED', 113, 112, NOW()),
(114, 'Pedestrian Crossing Signal', 'Sinhagad Road, Pune', 'Signal out of sync.', '2024-06-28', 'PENDING', 114, NULL, NOW()),
(115, 'Storm Drain', 'Bund Garden Road, Pune', 'Drain blocked.', '2024-07-01', 'IN_PROGRESS', 115, 114, NOW()),
(116, 'LED Billboard', 'MG Road, Pune', 'Display malfunctioning.', '2024-07-03', 'PENDING', 116, NULL, NOW()),
(117, 'Public Clock', 'Shivaji Nagar Square, Pune', 'Clock stopped.', '2024-07-05', 'RESOLVED', 117, 115, NOW()),
(118, 'Bike Stand', 'Pune Station, Pune', 'Stand unstable.', '2024-07-07', 'IN_PROGRESS', 118, 117, NOW()),
(119, 'Elevated Walkway', 'FC Road Underpass, Pune', 'Walkway cracked.', '2024-07-10', 'PENDING', 119, NULL, NOW()),
(120, 'Solar Panel Array', 'Roof of Municipal Building, Pune', 'Panel not charging.', '2024-07-12', 'PENDING', 120, NULL, NOW()),
(121, 'Garbage Bin Station', 'Camp Area, Pune', 'Bins overflowing.', '2024-07-15', 'IN_PROGRESS', 111, 116, NOW()),
(122, 'WiFi Hotspot Pole', 'Deccan Gymkhana, Pune', 'No internet connection.', '2024-07-18', 'RESOLVED', 112, 110, NOW()),
(123, 'Public Art Sculpture', 'Jana Gana Mana Square, Pune', 'Sculpture damaged.', '2024-07-20', 'PENDING', 113, NULL, NOW()),
(124, 'Emergency Phone Booth', 'Lonavala Highway, Pune', 'Phone not working.', '2024-07-22', 'IN_PROGRESS', 114, 118, NOW()),
(125, 'Tree Guard', 'Aga Khan Palace Grounds, Pune', 'Guard bent.', '2024-07-25', 'PENDING', 115, NULL, NOW());

-- Even more dummy maintenance_logs
INSERT IGNORE INTO maintenance_logs (id, complaint_id, technician_id, action_taken, log_date) VALUES 
(109, 111, 110, 'Replaced bulb in community hall light.', '2024-06-21 10:00:00'),
(110, 112, 111, 'Cleared clog in water fountain.', '2024-06-23 12:00:00'),
(111, 113, 112, 'Repaired bench legs.', '2024-06-26 14:00:00'),
(112, 115, 114, 'Unblocked storm drain.', '2024-07-02 09:00:00'),
(113, 117, 115, 'Fixed public clock mechanism.', '2024-07-06 11:00:00'),
(114, 118, 117, 'Stabilized bike stand.', '2024-07-08 13:00:00'),
(115, 121, 116, 'Emptied garbage bins.', '2024-07-16 15:00:00'),
(116, 122, 110, 'Repaired WiFi hotspot connection.', '2024-07-19 16:00:00'),
(117, 124, 118, 'Fixed emergency phone.', '2024-07-23 10:00:00');
