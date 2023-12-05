<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="app-menu navbar-menu">
    <!-- LOGO -->
    <div class="navbar-brand-box">
        <!-- Dark Logo-->
        <a href="/dashboard" class="logo logo-dark">
                    <span class="logo-sm">
                        <img src="/assets/images/logo-sm.png" alt="" height="22">
                    </span>
            <span class="logo-lg">
                        <img src="/assets/images/logo-dark.png" alt="" height="17">
                    </span>
        </a>
        <!-- Light Logo-->
        <a href="/dashboard" class="logo logo-light">
                    <span class="logo-sm">
                        <img src="/assets/images/logo-sm.png" alt="" height="22">
                    </span>
            <span class="logo-lg">
                        <img src="/assets/images/logo-light.png" alt="" height="17">
                    </span>
        </a>
        <button type="button" class="btn btn-sm p-0 fs-20 header-item float-end btn-vertical-sm-hover" id="vertical-hover">
            <i class="ri-record-circle-line"></i>
        </button>
    </div>

    <div id="scrollbar">
        <div class="container-fluid">

            <div id="two-column-menu">
            </div>
            <ul class="navbar-nav" id="navbar-nav">

                <li class="menu-title"><i class="ri-more-fill"></i> <span>Dashboard</span></li>
                <li class="nav-item">
                    <a href="/dashboard" class="nav-link menu-link">
                        <i class="ri-account-circle-line"></i> <span>Dashboard</span>
                    </a>
                </li>

                <li class="menu-title"><span>Task management</span></li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="#sidebarTasks" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarDashboards">
                        <i class="ri-dashboard-2-line"></i> <span>Task management</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarTasks">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="/tasks" class="nav-link" > Task </a>
                            </li>
                            <li class="nav-item">
                                <a href="/weekly-reports" class="nav-link"> Weekly report </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link schedule-item-menu"> Schedule </a>
                            </li>
                        </ul>
                    </div>
                </li>

                <li class="menu-title"><i class="ri-more-fill"></i> <span>Notification</span></li>
                <li class="nav-item">
                    <a href="/notifications" class="nav-link menu-link">
                        <i class="ri-account-circle-line"></i> <span>Notification</span>
                    </a>
                </li>

                <li class="menu-title d-none manager-menu"><i class="ri-more-fill"></i> <span>Human management</span></li>
                <li class="nav-item d-none manager-menu">
                    <a class="nav-link menu-link" href="#sidebarHuman" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarForms">
                        <i class="ri-file-list-3-line"></i> <span>Human management</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarHuman">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="/users" class="nav-link">Human</a>
                            </li>
                            <li class="nav-item">
                                <a href="/timesheets" class="nav-link">Timesheets</a>
                            </li>
                        </ul>
                    </div>
                </li>

                <li class="menu-title d-none manager-menu"><i class="ri-more-fill"></i> <span>Accounting management</span></li>
                <li class="nav-item d-none manager-menu">
                    <a href="/accounting" class="nav-link menu-link">
                        <i class="ri-account-circle-line"></i> <span>Accounting</span>
                    </a>
                </li>



                <li class="menu-title"><i class="ri-more-fill"></i> <span>Time management</span></li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="#sidebarTime" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarForms">
                        <i class="ri-share-line"></i> <span>Time management</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarTime">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a class="nav-link management-time-day-login">Management time</a>
                            </li>
                            <li class="nav-item">
                                <a href="/books" class="nav-link">Book</a>
                            </li>
                        </ul>
                    </div>
                </li>

                <li class="menu-title d-none manager-menu"><i class="ri-more-fill"></i> <span>Setting system</span></li>
                <li class="nav-item d-none manager-menu">
                    <a class="nav-link menu-link" href="#sidebarSetting" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarForms">
                        <i class="ri-share-line"></i> <span>Setting system</span>
                    </a>
                    <div class="collapse menu-dropdown" id="sidebarSetting">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="/settings/file" class="nav-link">File</a>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
        <!-- Sidebar -->
    </div>

    <div class="sidebar-background"></div>
</div>