<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tiem ga sao hoa</title>
  <link rel="icon" href="<%= request.getContextPath() %>/doanweb/images/Page1/LoadWeb.png" type="image/png">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/doanweb/styles/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<%--  <script src="/js/index.js"></script>--%>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

  <style>
    h3 {
      color: #000000;
      font-size: 2.5rem;
      font-weight: 700;
    }
    footer{
      color: white;
    }
    footer a{
      color: #ddd;
      text-decoration: none;
    }
    footer a:hover {
      color: white;
    }

  </style>

</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-dark py-4 fixed-top">
  <div class="container-fluid mr-5">
    <!-- <div class="col-1"></div> -->
    <img src="<%= request.getContextPath() %>/doanweb/images/Page1/LogoWeb.png" onclick="location.reload();" id="logo-img" alt="logo..">

    <button class="navbar-toggler" onclick="toggleMenu()">
      <span><i id = "nav-bar-icon" class="bi bi-list"></i></span>
    </button>
    <div class="search-bar">
      <label for="searchInput"></label><input type="text" class="search-input" id="searchInput" placeholder="Tìm kiếm...">
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
        <!-- <li class="nav-item">
            <a class="nav-link" href="#">Quality</a>
        </li> -->
        <li class="nav-item">
          <a class="nav-link" href="<%= request.getContextPath() %>/about">Thông tin</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= request.getContextPath() %>/contact">Liên hệ</a>

        </li>
        <li class="nav-item" id="nav-icons">
          <!-- <i class="bi bi-search"></i> -->
          <a href="<%= request.getContextPath() %>/login"><i class="bi bi-person-fill"></i></a>
          <a href="<%= request.getContextPath() %>/cart"><i class="bi bi-bag-heart-fill"></i></a>
        </li>

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
            <li><a href="#">Combo gà phải thử</a></li>
          </ul>
        </div>
        <div class="menu-section">
          <h4><a href="#">DỊCH VỤ</a></h4>
        </div>
        <div class="menu-section">
          <h4><a href="<%= request.getContextPath() %>/contact">LIÊN HỆ</a></h4>
        </div>
        <div class="menu-section">
          <h4><a href="#">TUYỂN DỤNG</a></h4>
        </div>

        <div class="menu-section user" id="user-sidebar">
          <h4><i class="bi bi-person"></i><a href="<%= request.getContextPath() %>/login">ĐĂNG NHẬP</a> / <a href="<%= request.getContextPath() %>/register">ĐĂNG KÝ</a></h4>

        </div>
        <div class="menu-section user-logged-in" id="user-logged-in" style="display: none;">
          <span id="greeting-menu"></span>
          <h4><a href="<%= request.getContextPath() %>/profile">TÀI KHOẢN CỦA TÔI / </a></h4>
          <h4><i class="bi bi-person"></i><a href="javascript:void(0);" onclick="logout()">ĐĂNG XUẤT</a></h4>
        </div>
      </div>
    </div>
</nav>

<section id="featured" class="mt-5 pt-5">
  <div class="container text-center ">
    <h3 id="form-heading" class="mt-5">Thông Tin Cá Nhân</h3>
    <hr class="border border-danger border-2 opacity-75 mx-auto">
  </div>
</section>

<div class="container mt-4">
  <div class="profile-layout">
    <!-- Sidebar -->
    <div class="profile-bar">
      <div class="profile-header">
        <img src="<%= request.getContextPath() %>/doanweb/images/Page1/IconLogo.png" alt="Avatar" class="avatar">
        <span class="profile-greeting" id="profile-greeting">XIN CHÀO, ${user.username}</span>
      </div>
      <ul class="menu-links">
        <li><a href="javascript:void(0);" onclick="showProfileForm()">Thông tin cá nhân</a></li>
        <li><a href="javascript:void(0);" onclick="showChangeProfileForm()">Chỉnh sửa thông tin</a></li>
        <li id="admin-link" style="display:none;">
          <a href="javascript:void(0);" onclick="window.location.href = '/ad';">Quản trị</a>
        </li>
        <li><a href="javascript:void(0);" onclick="showChangePasswordForm()">Đặt lại mật khẩu</a></li>
        <li><a href="javascript:void(0);" onclick="showDeleteAccountForm()">Xóa tài khoản</a></li>
      </ul>
      <form action="/logout" method="POST" id="logout-form">
        <button type="submit" class="logout-btn">ĐĂNG XUẤT</button>
      </form>
    </div>


    <!-- Profile Form -->
    <div class="profile-form" id="profile-form">
        <form method="post" action="/profile?action=showinfo">
        <!-- Hiển thị thông tin tên người dùng -->
        <div class="mb-3">
          <label for="name" class="form-label">Họ và Tên</label>
          <span class="form-control" id="name">${user.username}</span>
        </div>

        <!-- Hiển thị thông tin số điện thoại -->
        <div class="mb-3">
          <label for="phone" class="form-label">Số Điện Thoại</label>
          <span class="form-control" id="phone">${user.phone}</span>
        </div>

        <!-- Hiển thị thông tin email -->
        <div class="mb-3">
          <label for="email" class="form-label">Email</label>
          <span class="form-control" id="email">${user.email}</span>
        </div>

        <!-- Hiển thị thông tin địa chỉ -->
        <div class="mb-3">
          <label for="address" class="form-label">Địa Chỉ</label>
          <span class="form-control" id="address">${user.address}</span>
        </div>

      </form>
    </div>

    <!-- Profile Form -->
    <div class="profile-form" id="change-profile-form" style="display: none;">
      <form method="post" action="/profile?action=changeInfo">
        <!-- Hiển thị thông tin tên người dùng -->
        <div class="mb-3">
          <label for="name" class="form-label">Họ và Tên</label>
          <span class="form-control" id="edit-name">${user.username}</span>
        </div>

        <!-- Hiển thị thông tin số điện thoại -->
        <div class="mb-3">
          <label for="phone" class="form-label">Số Điện Thoại</label>
          <input type="text" class="form-control" id="newPhone" name="newPhone" required>

        </div>

        <!-- Hiển thị thông tin email -->
        <div class="mb-3">
          <label for="email" class="form-label">Email</label>
          <input type="text" class="form-control" id="newEmail" name="newEmail" required>
        </div>

        <!-- Hiển thị thông tin địa chỉ -->
        <div class="mb-3">
          <label for="address" class="form-label">Địa Chỉ</label>
          <input type="text" class="form-control" id="newAddress" name="newAddress" required>
        </div>

        <!-- Nút chỉnh sửa -->
        <button type="submit" class="btn-profile" id="edit-profile">Chỉnh sửa
        </button>
      </form>
    </div>

    <!-- Change Password Form -->
    <div class="changedpw-form" id="change-password-form" style="display: none;">
      <form method="post" action="/profile?action=change-pass">
        <h3>Đổi mật khẩu</h3> <!-- Bạn có thể thêm tiêu đề này nếu muốn -->
        <div class="mb-3">
          <label for="oldPassword" class="form-label">Mật khẩu cũ</label>
          <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
        </div>
        <div class="mb-3">
          <label for="newPassword" class="form-label">Mật khẩu mới</label>
          <input type="password" class="form-control" id="newPassword" name="newPassword" required>
        </div>
        <div class="mb-3">
          <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
          <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
        </div>
        <button type="submit" class="btn-profile" id="btn-change-password">Cập nhật mật khẩu</button>
      </form>
    </div>


    <!-- Delete Account Form -->
    <div class="delete-account-form" id="delete-account-form" style="display: none;">
        <form method="post" action="/profile?action=deleteAccount">
        <h3>Xóa tài khoản</h3> <!-- Bạn có thể thêm tiêu đề này nếu muốn -->
        <div class="mb-3">
          <label for="confirmDelete" class="form-label">Nhập mật khẩu để xác nhận xóa tài khoản</label>
          <input type="password" class="form-control" id="confirmDelete" name="confirmDelete" required>
        </div>
        <button type="submit" class="btn-profile" id="btn-delete-account">Xóa tài khoản</button>
      </form>
    </div>
  </div>
