<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pams.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if(loggedInUser == null || !"ADMIN".equals(loggedInUser.getRole())) {
        response.sendRedirect("/login"); return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assets - PAMS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family:'Inter',sans-serif; background:#f0f4f8; }
        .sidebar { min-height:100vh; background:#0f4c75; color:white; padding-top:20px; width:240px; flex-shrink:0; }
        .sidebar h4 { padding:0 20px 15px; border-bottom:1px solid #1b5e98; }
        .sidebar a { color:#bbe1fa; text-decoration:none; padding:12px 20px; display:block; font-weight:500; }
        .sidebar a:hover,.sidebar a.active { background:#3282b8; color:white; }
        .content { padding:30px; flex-grow:1; }
        .card { border:none; border-radius:12px; box-shadow:0 4px 15px rgba(0,0,0,0.07); }
        .badge-active { background:#27ae60; color:#fff; padding:4px 10px; border-radius:20px; font-size:0.8rem; }
    </style>
</head>
<body>
<div class="d-flex">
    <div class="sidebar">
        <h4><i class="fa-solid fa-building-shield me-2"></i>Admin Panel</h4>
        <a href="/admin/dashboard"><i class="fa-solid fa-chart-line me-2"></i>Dashboard</a>
        <a href="/admin/manage-complaints"><i class="fa-solid fa-tasks me-2"></i>Complaints</a>
        <a href="/admin/technicians"><i class="fa-solid fa-helmet-safety me-2"></i>Technicians</a>
        <a href="/admin/assets" class="active"><i class="fa-solid fa-road me-2"></i>Assets</a>
        <a href="/admin/maintenance-logs"><i class="fa-solid fa-clipboard-list me-2"></i>Maint. Logs</a>
        <a href="/logout" style="color:#ff6b6b;margin-top:20px;"><i class="fa-solid fa-sign-out-alt me-2"></i>Logout</a>
    </div>
    <div class="content">
        <h3 class="fw-bold mb-4"><i class="fa-solid fa-road me-2 text-primary"></i>Manage Public Assets</h3>

        <!-- Add Asset Form -->
        <div class="card mb-4">
            <div class="card-header fw-bold bg-white"><i class="fa-solid fa-plus-circle me-2 text-success"></i>Register New Asset</div>
            <div class="card-body">
                <form action="/admin/assets/add" method="post">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label fw-bold">Asset Name</label>
                            <input type="text" name="assetName" class="form-control" required placeholder="e.g. Streetlight #12">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-bold">Asset Type</label>
                            <select name="assetType" class="form-select" required>
                                <option value="">-- Select Type --</option>
                                <option value="Streetlight">Streetlight</option>
                                <option value="Road">Road</option>
                                <option value="Water Pump">Water Pump</option>
                                <option value="Drainage">Drainage</option>
                                <option value="Park">Park</option>
                                <option value="Bridge">Bridge</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-bold">Location</label>
                            <input type="text" name="location" class="form-control" required placeholder="e.g. Main Road, Sector 5">
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-bold">Installed On</label>
                            <input type="date" name="installedOn" class="form-control" max="<%= java.time.LocalDate.now() %>">
                        </div>
                        <div class="col-md-1 d-flex align-items-end">
                            <button type="submit" class="btn btn-success w-100"><i class="fa-solid fa-plus"></i></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Assets Table -->
        <div class="card">
            <div class="card-body p-0">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Asset Name</th>
                            <th>Type</th>
                            <th>Location</th>
                            <th>Installed On</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="asset" items="${assets}">
                            <tr>
                                <td><c:out value="${asset.id}"/></td>
                                <td class="fw-bold"><c:out value="${asset.assetName}"/></td>
                                <td><span class="badge bg-info text-dark"><c:out value="${asset.assetType}"/></span></td>
                                <td><i class="fa-solid fa-location-dot text-danger me-1"></i><c:out value="${asset.location}"/></td>
                                <td>
                                    <c:if test="${not empty asset.installedOn}"><c:out value="${asset.installedOn}"/></c:if>
                                    <c:if test="${empty asset.installedOn}"><span class="text-muted">N/A</span></c:if>
                                </td>
                                <td><span class="badge-active"><c:out value="${asset.status}"/></span></td>
                                <td>
                                    <a href="/admin/assets/delete/${asset.id}"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Delete this asset?')">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty assets}">
                            <tr><td colspan="7" class="text-center py-4 text-muted">No assets registered yet.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
