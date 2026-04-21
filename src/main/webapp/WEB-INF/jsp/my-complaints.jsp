<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pams.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if(loggedInUser == null) {
        response.sendRedirect("/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Complaints - PAMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f4f9f9; }
        .sidebar { min-height: 100vh; background-color: #1b262c; color: white; padding-top: 20px; }
        .sidebar a { color: #bbe1fa; text-decoration: none; padding: 15px 20px; display: block; font-weight: 600; }
        .sidebar a:hover, .sidebar a.active { background-color: #0f4c75; color: white; }
        .content { padding: 30px; }
        .table-card { border: none; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .badge.bg-pending { background-color: #f39c12 !important; }
        .badge.bg-inprogress { background-color: #3498db !important; }
        .badge.bg-resolved { background-color: #2ecc71 !important; }
    </style>
</head>
<body>

<div class="d-flex">
    <!-- Sidebar -->
    <div class="sidebar flex-shrink-0" style="width: 250px;">
        <h4 class="text-center mb-4 px-2"><i class="fa-solid fa-building-shield"></i> PAMS</h4>
        <a href="/dashboard"><i class="fa-solid fa-chart-pie me-2"></i> Dashboard</a>
        <a href="/raise-complaint"><i class="fa-solid fa-plus-circle me-2"></i> Raise Complaint</a>
        <a href="/my-complaints" class="active"><i class="fa-solid fa-list me-2"></i> My Complaints</a>
        <a href="/logout" class="text-danger mt-4"><i class="fa-solid fa-sign-out-alt me-2"></i> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content flex-grow-1">
        <h2 class="fw-bold text-dark mb-4">My Complaints</h2>

        <%-- Success message after a new complaint is submitted --%>
        <c:if test="${param.submitted == 'true'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i><strong>Complaint submitted successfully!</strong> We will review it shortly.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card table-card">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Asset</th>
                                <th>Location</th>
                                <th>Date Reported</th>
                                <th>Status</th>
                                <th>Image</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="complaint" items="${complaints}">
                                 <tr>
                                    <td>#<c:out value="${complaint.id}" /></td>
                                    <td class="fw-bold text-dark">
                                        <c:out value="${complaint.assetName}" />
                                        <c:if test="${not empty complaint.adminMessage}">
                                            <div class="mt-1 small py-1 px-2 bg-light border-start border-primary border-3">
                                                <i class="fa-solid fa-comment-dots text-primary me-1"></i> <c:out value="${complaint.adminMessage}"/>
                                            </div>
                                        </c:if>
                                    </td>
                                    <td><c:out value="${complaint.location}" /></td>
                                    <td><c:out value="${complaint.faultDate}" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${complaint.status == 'PENDING'}">
                                                <span class="badge bg-warning text-dark px-3 py-2 rounded-pill"><i class="fa-regular fa-clock me-1"></i> Pending</span>
                                            </c:when>
                                            <c:when test="${complaint.status == 'IN_PROGRESS'}">
                                                <span class="badge bg-info text-dark px-3 py-2 rounded-pill"><i class="fa-solid fa-spinner fa-spin me-1"></i> In Progress</span>
                                            </c:when>
                                            <c:when test="${complaint.status == 'RESOLVED'}">
                                                <span class="badge bg-success px-3 py-2 rounded-pill"><i class="fa-solid fa-check me-1"></i> Resolved</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${not empty complaint.imageUrl}">
                                            <a href="/uploads/${complaint.imageUrl}" target="_blank" class="text-primary"><i class="fa-solid fa-image"></i> View</a>
                                        </c:if>
                                        <c:if test="${empty complaint.imageUrl}">
                                            <span class="text-muted">None</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <a href="/complaint/${complaint.id}" class="btn btn-sm btn-outline-primary">
                                            <i class="fa-solid fa-eye me-1"></i> Details
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty complaints}">
                                <tr>
                                    <td colspan="7" class="text-center py-4 text-muted">You haven't reported any complaints yet.</td>
                                </tr>
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
