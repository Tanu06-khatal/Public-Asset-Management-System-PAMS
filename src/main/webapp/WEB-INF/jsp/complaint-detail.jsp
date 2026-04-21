<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pams.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if(loggedInUser == null) { response.sendRedirect("/login"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Complaint Detail - PAMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family:'Inter',sans-serif; background:#f0f4f8; }
        .card { border:none; border-radius:12px; box-shadow:0 4px 15px rgba(0,0,0,0.07); }
        .badge-pending  { background:#e67e22; color:#fff; padding:6px 14px; border-radius:20px; }
        .badge-progress { background:#3498db; color:#fff; padding:6px 14px; border-radius:20px; }
        .badge-resolved { background:#27ae60; color:#fff; padding:6px 14px; border-radius:20px; }
        .timeline-item { border-left:3px solid #3282b8; padding-left:15px; margin-bottom:15px; position:relative; }
        .timeline-dot { width:12px; height:12px; background:#3282b8; border-radius:50%; position:absolute; left:-7px; top:4px; }
    </style>
</head>
<body class="p-4">
<div class="container">
    <a href="/my-complaints" class="btn btn-outline-secondary mb-3">
        <i class="fa-solid fa-arrow-left me-1"></i> Back to My Complaints
    </a>

    <div class="row">
        <!-- Complaint Info -->
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header bg-white fw-bold fs-5">
                    <i class="fa-solid fa-file-alt me-2 text-primary"></i>Complaint #<c:out value="${complaint.id}"/>
                </div>
                <div class="card-body">
                    <table class="table table-borderless">
                        <tr><th>Asset</th><td><c:out value="${complaint.assetName}"/></td></tr>
                        <tr><th>Location</th><td><i class="fa-solid fa-location-dot text-danger me-1"></i><c:out value="${complaint.location}"/></td></tr>
                        <tr><th>Fault Date</th><td><c:out value="${complaint.faultDate}"/></td></tr>
                        <tr><th>Description</th><td><c:out value="${complaint.description}"/></td></tr>
                        <tr><th>Status</th>
                            <td>
                                <c:if test="${complaint.status == 'PENDING'}"><span class="badge-pending"><i class="fa-solid fa-clock me-1"></i>Pending</span></c:if>
                                <c:if test="${complaint.status == 'IN_PROGRESS'}"><span class="badge-progress"><i class="fa-solid fa-spinner me-1"></i>In Progress</span></c:if>
                                <c:if test="${complaint.status == 'RESOLVED'}"><span class="badge-resolved"><i class="fa-solid fa-check-circle me-1"></i>Resolved</span></c:if>
                            </td>
                        </tr>
                        <c:if test="${not empty complaint.adminMessage}">
                            <tr><th>Admin Note</th><td class="text-info"><i class="fa-solid fa-comment me-1"></i><c:out value="${complaint.adminMessage}"/></td></tr>
                        </c:if>
                        <c:if test="${not empty complaint.technicianName}">
                            <tr><th>Assigned To</th><td><i class="fa-solid fa-helmet-safety text-warning me-1"></i><c:out value="${complaint.technicianName}"/></td></tr>
                        </c:if>
                    </table>
                    <c:if test="${not empty complaint.imageUrl}">
                        <a href="/uploads/${complaint.imageUrl}" target="_blank" class="btn btn-outline-primary">
                            <i class="fa-solid fa-image me-1"></i> View Uploaded Image
                        </a>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Maintenance Timeline -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-header bg-white fw-bold">
                    <i class="fa-solid fa-clipboard-list me-2 text-success"></i>Activity Timeline
                </div>
                <div class="card-body">
                    <c:if test="${empty logs}">
                        <p class="text-muted text-center">No activity yet. Updates will appear here.</p>
                    </c:if>
                    <c:forEach var="log" items="${logs}">
                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="fw-bold small"><c:out value="${log.actionTaken}"/></div>
                            <c:if test="${not empty log.technicianName}">
                                <small class="text-success"><i class="fa-solid fa-helmet-safety me-1"></i><c:out value="${log.technicianName}"/></small><br>
                            </c:if>
                            <small class="text-muted"><c:out value="${log.logDate}"/></small>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