</div>


<script>
  // Lấy giá trị role từ session và chuyển sang JavaScript
  var role = "<%= session.getAttribute("role") != null ? session.getAttribute("role").toString() : "0" %>";

  // Hàm ẩn tất cả các form
  function hideAllForms() {
    document.getElementById('profile-form').style.display = 'none';
    document.getElementById('change-profile-form').style.display = 'none';
    document.getElementById('change-password-form').style.display = 'none';
    document.getElementById('delete-account-form').style.display = 'none';
    document.getElementById('admin-link').style.display = 'none';
  }

  // Hàm hiển thị form Thông tin cá nhân
  function showProfileForm() {
    hideAllForms(); // Ẩn các form khác
    document.getElementById('profile-form').style.display = 'block'; // Hiển thị form profile
  }

  // Hàm hiển thị form Chỉnh sửa thông tin cá nhân
  function showChangeProfileForm() {
    hideAllForms(); // Ẩn các form khác
    document.getElementById('change-profile-form').style.display = 'block'; // Hiển thị form chỉnh sửa thông tin
  }

  // Hàm hiển thị form Đổi mật khẩu
  function showChangePasswordForm() {
    hideAllForms(); // Ẩn các form khác
    document.getElementById('change-password-form').style.display = 'block'; // Hiển thị form đổi mật khẩu
  }

  // Hàm hiển thị form Xóa tài khoản
  function showDeleteAccountForm() {
    hideAllForms(); // Ẩn các form khác
    document.getElementById('delete-account-form').style.display = 'block'; // Hiển thị form xóa tài khoản
  }

  // Hàm hiển thị form Quản trị nếu đăng nhập và role = 1
  function showAdminLink() {
    if (role === "1") {
      // Hiển thị form quản trị nếu role = 1
      document.getElementById('admin-link').style.display = 'block';
    } else {
      // Nếu không phải role = 1, ẩn form quản trị
      document.getElementById('admin-link').style.display = 'none';
    }
  }

  showAdminLink();
</script>


<footer class="mt-5 p-5 bg-dark">
  <div class="row conatiner mx-auto pt-5">
    <div class="footer-one col-lg-3 col-md-6 col-12">

      <img id="logo-img-footer" src="<%= request.getContextPath() %>/doanweb/images/Page1/LogoWeb.png" alt="logo">
      <p class="py-3 pl-2 ml-4 mr-5">Tiệm Gà Sao Hỏa là một quán ăn hiện đại với phong cách thiết kế đậm chất không gian. Thực đơn của quán không chỉ có các món gà nổi tiếng, mà còn kèm theo những món ăn độc lạ lấy cảm hứng từ vũ trụ mang lại cảm giác mới mẻ cho thực khách.</p>

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
        <img class="footer-img img-fluid mb-2" src="<%= request.getContextPath() %>/doanweb/images/Page1/image copy 3.png" alt="leather-img">
        <img class="footer-img img-fluid mb-2" src="<%= request.getContextPath() %>/doanweb/images/Page1/image copy 2.png" alt="leather-img">
        <img class="footer-img img-fluid mb-2" src="<%= request.getContextPath() %>/doanweb/images/Page1/image copy.png" alt="leather-img">
        <img class="footer-img img-fluid mb-2" src="<%= request.getContextPath() %>/doanweb/images/Page1/image.png" alt="leather-img">
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
</footer>


<!-- bootstarp cdn -->

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>