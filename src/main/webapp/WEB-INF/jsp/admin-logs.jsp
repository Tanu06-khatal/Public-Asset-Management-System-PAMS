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
    <title>Maintenance Logs - PAMS Admin</title>
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
    </style>
</head>
<body>
<div class="d-flex">
    <div class="sidebar">
        <h4><i class="fa-solid fa-building-shield me-2"></i>Admin Panel</h4>
        <a href="/admin/dashboard"><i class="fa-solid fa-chart-line me-2"></i>Dashboard</a>
        <a href="/admin/manage-complaints"><i class="fa-solid fa-tasks me-2"></i>Complaints</a>
        <a href="/admin/technicians"><i class="fa-solid fa-helmet-safety me-2"></i>Technicians</a>
        <a href="/admin/assets"><i class="fa-solid fa-road me-2"></i>Assets</a>
        <a href="/admin/maintenance-logs" class="active"><i class="fa-solid fa-clipboard-list me-2"></i>Maint. Logs</a>
        <a href="/logout" style="color:#ff6b6b;margin-top:20px;"><i class="fa-solid fa-sign-out-alt me-2"></i>Logout</a>
    </div>
    <div class="content">
        <h3 class="fw-bold mb-1"><i class="fa-solid fa-clipboard-list me-2 text-primary"></i>Maintenance Logs</h3>
        <p class="text-muted mb-4">All actions taken on complaints, automatically recorded when admin updates a complaint status.</p>

        <div class="card">
            <div class="card-body p-0">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Complaint ID</th>
                            <th>Technician</th>
                            <th>Action Taken</th>
                            <th>Date &amp; Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="log" items="${logs}">
                            <tr>
                                <td class="text-muted"><c:out value="${log.id}"/></td>
                                <td>
                                    <a href="/complaint/${log.complaintId}" class="fw-bold text-decoration-none">
                                        #<c:out value="${log.complaintId}"/>
                                    </a>
                                </td>
                                <td>
                                    <c:if test="${not empty log.technicianName}">
                                        <i class="fa-solid fa-helmet-safety text-warning me-1"></i>
                                        <c:out value="${log.technicianName}"/>
                                    </c:if>
                                    <c:if test="${empty log.technicianName}">
                                        <span class="text-muted">Admin</span>
                                    </c:if>
                                </td>
                                <td><c:out value="${log.actionTaken}"/></td>
                                <td><small class="text-muted"><c:out value="${log.logDate}"/></small></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty logs}">
                            <tr><td colspan="5" class="text-center py-4 text-muted">No maintenance logs yet. They appear when complaints are updated.</td></tr>
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
