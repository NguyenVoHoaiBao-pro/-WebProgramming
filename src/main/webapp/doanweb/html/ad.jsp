<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.dao, entity.Products, entity.Categories" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Orders" %>
<%@ page import="entity.Users" %>
<%@ page import="entity.CartItem" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="dao.OrderDao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="com.google.gson.Gson" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Page</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        form { margin-bottom: 20px; }
        input, select { padding: 5px; margin: 5px 0; }
        button { padding: 5px 10px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        button:hover { background-color: #45a049; }
    </style>
</head>





<body>
<button id="backToTopBtn" onclick="scrollToTop()">⬆️</button>
<style>
    /* CSS cho nút "Lên đầu trang" */
    #backToTopBtn {
        position: fixed;
        bottom: 20px; /* Cách đáy màn hình 20px */
        right: 20px; /* Cách phải màn hình 20px */
        z-index: 1000; /* Đặt trên các phần tử khác */
        display: none; /* Ẩn nút ban đầu */
        background-color: #007bff; /* Màu nền */
        color: white; /* Màu chữ */
        border: none; /* Xóa viền */
        border-radius: 50%; /* Bo tròn nút */
        padding: 10px 15px; /* Kích thước nút */
        cursor: pointer; /* Hiển thị con trỏ */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Đổ bóng */
        font-size: 16px; /* Kích thước chữ */
    }

    #backToTopBtn:hover {
        background-color: #0056b3; /* Màu khi hover */
    }
</style>
<h1>Admin Quản lý sản phẩm</h1>
<label for="searchInput"></label>
<input
        type="text"
        id="searchInput"
        placeholder="Tìm kiếm sản phẩm..."
        oninput="searchProduct()"
        onkeypress="handleEnter(event)"
        style="width: 300px; padding: 5px; margin-bottom: 20px;"
>
<button onclick="searchProduct()" style="padding: 5px 10px; margin-left: 10px;">Tìm kiếm</button>
<%
    dao daoInstance = new dao();
    List<Products> productList = daoInstance.getAllProducts();
    List<Categories> categoryList = daoInstance.getAllCategories();
    String deleteProductId = request.getParameter("deleteProductId");
    String deleteCategoryId = request.getParameter("deleteCategoryId");

    // Xóa sản phẩm
    if (deleteProductId != null) {
        daoInstance.deleteProduct(Integer.parseInt(deleteProductId));
    }

    // Xóa danh mục
    if (deleteCategoryId != null) {
        daoInstance.deleteCategory(Integer.parseInt(deleteCategoryId));
    }
%>


<form action="AddProduct" method="post" enctype="multipart/form-data">
    <h3>Thêm/Sửa sản phẩm</h3>
    <input type="hidden" name="id" placeholder="ID (chỉ nhập khi sửa)">
    <label>
        <input type="text" name="name" placeholder="Tên sản phẩm" required>
    </label>
    <label>
        <input type="text" name="description" placeholder="Mô tả sản phẩm" required>
    </label>
    <label>
        <input type="number" name="price" placeholder="Giá sản phẩm" required>
    </label>
    <label>
        <input type="number" name="stock" placeholder="Số lượng tồn" required>
    </label>
    <label>
        <input type="file" name="image" accept="image/*" multiple required>
    </label>
    <label>
        <select name="category_id" required>
            <option value="">Chọn danh mục</option>
            <% for (Categories category : categoryList) { %>
            <option value="<%= category.getId() %>"><%= category.getName() %></option>
            <% } %>
        </select>
    </label>
    <button type="submit">Thêm sản phẩm</button>
</form>


<!-- Hiển thị danh sách sản phẩm -->
<table>
    <tr>
        <th>ID</th>
        <th>Tên sản phẩm</th>
        <th>Mô tả</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Hình ảnh</th>
        <th>Danh mục</th>
        <th>Hành động</th>
    </tr>
    <% for (Products product : productList) { %>
    <tr>

        <td><%= product.getId() %></td>
        <td><%= product.getName() %></td>
        <td><%= product.getDescription() %></td>
        <td><%= product.getPrice() %></td>
        <td><%= product.getStock() %></td>
        <td><img src="<%= product.getImage() %>" alt="<%= product.getName() %>" style="width: 50px;"></td>
        <td><%= product.getCategoryId() %></td>
        <td>
            <form action="UpdateProduct" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= product.getId() %>">
                <label>
                    <input type="text" name="name" value="<%= product.getName() %>" required>
                </label>
                <label>
                    <input type="text" name="description" value="<%= product.getDescription() %>" required>
                </label>
                <label>
                    <input type="number" name="price" value="<%= product.getPrice() %>" required>
                </label>
                <label>
                    <input type="number" name="stock" value="<%= product.getStock() %>" required>
                </label>
                <label>
                    <input type="text" name="image" value="<%= product.getImage() %>" required>
                </label>
                <label>
                    <select name="category_id" required>
                        <% for (Categories category : categoryList) { %>
                        <option value="<%= category.getId() %>" <%= (category.getId() == product.getCategoryId()) ? "selected" : "" %>>
                            <%= category.getName() %>
                        </option>
                        <% } %>
                    </select>
                </label><br>
                <button type="submit">Cập nhật</button>
            </form>

            <a href="DeleteProduct?id=<%= product.getId() %>" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
        </td>
    </tr>
    <% } %>
</table>

<!-- Quản lý danh mục -->
<h2>Quản lý danh mục</h2>
<form action="AddCategory" method="post">
    <h3>Thêm danh mục mới</h3>
    <label>
        <input type="text" name="categoryName" placeholder="Tên danh mục" required>
    </label>
    <button type="submit">Thêm danh mục</button>
</form>

<table>
    <tr>
        <th>ID</th>
        <th>Tên danh mục</th>
        <th>Hành động</th>
    </tr>
    <% for (Categories category : categoryList) { %>
    <tr>
        <td><%= category.getId() %></td>
        <td><%= category.getName() %></td>
        <td>
            <a href="DeleteCategory?id=<%= category.getId() %>" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">Xóa</a>        </td>
    </tr>
    <% } %>
</table>
<h2>Danh sách đơn hàng</h2>

<button onclick="loadOrders()">Tải đơn hàng</button>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Khách hàng</th>
        <th>Sản phẩm</th>
        <th>Tổng tiền</th>
        <th>Ngày đặt</th>
    </tr>
    </thead>
    <tbody id="orderTableBody">
    <!-- Dữ liệu JSON sẽ được hiển thị ở đây -->
    </tbody>
</table>

<script>
    function loadOrders() {
        $.ajax({
            url: "/processOrder",
            type: "POST",
            contentType: "application/json",
            success: function(response) {
                if (response.error) {
                    alert(response.error);
                    return;
                }

                let order = response.order;
                let user = response.user;
                let cartItems = order.cartItems;

                let orderRow = `<tr>
                        <td>${order.orderId}</td>
                        <td>${user.name} (${user.email})</td>
                        <td>${cartItems.map(item => item.product.name + " x " + item.quantity).join(", ")}</td>
                        <td>${order.totalAmount}</td>
                        <td>${new Date(order.orderDate).toLocaleString()}</td>
                    </tr>`;

                $("#orderTableBody").append(orderRow);
            },
            error: function() {
                alert("Lỗi khi tải dữ liệu!");
            }
        });
    }
</script>
</body>
</html>
