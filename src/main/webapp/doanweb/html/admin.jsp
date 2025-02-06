<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

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
