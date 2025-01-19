<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tiệm gà sao hỏa</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/doanweb/styles/style.css">
    <link rel="icon" href="<%= request.getContextPath() %>/doanweb/images/Page1/LoadWeb.png" type="image/png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <style>
        h3 {
            color: #343a40;
            font-size: 2.5rem;
            font-weight: 700;
        }
        .login-btn {
            width: 30%;
            background-color: #343a40;
            color: aliceblue;
            font-size: 1.2rem;
            font-weight: 600;
            /* center */
            display: block;
            margin: 0 auto;
        }

        #loginForm {
            width: 80%;
            margin: 0 auto;
        }
        #signUpForm input, #loginForm input {
            border: 1px solid #343a40;
            padding: 10px;
        }
        #signUpForm input:focus, #loginForm input:focus {
            background-color: aliceblue;
        }
        #signUpForm button, #loginForm button {
            background-color: #343a40;
            color: aliceblue;
            border: none;
            font-weight: 600;
        }
        #signUpForm button:hover, #loginForm button:hover {
            background-color: #BC1F23;
            color: aliceblue;
            border: none;
        }
        #showSignUp {
            color: #BC1F23;
            font-weight: 600;
        }
        #showSignUp:hover {
            color: #343a40;
            text-decoration: none;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-dark py-4 fixed-top">
    <div class="container-fluid mr-5">
        <img src="<%= request.getContextPath() %>/doanweb/images/Page1/LogoWeb.png" onclick="location.reload();" id="logo-img" alt="logo..">


        <button class="navbar-toggler" onclick="toggleMenu()">
            <span><i id="nav-bar-icon" class="bi bi-list"></i></span>
        </button>

        <div class="search-bar">
            <input type="text" class="search-input" id="searchInput" placeholder="Tìm kiếm...">
            <button class="search-button" id="searchButton">
                <i class="bi bi-search"></i>
            </button>
        </div>

        <div id="searchResults" class="search-results"></div>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">

                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/home">Trang Chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/shop">Cửa Hàng</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/about">Thông tin</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/contact">Liên hệ</a>

                </li>
                <li class="nav-item" id="admin-btn" style="display: none;">
                    <a class="nav-link" href="<%= request.getContextPath() %>/admin">Quản trị</a>
                </li>
                <div class="nav-item" id="nav-icons">
                    <!-- <i class="bi bi-search"></i> -->
                    <a href="<%= request.getContextPath() %>/doanweb/html/Register.jsp"><i class="bi bi-person-fill"
                                                                                              id="user-icon"></i></a>
                    <!-- Biểu tượng giỏ hàng với số lượng sản phẩm -->
                    <a href="<%= request.getContextPath() %>/cart" class="position-relative">
                        <i class="bi bi-bag-heart-fill" style="font-size: 1.3rem; color: #BC1F23;"></i> <!-- Biểu tượng giỏ hàng -->
                        <!-- Số lượng sản phẩm trong giỏ -->
                        <span class="position-absolute top-0 start-90 translate-middle badge rounded-circle bg-danger"
                              id="cart-count"
                              style="width: 22px; height: 22px; line-height: 22px; font-size: 14px; text-align: center; display: flex; align-items: center; justify-content: center;">
                            ${sessionScope.totalItems != null ? sessionScope.totalItems : 0}
                        </span>
                    </a>

                </div>

            </ul>
        </div>


        <div id="mySideBar" class="sidebar">
            <div class="sidebar-header">
                <img src="<%= request.getContextPath() %>/doanweb/images/Page1/LogoWeb.png" alt="Logo" class="logo">
                <span id="closeBtn" class="close-btn" onclick="toggleMenu()">&times;</span>
            </div>
            <div class="sidebar-content">
                <div class="menu-section">
                    <h4><a href="<%= request.getContextPath() %>/home">TRANG CHỦ</a></h4>
                </div>
                <div class="menu-section">
                    <h4><a href="<%= request.getContextPath() %>/cart">GIỎ HÀNG</a></h4>
                </div>
                <div class="menu-section">
                    <h4><a href="<%= request.getContextPath() %>/about">VỀ MFS</a></h4>
                </div>
                <div class="menu-section">
                    <h4><a href="<%= request.getContextPath() %>/chinhsach">CHÍNH SÁCH</a></h4>
                </div>
                <div class="menu-section">
                    <h4><a href="javascript:void(0);" class="toggle-menu">THỰC ĐƠN</a></h4>
                    <ul class="submenu">
                        <li><a href="<%= request.getContextPath() %>/doanweb#">Combo gà phải thử</a></li>
                    </ul>
                </div>
                <div class="menu-section">
                    <h4><a href="<%= request.getContextPath() %>/doanweb/html/sidebar/DichVu.html">DỊCH VỤ</a></h4>
                </div>
                <div class="menu-section">
                    <h4><a href="<%= request.getContextPath() %>/contact">LIÊN HỆ</a></h4>
                </div>
                <div class="menu-section">
                    <h4><a href="<%= request.getContextPath() %>/doanweb/html/sidebar/job.html">TUYỂN DỤNG</a></h4>
                </div>

                <div class="menu-section user" id="user-sidebar">
                    <h4><i class="bi bi-person"></i><a href="<%= request.getContextPath() %>Login.html">ĐĂNG

                </div>
                    <div class="menu-section user-logged-in" id="user-logged-in" style="display: none;">
                        <span id="greeting-menu"></span>
                        <h4><i class="bi bi-person"></i><a href="javascript:void(0);" onclick="logout()">ĐĂNG XUẤT</a></h4>
                    </div>
                </div>
        </div>
