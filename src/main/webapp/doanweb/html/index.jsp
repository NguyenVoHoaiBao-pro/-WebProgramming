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


    <script src="<%= request.getContextPath() %>/doanweb/js/index.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <!-- bootstarp stackpath cdn -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
          integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <!-- Bootstrap icons cdn-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .product img {
            margin-right: 50px;
            margin-left: 20px;
            width: 90%;
            max-width: 350px;
            height: 350px;
            object-fit: cover;
        }

        .product-name {
            color: black;
            font-weight: bold;
        }
    </style>
</head>

<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-dark py-4 fixed-top">
    <div class="container-fluid mr-5">
        <img src="<%= request.getContextPath() %>/doanweb/images/Page1/LogoWeb.png" onclick="location.reload();"
             id="logo-img" alt="logo..">

        <button class="navbar-toggler" onclick="toggleMenu()">
            <span><i id="nav-bar-icon" class="bi bi-list"></i></span>
        </button>

        <div class="search-bar">
            <label for="searchInput"></label>
            <input type="text" class="search-input" id="searchInput" name="productName" placeholder="Tìm kiếm...">
            <button class="search-button" id="searchButton">
                <i class="bi bi-search"></i>
            </button>
        </div>

        <div id="searchResults" class="search-results">
            <c:if test="${not empty productsList}">
                <div class="product-list">
                    <c:forEach var="product" items="${productsList}">
                        <div class="product-item">
                            <img class="img-fluid" src="<%= request.getContextPath() %>/${product.image}"/>
                            <p><strong>${product.name}</strong></p>
                            <p> - ${product.price}</p>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">

                <li class="nav-item">
                    <a class="nav-link active" href="#">Trang Chủ</a>
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
<%--                <li class="nav-item" id="admin-btn" style="display: <%=--%>
<%--                    (session.getAttribute("role") != null &&--%>
<%--                    (Integer.parseInt((String)session.getAttribute("role")) == 1)) ? "block" : "none"--%>
<%--                    %>;">--%>
<%--                    <a class="nav-link" href="<%= request.getContextPath() %>/ad">Quản trị</a>--%>
<%--                </li>--%>


                <div class="nav-item" id="nav-icons">
                    <a href="<%= (session.getAttribute("user") != null) ? request.getContextPath() + "/profile" : request.getContextPath() + "/doanweb/html/Login.jsp" %>">
                        <i class="bi bi-person-fill" id="user-icon"></i>
                    </a>

                    <a href="<%= request.getContextPath() %>/cart" class="position-relative">
                        <i class="bi bi-bag-heart-fill" style="font-size: 1.3rem; color: #BC1F23;"></i>
                        <!-- Biểu tượng giỏ hàng -->
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
                        <li><a href="<%= request.getContextPath() %>/shop">Các món đùi gà nổi bật</a></li>
                        <li><a href="<%= request.getContextPath() %>/shop">Các món cánh gà nổi bật</a></li>
                        <li><a href="<%= request.getContextPath() %>/shop">Combo gà phải thử</a></li>
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
                    <h4><i class="bi bi-person"></i><a href="<%= request.getContextPath() %>/login">ĐĂNG
                        NHẬP</a> / <a href="<%= request.getContextPath() %>/register">ĐĂNG KÝ</a></h4>

                </div>
                <div class="menu-section user-logged-in" id="user-logged-in" style="display: none;">
                    <span id="greeting-menu"></span>
                    <h4><a href="<%= request.getContextPath() %>/profile">TÀI KHOẢN CỦA TÔI / </a></h4>
                    <h4><i class="bi bi-person"></i><a href="javascript:void(0);" onclick="logout()">ĐĂNG XUẤT</a></h4>
                </div>
            </div>
        </div>
</nav>

<!-- Home Section -->
<section id="home">
    <div id="home-bg" class="container my-10">
        <div class="text-container">
            <h5>Món ăn mới</h5>
            <h1><span>Best Sale </span>This Year</h1>
            <p>Món gà truyền thống kết hợp với sốt ớt cay nồng <br>Tạo nên hương vị khó cưỡng mỗi khi ăn !</p>
            <button onclick="window.location.href = '<%= request.getContextPath() %>/shop';">Mua
                ngay
            </button>
        </div>
    </div>
</section>

