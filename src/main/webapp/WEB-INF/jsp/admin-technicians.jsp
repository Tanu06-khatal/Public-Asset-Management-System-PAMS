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
    <title>Technicians - PAMS Admin</title>
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
        small.hint { color:#888; font-size:0.78rem; }
    </style>
</head>
<body>
<div class="d-flex">
    <div class="sidebar">
        <h4><i class="fa-solid fa-building-shield me-2"></i>Admin Panel</h4>
        <a href="/admin/dashboard"><i class="fa-solid fa-chart-line me-2"></i>Dashboard</a>
        <a href="/admin/manage-complaints"><i class="fa-solid fa-tasks me-2"></i>Complaints</a>
        <a href="/admin/technicians" class="active"><i class="fa-solid fa-helmet-safety me-2"></i>Technicians</a>
        <a href="/admin/assets"><i class="fa-solid fa-road me-2"></i>Assets</a>
        <a href="/admin/maintenance-logs"><i class="fa-solid fa-clipboard-list me-2"></i>Maint. Logs</a>
        <a href="/logout" style="color:#ff6b6b;margin-top:20px;"><i class="fa-solid fa-sign-out-alt me-2"></i>Logout</a>
    </div>
    <div class="content">
        <h3 class="fw-bold mb-4"><i class="fa-solid fa-helmet-safety me-2 text-primary"></i>Manage Technicians</h3>

        <!-- Add Technician Form -->
        <div class="card mb-4">
            <div class="card-header fw-bold bg-white"><i class="fa-solid fa-plus-circle me-2 text-success"></i>Add New Technician</div>
            <div class="card-body">
                <% if(request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                <% } %>
                <form action="/admin/technicians/add" method="post" id="techForm">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label fw-bold">Full Name</label>
                            <input type="text" name="name" class="form-control" required placeholder="e.g. Ravi Kumar">
                            <small class="hint">Letters only</small>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-bold">Phone Number</label>
                            <input type="tel" name="phoneNumber" class="form-control" required maxlength="10" placeholder="10-digit number" id="techPhone">
                            <small class="hint">Exactly 10 digits</small>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Specialization</label>
                            <input type="text" name="specialization" class="form-control" required placeholder="e.g. Electrical, Plumbing">
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-success w-100">
                                <i class="fa-solid fa-plus me-1"></i> Add
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Technicians Table -->
        <div class="card">
            <div class="card-body p-0">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Specialization</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tech" items="${technicians}">
                            <tr>
                                <td><c:out value="${tech.id}"/></td>
                                <td class="fw-bold"><i class="fa-solid fa-helmet-safety text-warning me-2"></i><c:out value="${tech.name}"/></td>
                                <td><c:out value="${tech.phoneNumber}"/></td>
                                <td><c:out value="${tech.specialization}"/></td>
                                <td>
                                    <c:if test="${tech.available}">
                                        <span class="badge bg-success">Available</span>
                                    </c:if>
                                    <c:if test="${!tech.available}">
                                        <span class="badge bg-secondary">Busy</span>
                                    </c:if>
                                </td>
                                <td>
                                    <a href="/admin/technicians/delete/${tech.id}"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Delete this technician?')">
                                        <i class="fa-solid fa-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty technicians}">
                            <tr><td colspan="6" class="text-center py-4 text-muted">No technicians added yet.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById('techPhone').addEventListener('input', function() {
        this.value = this.value.replace(/\D/g, '');
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