</nav>

<!-- login section -->
<section id="featured" class="mt-3 pt-3">
    <div class="container text-center mt-5 pt-5">
        <h3 id="form-heading" class="mt-5 pt-5">Đăng Ký </h3>
        <hr class="border border-danger border-2 opacity-75 mx-auto">
    </div>
</section>

<div class="container mt-5" id="container-register">
    <div class="row">
        <div class="col-lg-6 col-md-6 col-12 mt-0">
            <img src="<%= request.getContextPath() %>/doanweb/images/Page1/LogoWeb.png" class="img-fluid" alt="login-img">
        </div>
        <div class="col-lg-6 col-md-6 col-12 mt-5">
            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <!-- Hiển thị thông báo thành công nếu có -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form id="signUpForm" action="<%= request.getContextPath() %>/register" method="post">
                <div class="form-group">
                    <label for="username">Tài Khoản</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your Email" required>
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Nhập Lại Mật Khẩu</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Enter your confirmPassword" required>
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại</label>
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Enter your phone" required>
                </div>
<%--                <div class="form-group">--%>
<%--                    <label for="address">Địa chỉ</label>--%>
<%--                    <input type="text" class="form-control" id="address" name="address" placeholder="Enter your address" required>--%>
<%--                </div>--%>

                <button type="submit" class="btn btn-dark">Đăng ký</button>
                <p class="py-2 text-center">Bạn có tài khoản rồi? <a href="<%= request.getContextPath() %>/login" id="showSignUp">Đăng Nhập</a></p>
            </form>
        </div>
    </div>
</div>




<footer class="mt-5 p-5 bg-dark">
    <div class="row conatiner mx-auto pt-5">
        <div class="footer-one col-lg-3 col-md-6 col-12">

            <img id="logo-img-footer" src="<%= request.getContextPath() %>/doanweb/images/Page1/LogoWeb.png" alt="logo">

        </div>

        <div class="footer-one col-lg-3 col-md-6 col-12 mb-3">
            <h5 class="pb-2">Liên kết nhanh</h5>
            <ul class="text-uppercase list-unstyled">
                <li><a href="<%= request.getContextPath() %>/home">trang chủ</a></li>
                <li><a href="<%= request.getContextPath() %>/shop">Cửa hàng</a></li>
                <li><a href="<%= request.getContextPath() %>/about">thông tin</a></li>
                <li><a href="<%= request.getContextPath() %>/contact">liên hệ</a></li>
                <li><a href="<%= request.getContextPath() %>/cart">Giỏ hàng</a></li>
            </ul>
        </div>
        <div class="footer-one col-lg-3 col-md-6 col-12 mb-3">
            <h5 class="pb-2">Liên hệ với chúng tôi</h5>
            <div>
                <h6 class="text-uppercase">Địa chỉ</h6>
                <p>Khu phố 6, Phường Linh Trung, TP. Thủ Đức, TP. Hồ Chí Minh</p>
            </div>
            <div>
                <h6 class="text-uppercase">điện thoại</h6>
                <p>0849294483</p>
            </div>
            <div>
                <h6 class="text-uppercase">Email</h6>
                <p>MarsStore@gmail.com</p>
            </div>
        </div>
        <div class="Photos col-lg-3 col-md-6 col-12">
            <h5 class="pb-2">Các đơn vị tài trợ</h5>
            <div class="row">
            </div>
        </div>
        <div class="copyright mt-5">
            <div class="row container mx-auto">
                <!-- <div class="col-lg-3 col-md-6 col-12 mb-4">
                  <img src="img/payment.png" alt="payment..logo">
                </div> -->

                <div class="col-lg-6 col-md-8 col-12 mb-2 mx-auto">
                    <p>MARSSTORE WEBSITE &copy; DESIGN 2024</p>
                </div>

                <div class="col-lg-3 col-md-6 col-12">
                    <a href="https://www.facebook.com/"><i class="bi bi-facebook"></i></a>
                    <a href="https://x.com/home?lang=vi"><i class="fa-brands fa-x-twitter"></i></a>
                    <a href="https://www.linkedin.com/feed/"><i class="bi bi-linkedin"></i></a>
                    <a href="https://www.instagram.com/"><i class="bi bi-instagram"></i></a>
                </div>
            </div>
        </div>
    </div>

</footer>
<!-- bootstarp cdn -->
</body>
</html>

<%--<div class="category-filter">--%>
<%--  <form action="<%= request.getContextPath() %>/shop" method="get">--%>
<%--    <label for="category">Chọn danh mục:</label>--%>
<%--    <select name="category" id="category">--%>
<%--      <option value="">Tất cả</option>--%>
<%--      <c:forEach var="category" items="${categoriesList}">--%>
<%--        <option value="${category.id}">${category.name}</option>--%>
<%--      </c:forEach>--%>
<%--    </select>--%>
<%--    <button type="submit">Lọc</button>--%>
<%--  </form>--%>
<%--</div>--%>