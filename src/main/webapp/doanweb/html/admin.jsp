<%@ page import="entity.Orders, entity.Users" %><%@ page import="com.google.gson.Gson"%>
<%@ page contentType="application/json" pageEncoding="UTF-8" %>
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

<%
    String orderJson = request.getParameter("order");
    String userJson = request.getParameter("user");

    // Optionally, use Gson to deserialize the JSON data into objects
    Gson gson = new Gson();
    Orders order = gson.fromJson(orderJson, Orders.class);
    Users user = gson.fromJson(userJson, Users.class);
%>

<h1>Order Details</h1>
<p>User: ${user.name}</p>
<p>Order ID: ${order.orderId}</p>
<p>Total Amount: ${order.totalAmount}</p>
<p>Order Date: ${order.orderDate}</p>

<h2>Cart Items</h2>
<table>
<thead>
<tr>
<th>Product Name</th>
<th>Quantity</th>
<th>Total Price</th>
</tr>
</thead>
<tbody>
<c:forEach var="item" items="${order.cartItems}">
<tr>
<td>${item.product.name}</td>
<td>${item.quantity}</td>
<td>${item.totalPrice}K</td>
</tr>
</c:forEach>
</tbody>
</table>
