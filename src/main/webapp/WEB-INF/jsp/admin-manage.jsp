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
    <title>Manage Complaints - PAMS Admin</title>
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
        .badge-pending  { background:#e67e22; color:#fff; }
        .badge-progress { background:#3498db; color:#fff; }
        .badge-resolved { background:#27ae60; color:#fff; }
        .badge-status { padding:5px 10px; border-radius:20px; font-size:0.78rem; font-weight:600; }
        .table-card { border:none; border-radius:12px; box-shadow:0 4px 15px rgba(0,0,0,0.07); }
        .locked-row { background:#f8fff8; }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Sidebar -->
    <div class="sidebar">
        <h4><i class="fa-solid fa-building-shield me-2"></i>Admin Panel</h4>
        <a href="/admin/dashboard"><i class="fa-solid fa-chart-line me-2"></i>Dashboard</a>
        <a href="/admin/manage-complaints" class="active"><i class="fa-solid fa-tasks me-2"></i>Complaints</a>
        <a href="/admin/technicians"><i class="fa-solid fa-helmet-safety me-2"></i>Technicians</a>
        <a href="/admin/assets"><i class="fa-solid fa-road me-2"></i>Assets</a>
        <a href="/admin/maintenance-logs"><i class="fa-solid fa-clipboard-list me-2"></i>Maint. Logs</a>
        <a href="/logout" style="color:#ff6b6b; margin-top:20px;"><i class="fa-solid fa-sign-out-alt me-2"></i>Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <h3 class="fw-bold mb-1">Manage Complaints</h3>
        <p class="text-muted mb-4">Update complaint statuses. <strong>Resolved complaints are locked</strong> and cannot be changed.</p>

        <c:if test="${not empty param.error}">
            <div class="alert alert-warning"><i class="fa-solid fa-triangle-exclamation me-1"></i>This complaint is already resolved and cannot be updated.</div>
        </c:if>

        <div class="card table-card">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>#ID</th>
                                <th>Asset / Date</th>
                                <th>Location &amp; Description</th>
                                <th>Reported By</th>
                                <th>Image</th>
                                <th>Current Status</th>
                                <th>Update</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="complaint" items="${complaints}">
                                <tr class="${complaint.status == 'RESOLVED' ? 'locked-row' : ''}">
                                    <td class="fw-bold text-muted">#<c:out value="${complaint.id}"/></td>
                                    <td>
                                        <div class="fw-bold"><c:out value="${complaint.assetName}"/></div>
                                        <small class="text-muted"><c:out value="${complaint.faultDate}"/></small>
                                    </td>
                                    <td>
                                        <div><i class="fa-solid fa-location-dot text-danger me-1"></i><c:out value="${complaint.location}"/></div>
                                        <small class="text-muted d-block" style="max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                                            <c:out value="${complaint.description}"/>
                                        </small>
                                    </td>
                                    <td>
                                        <c:out value="${complaint.userName}"/>
                                        <c:if test="${not empty complaint.technicianName}">
                                            <br><small class="text-success"><i class="fa-solid fa-helmet-safety me-1"></i><c:out value="${complaint.technicianName}"/></small>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${not empty complaint.imageUrl}">
                                            <a href="/uploads/${complaint.imageUrl}" target="_blank" class="btn btn-sm btn-outline-primary">
                                                <i class="fa-solid fa-eye"></i> View
                                            </a>
                                        </c:if>
                                        <c:if test="${empty complaint.imageUrl}">
                                            <span class="text-muted small">N/A</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${complaint.status == 'PENDING'}">
                                            <span class="badge-status badge-pending"><i class="fa-solid fa-clock me-1"></i>Pending</span>
                                        </c:if>
                                        <c:if test="${complaint.status == 'IN_PROGRESS'}">
                                            <span class="badge-status badge-progress"><i class="fa-solid fa-spinner me-1"></i>In Progress</span>
                                        </c:if>
                                        <c:if test="${complaint.status == 'RESOLVED'}">
                                            <span class="badge-status badge-resolved"><i class="fa-solid fa-check-circle me-1"></i>Resolved ✓</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <%-- If RESOLVED, show locked message. Otherwise show form --%>
                                        <c:if test="${complaint.status == 'RESOLVED'}">
                                            <span class="text-success small"><i class="fa-solid fa-lock me-1"></i>Locked - Cannot reopen</span>
                                        </c:if>
                                        <c:if test="${complaint.status != 'RESOLVED'}">
                                            <form action="/admin/update-status" method="post">
                                                <input type="hidden" name="id" value="${complaint.id}">
                                                <div class="d-flex mb-1 gap-1">
                                                    <select name="status" class="form-select form-select-sm">
                                                        <option value="PENDING"     ${complaint.status == 'PENDING'     ? 'selected' : ''}>Pending</option>
                                                        <option value="IN_PROGRESS" ${complaint.status == 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
                                                        <option value="RESOLVED">Resolved</option>
                                                    </select>
                                                    <select name="technicianId" class="form-select form-select-sm">
                                                        <option value="">-- Assign Technician --</option>
                                                        <c:forEach var="tech" items="${technicians}">
                                                            <option value="${tech.id}" ${complaint.technicianId == tech.id ? 'selected' : ''}>
                                                                <c:out value="${tech.name}"/>
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <textarea name="adminMessage" class="form-control form-control-sm mb-1" rows="1" placeholder="Note to citizen..."><c:out value="${complaint.adminMessage}"/></textarea>
                                                <button type="submit" class="btn btn-sm btn-success w-100">
                                                    <i class="fa-solid fa-floppy-disk me-1"></i> Update
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty complaints}">
                                <tr><td colspan="7" class="text-center py-4 text-muted">No complaints in the system yet.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