<!-- Services section-->
<section id="company-services" class="container p-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-6 pb-3">
                <div class="icon-box d-flex">
                    <div class="icon-box-icon pe-3 pb-3">
                        <span><i class="bi bi-cart"></i></span>
                    </div>
                    <div class="icon-box-content">
                        <h3 class="card-title text-uppercase text-dark">Giao hàng miễn phí</h3>
                        <p>Miễn phí giao hàng khi đặt từ 2 phần gà trở lên và khi mua cả combo đủ vị <span
                                style="color: rgb(255, 0, 0)">mới nhất.</span></p>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 pb-3">
                <div class="icon-box d-flex">
                    <div class="icon-box-icon pe-3 pb-3">
                        <span><i class="bi bi-award"></i></span>
                    </div>
                    <div class="icon-box-content">
                        <h3 class="card-title text-uppercase text-dark">Chất lượng hàng đầu Việt Nam</h3>
                        <p>100% đảm bảo gà có nguồn gốc rõ ràng , và có giấy chứng nhận vệ sinh an toàn thực phẩm của bộ
                            y tế.</p>

                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 pb-3">
                <div class="icon-box d-flex">
                    <div class="icon-box-icon pe-3 pb-3">
                        <span><i class="bi bi-tags"></i></span>
                    </div>
                    <div class="icon-box-content">
                        <h3 class="card-title text-uppercase text-dark">Ưu đãi hằng ngày</h3>
                        <p>Giảm 15% cho các khách hàng thân thiết và đơn hàng đầu tiên của các khách hàng mới.</p>

                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 pb-3">
                <div class="icon-box d-flex">
                    <div class="icon-box-icon pe-3 pb-3">
                        <span><i class="bi bi-shield-check"></i></span>
                    </div>
                    <div class="icon-box-content">
                        <h3 class="card-title text-uppercase text-dark">bảo mật thông tin khách hàng</h3>
                        <p>Trải nghiệm sự an tâm với cổng thanh toán an toàn 100% của chúng tôi.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Product images section -->
<section id="new" class="w-100">
    <div class="row m-0 p-0">
        <div class="one col-lg-4 col-md-12 col-12 p-0">
            <img class="img-fluid"
                 src="<%= request.getContextPath() %>/doanweb/images/duigaimg/Pasted%20image%20(104).png" alt="">
            <div class="details">
                <h2>Đùi Gà</h2>
                <button class="text-uppercase"
                        onclick="window.location.href = '<%= request.getContextPath() %>/shop?categoryId=1';">Mua
                    ngay
                </button>
            </div>
        </div>

        <div class="one col-lg-4 col-md-12 col-12 p-0">
            <img class="img-fluid" src="<%= request.getContextPath() %>/doanweb/images/Page1/comboga_1.webp" alt="">
            <div class="details">
                <h2>Combo Gà đủ vị</h2>
                <button class="text-uppercase"
                        onclick="window.location.href = '<%= request.getContextPath() %>/shop?categoryId=3';">Mua ngay
                </button>

            </div>
        </div>

        <div class="one col-lg-4 col-md-12 col-12 p-0">
            <img class="img-fluid" src="<%= request.getContextPath() %>/doanweb/images/Page1/canhga_1.jpg" alt="">
            <div class="details">
                <h2>Cánh Gà</h2>
                <button class="text-uppercase"
                        onclick="window.location.href = '<%= request.getContextPath() %>/shop?categoryId=2';">Mua
                    ngay
                </button>
            </div>
        </div>


    </div>
</section>

<section id="featured" class="my-5 pb-5">
    <div class="container text-center mt-5 py-5">
        <h3>Các món mới</h3>
        <hr class="border border-danger border-2 opacity-75 mx-auto">
        <p style="font-size: 18px">Tại đây có các món mới ra của cửa hàng !</p>
    </div>
    <div class="row mx-auto container-fluid">
        <c:if test="${not empty randomProductList}">
            <c:forEach var="product" items="${randomProductList}" varStatus="status">
                <!-- Chỉ hiển thị 4 sản phẩm đầu tiên -->
                <c:if test="${status.index < 4}">
                    <div class="product text-center col-lg-3 col-md-4 col-12 mb-4">
                        <a href="detail?id=${product.id}">
                            <img class="img-fluid" src="<%= request.getContextPath() %>/${product.image}"
                                 alt="${product.name}">
                            <h5 class="product-name">${product.name}</h5>
                            <h4 class="product-price">${product.price} VND</h4>
                        </a>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </div>
</section>

<!-- Banner -->
<section id="banner" class="my-5 py-5"
         src="<%= request.getContextPath() %>/doanweb/images/duigaimg/Pasted image (103).png">
    <div class="ml-5 mr-5">
        <h4>Giảm giá cuối năm</h4>
        <h1>Tăng tiêu dùng cuối năm<br>Giảm 20% cho các đơn hàng có giá trị trên 350.000 VND.</h1>
        <button class="text-uppercase"
                onclick="window.location.href = '<%= request.getContextPath() %>/shop';">Mua ngay
        </button>
    </div>
