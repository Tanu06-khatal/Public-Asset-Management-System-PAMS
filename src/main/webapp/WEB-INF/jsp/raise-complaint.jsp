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
    <title>Raise Complaint - PAMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f4f9f9; }
        .sidebar { min-height: 100vh; background-color: #1b262c; color: white; padding-top: 20px; }
        .sidebar a { color: #bbe1fa; text-decoration: none; padding: 15px 20px; display: block; font-weight: 600; }
        .sidebar a:hover, .sidebar a.active { background-color: #0f4c75; color: white; }
        .content { padding: 30px; }
        .form-card { border: none; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .btn-primary { background-color: #3282b8; border: none; }
        .btn-primary:hover { background-color: #0f4c75; }
    </style>
</head>
<body>

<div class="d-flex">
    <!-- Sidebar -->
    <div class="sidebar flex-shrink-0" style="width: 250px;">
        <h4 class="text-center mb-4 px-2"><i class="fa-solid fa-building-shield"></i> PAMS</h4>
        <a href="/dashboard"><i class="fa-solid fa-chart-pie me-2"></i> Dashboard</a>
        <a href="/raise-complaint" class="active"><i class="fa-solid fa-plus-circle me-2"></i> Raise Complaint</a>
        <a href="/my-complaints"><i class="fa-solid fa-list me-2"></i> My Complaints</a>
        <a href="/logout" class="text-danger mt-4"><i class="fa-solid fa-sign-out-alt me-2"></i> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content flex-grow-1">
        <h2 class="fw-bold text-dark mb-4">Raise a New Complaint</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i><c:out value="${error}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i><c:out value="${success}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card form-card">
            <div class="card-body p-4 p-md-5">
                <form action="/raise-complaint" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Asset Type</label>
                            <select name="assetName" class="form-select" required>
                                <option value="" disabled <c:if test="${empty param.assetName}">selected</c:if>>Select an asset type...</option>
                                <option value="Street Light"          <c:if test="${param.assetName == 'Street Light'}">selected</c:if>>Street Light</option>
                                <option value="Road / Pothole"        <c:if test="${param.assetName == 'Road / Pothole'}">selected</c:if>>Road / Pothole</option>
                                <option value="Public Park Equipment"  <c:if test="${param.assetName == 'Public Park Equipment'}">selected</c:if>>Public Park Equipment</option>
                                <option value="Water Supply Element"  <c:if test="${param.assetName == 'Water Supply Element'}">selected</c:if>>Water Supply Element</option>
                                <option value="Public Transport Stop" <c:if test="${param.assetName == 'Public Transport Stop'}">selected</c:if>>Public Transport Stop</option>
                                <option value="Other"                 <c:if test="${param.assetName == 'Other'}">selected</c:if>>Other</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Fault Date</label>
                            <input type="date" name="faultDate" class="form-control"
                                   value="<c:out value="${param.faultDate}"/>" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Location</label>
                        <input type="text" name="location" class="form-control"
                               placeholder="Street name, landmark, or specific address"
                               value="<c:out value="${param.location}"/>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Description of Issue</label>
                        <textarea name="description" class="form-control" rows="4"
                                  placeholder="Provide detailed information about the damage or issue..." required><c:out value="${param.description}"/></textarea>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold">Upload Image</label>
                        <input type="file" name="image" class="form-control" accept=".jpg,.jpeg,.png">
                        <div class="form-text">Optional: Please upload a clear photo of the asset showing the issue (Max 5MB).</div>
                    </div>

                    <div class="text-end">
                        <a href="/dashboard" class="btn btn-outline-secondary me-2">Cancel</a>
                        <button type="submit" class="btn btn-primary px-4"><i class="fa-solid fa-paper-plane me-1"></i> Submit Complaint</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
