<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pams.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if(loggedInUser == null || !"ADMIN".equals(loggedInUser.getRole())) {
        response.sendRedirect("/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PAMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f4f9f9; }
        /* Sidebar Styling */
        .sidebar { min-height: 100vh; background-color: #0f4c75; color: white; padding-top: 20px; }
        .sidebar a { color: #bbe1fa; text-decoration: none; padding: 15px 20px; display: block; font-weight: 600; }
        .sidebar a:hover, .sidebar a.active { background-color: #3282b8; color: white; }
        /* Dashboard Content */
        .content { padding: 30px; }
        .stat-card { border: none; border-radius: 12px; color: white; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .bg-total { background: linear-gradient(135deg, #2c3e50, #34495e); }
        .bg-pending { background: linear-gradient(135deg, #e67e22, #d35400); }
        .bg-resolved { background: linear-gradient(135deg, #27ae60, #2ecc71); }
    </style>
</head>
<body>

<div class="d-flex">
    <!-- Admin Sidebar -->
    <div class="sidebar flex-shrink-0" id="sidebar" style="width: 250px;">
        <h4 class="text-center mb-4 px-2"><i class="fa-solid fa-building-shield"></i> Admin Panel</h4>
        <div class="text-center mb-4">
            <i class="fa-solid fa-user-shield fa-3x mb-2 text-warning"></i>
            <h6 class="text-white"><%= loggedInUser.getName() %></h6>
            <small class="text-warning">System Admin</small>
        </div>
        <a href="/admin/dashboard" class="active"><i class="fa-solid fa-chart-line me-2"></i> Analytics</a>
        <a href="/admin/manage-complaints"><i class="fa-solid fa-tasks me-2"></i> Manage Complaints</a>
        <a href="/admin/technicians"><i class="fa-solid fa-helmet-safety me-2"></i> Technicians</a>
        <a href="/admin/assets"><i class="fa-solid fa-road me-2"></i> Assets</a>
        <a href="/admin/maintenance-logs"><i class="fa-solid fa-clipboard-list me-2"></i> Maint. Logs</a>
        <a href="/logout" class="text-danger mt-4"><i class="fa-solid fa-sign-out-alt me-2"></i> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content flex-grow-1">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <div>
                <h2 class="fw-bold text-dark mb-0">System Control Center</h2>
                <p class="text-muted small mb-0">Monitoring and managing city infrastructure reports.</p>
            </div>
            <div class="text-end">
                <span class="badge bg-warning text-dark shadow-sm border px-3 py-2"><i class="fa-solid fa-shield-halved me-1"></i> Admin Session: Active</span>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card stat-card bg-total h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase mb-1 small">Total Infrastructure Issues</h6>
                                <h2 class="mb-0 fw-bold">${totalComplaints}</h2>
                            </div>
                            <i class="fa-solid fa-globe fa-3x opacity-25"></i>
                        </div>
                        <div class="mt-3 small">
                            <i class="fa-solid fa-arrow-trend-up me-1"></i> <span class="fw-bold">Global System Load</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card stat-card bg-pending h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase mb-1 small">Awaiting Response</h6>
                                <h2 class="mb-0 fw-bold">${pendingComplaints}</h2>
                            </div>
                            <i class="fa-solid fa-bolt-lightning fa-3x opacity-25"></i>
                        </div>
                        <div class="mt-3 small">
                            <i class="fa-solid fa-clock me-1"></i> <span class="fw-bold">High Priority Batch</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card stat-card bg-resolved h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase mb-1 small">Successful Fixes</h6>
                                <h2 class="mb-0 fw-bold">${resolvedComplaints}</h2>
                            </div>
                            <i class="fa-solid fa-check-double fa-3x opacity-25"></i>
                        </div>
                        <div class="mt-3 small">
                            <i class="fa-solid fa-circle-check me-1"></i> <span class="fw-bold">Citizen Satisfaction +12%</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm" style="border-radius: 12px;">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="fw-bold mb-0">Recent System Activity</h5>
                    </div>
                    <div class="card-body p-0">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                                <div>
                                    <h6 class="mb-0 fw-bold text-dark">User Registration Spike</h6>
                                    <small class="text-muted">Database observed 15 new signups in the last hour.</small>
                                </div>
                                <span class="badge rounded-pill bg-light text-primary border">System</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                                <div>
                                    <h6 class="mb-0 fw-bold text-dark">Complaint Status Updated</h6>
                                    <small class="text-muted">Complaint #104 status moved to 'Resolved' by System.</small>
                                </div>
                                <span class="badge rounded-pill bg-light text-success border">Operation</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                                <div>
                                    <h6 class="mb-0 fw-bold text-dark">Photo Storage Clean-up</h6>
                                    <small class="text-muted">Automated routine checked 54 assets for visibility.</small>
                                </div>
                                <span class="badge rounded-pill bg-light text-info border">Maintenance</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm mb-4" style="border-radius: 12px;">
                    <div class="card-body text-center py-4">
                        <div class="bg-light text-warning rounded-circle d-inline-block p-3 mb-3">
                            <i class="fa-solid fa-tools fa-2x"></i>
                        </div>
                        <h5 class="fw-bold">Administrative Center</h5>
                        <p class="text-muted small">Update infrastructure status and notify citizens of municipal actions.</p>
                        <a href="/admin/manage-complaints" class="btn btn-warning w-100 fw-bold rounded-pill mt-2">Manage Issues <i class="fa-solid fa-arrow-right-long ms-1"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