</section>
<section id="combo" class="my-5">
    <div class="container text-center mt-5 py-5">
        <h3>Combo Gà đủ vị</h3>
        <hr class="border border-danger border-2 opacity-75 mx-auto">
        <p style="font-size: 18px">Tại đây có bán combo gà ngũ vị bán chạy nhất trong năm của <span
                style="color: rgb(255, 0, 0)">Cửa hàng.</span></p>
    </div>
    <div class="row mx-auto container-fluid">
        <c:if test="${not empty category3ProductList}">
            <c:forEach var="product" items="${category3ProductList}" varStatus="status">
                <c:if test="${status.index < 4}">
                    <div class="product text-center col-lg-3 col-md-4 col-12 mb-4">
                        <a href="detail?id=${product.id}">
                            <img class="img-fluid" src="<%= request.getContextPath() %>/${product.image}"
                                 alt="${product.name}">
                            <h5 class="product-name">${product.name}</h5>
                            <h4 class="product-price">${product.price} VND</h4>
                        </a>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </div>
</section>


<section id="wing" class="my-12">
    <div class="container text-center mt-5 py-5">
        <h3>Cánh gà</h3>
        <hr class="border border-danger border-2 opacity-75 mx-auto">
        <p style="font-size: 18px">Ở đây có cánh gà to chắc và được mua nhiều nhất năm! </p>
    </div>
    <div class="row mx-auto container-fluid">
        <c:if test="${not empty category2ProductList}">
            <c:forEach var="product" items="${category2ProductList}" varStatus="status">
                <c:if test="${status.index < 4}">
                    <div class="product text-center col-lg-3 col-md-4 col-12 mb-4">
                        <a href="detail?id=${product.id}">
                            <img class="img-fluid" src="<%= request.getContextPath() %>/${product.image}"
                                 alt="${product.name}">
                            <h5 class="product-name">${product.name}</h5>
                            <h4 class="product-price">${product.price} VND</h4>
                        </a>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </div>
</section>

<section id="leg" class="my-12">
    <div class="container text-center mt-5 py-5">
        <h3>Đùi gà</h3>
        <hr class="border border-danger border-2 opacity-75 mx-auto">
        <p style="font-size: 18px">Ở đây có đùi gà to chắc và được mua nhiều nhất năm! </p>
    </div>
    <div class="row mx-auto container-fluid">
        <c:if test="${not empty category1ProductList}">
            <c:forEach var="product" items="${category1ProductList}" varStatus="status">
                <c:if test="${status.index < 4}">
                    <div class="product text-center col-lg-3 col-md-4 col-12 mb-4">
                        <a href="detail?id=${product.id}">
                            <img class="img-fluid" src="<%= request.getContextPath() %>/${product.image}"
                                 alt="${product.name}">
                            <h5 class="product-name">${product.name}</h5>
                            <h4 class="product-price">${product.price} VND</h4>
                        </a>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </div>
</section>


<br><br><br><br><br><br><br><br>
<footer class="mt-5 p-5 bg-dark">
    <div class="row conatiner mx-auto pt-5">
        <div class="footer-one col-lg-3 col-md-6 col-12">

            <img id="logo-img-footer" src="<%= request.getContextPath() %>/doanweb/images/Page1/LogoWeb.png" alt="logo">
            <p class="py-3 pl-2 ml-4 mr-5">Tiệm Gà Sao Hỏa là một quán ăn hiện đại với phong cách thiết kế đậm chất
                không gian. Thực đơn của quán không chỉ có các món gà nổi tiếng, mà còn kèm theo những món ăn độc lạ lấy
                cảm hứng từ vũ trụ mang lại cảm giác mới mẻ cho thực khách.</p>

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
                <img class="footer-img img-fluid mb-2"
                     src="<%= request.getContextPath() %>/doanweb/images/Page1/image copy 3.png" alt="leather-img">
                <img class="footer-img img-fluid mb-2"
                     src="<%= request.getContextPath() %>/doanweb/images/Page1/image copy 2.png" alt="leather-img">
                <img class="footer-img img-fluid mb-2"
                     src="<%= request.getContextPath() %>/doanweb/images/Page1/image copy.png" alt="leather-img">
                <img class="footer-img img-fluid mb-2"
                     src="<%= request.getContextPath() %>/doanweb/images/Page1/image.png" alt="leather-img">
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
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
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