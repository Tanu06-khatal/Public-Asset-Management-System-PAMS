<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pams.model.User" %>
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
    <title>User Dashboard - PAMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f4f9f9; }
        /* Sidebar Styling */
        .sidebar { min-height: 100vh; background-color: #1b262c; color: white; padding-top: 20px; }
        .sidebar a { color: #bbe1fa; text-decoration: none; padding: 15px 20px; display: block; font-weight: 600; }
        .sidebar a:hover, .sidebar a.active { background-color: #0f4c75; color: white; }
        /* Dashboard Content */
        .content { padding: 30px; }
        .stat-card { border: none; border-radius: 12px; color: white; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .bg-total { background: linear-gradient(135deg, #3282b8, #0f4c75); }
        .bg-pending { background: linear-gradient(135deg, #f39c12, #d35400); }
        .bg-resolved { background: linear-gradient(135deg, #2ecc71, #27ae60); }
    </style>
</head>
<body>

<div class="d-flex">
    <!-- Sidebar -->
    <div class="sidebar flex-shrink-0" id="sidebar" style="width: 250px;">
        <h4 class="text-center mb-4 px-2"><i class="fa-solid fa-building-shield"></i> PAMS</h4>
        <div class="text-center mb-4">
            <i class="fa-solid fa-user-circle fa-3x mb-2 text-secondary"></i>
            <h6 class="text-white"><%= loggedInUser.getName() %></h6>
            <small class="text-muted"><%= loggedInUser.getRole() %></small>
        </div>
        <a href="/dashboard" class="active"><i class="fa-solid fa-chart-pie me-2"></i> Dashboard</a>
        <a href="/raise-complaint"><i class="fa-solid fa-plus-circle me-2"></i> Raise Complaint</a>
        <a href="/my-complaints"><i class="fa-solid fa-list me-2"></i> My Complaints</a>
        <a href="/logout" class="text-danger mt-4"><i class="fa-solid fa-sign-out-alt me-2"></i> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content flex-grow-1">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <div>
                <h2 class="fw-bold text-dark mb-0">My Citizen Portal</h2>
                <p class="text-muted small mb-0">Helping build a better city, one report at a time.</p>
            </div>
            <div class="text-end">
                <span class="badge bg-light text-dark shadow-sm border px-3 py-2"><i class="fa-solid fa-calendar-day me-1"></i> Today: <%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></span>
            </div>
        </div>

        <!-- Notifications Section -->
        <c:forEach var="complaint" items="${complaints}">
            <c:if test="${not empty complaint.adminMessage}">
                <div class="alert alert-primary alert-dismissible fade show border-0 shadow-sm mb-3" role="alert" style="border-radius: 12px; border-left: 5px solid #0f4c75 !important; background-color: #e3f2fd;">
                    <div class="d-flex align-items-center">
                        <div class="bg-white rounded-circle p-2 me-3 shadow-sm">
                            <i class="fa-solid fa-bell text-primary"></i>
                        </div>
                        <div>
                            <strong class="d-block text-primary">Action Update: <c:out value="${complaint.assetName}"/></strong>
                            <span class="text-dark small"><c:out value="${complaint.adminMessage}"/></span>
                        </div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </c:forEach>

        <div class="row">
            <div class="col-md-7">
                <div class="card border-0 shadow-sm mb-4" style="border-radius: 15px;">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-4">My Impact Summary</h5>
                        <div class="row text-center">
                            <div class="col-4 border-end">
                                <h3 class="fw-bold text-primary mb-0">${totalComplaints}</h3>
                                <small class="text-muted text-uppercase" style="font-size: 0.7rem;">Reports</small>
                            </div>
                            <div class="col-4 border-end">
                                <h3 class="fw-bold text-warning mb-0">${pendingComplaints}</h3>
                                <small class="text-muted text-uppercase" style="font-size: 0.7rem;">Waitlisted</small>
                            </div>
                            <div class="col-4">
                                <h3 class="fw-bold text-success mb-0">${resolvedComplaints}</h3>
                                <small class="text-muted text-uppercase" style="font-size: 0.7rem;">Fixed Cases</small>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm" style="border-radius: 15px; background: linear-gradient(135deg, #0f4c75, #3282b8); color: white;">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center">
                            <div class="me-4">
                                <i class="fa-solid fa-hard-hat fa-4x opacity-50"></i>
                            </div>
                            <div>
                                <h4 class="fw-bold">Spotted an issue?</h4>
                                <p class="small opacity-75">Your reports help our municipal teams fix infrastructure faster. Every photo counts!</p>
                                <a href="/raise-complaint" class="btn btn-light text-primary fw-bold rounded-pill px-4">New Report <i class="fa-solid fa-arrow-right ms-1"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="card border-0 shadow-sm h-100" style="border-radius: 15px;">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-3">Community News</h5>
                        <div class="d-flex mb-3 border-bottom pb-3">
                            <div class="bg-light rounded p-2 me-3 text-center" style="min-width: 60px;">
                                <div class="small fw-bold text-primary">APR</div>
                                <div class="h5 mb-0 fw-bold">16</div>
                            </div>
                            <div>
                                <h6 class="mb-1 fw-bold">Smart Streetlight Project</h6>
                                <p class="text-muted x-small mb-0">Phase 2 of intelligent lighting starts in downtown...</p>
                            </div>
                        </div>
                        <div class="d-flex">
                            <div class="bg-light rounded p-2 me-3 text-center" style="min-width: 60px;">
                                <div class="small fw-bold text-primary">APR</div>
                                <div class="h5 mb-0 fw-bold">14</div>
                            </div>
                            <div>
                                <h6 class="mb-1 fw-bold">Park Renovation</h6>
                                <p class="text-muted x-small mb-0">Green Valley Park to get new exercise equipment next month.</p>
                            </div>
                        </div>
                        <a href="#" class="btn btn-link link-primary p-0 mt-3 text-decoration-none small">View all announcements <i class="fa-solid fa-chevron-right ms-1" style="font-size: 0.7rem;"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
