package dao;

import entity.CartItem;
import entity.Orders;
import entity.Products;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {
    private Connection connection;

    public OrderDao(Connection connection) {
        this.connection = connection;
    }

    public boolean saveOrder(Orders order) throws SQLException {
        String orderSQL = "INSERT INTO orders (User_ID, total_amount, order_date) VALUES (?, ?, ?)";
        String cartItemSQL = "INSERT INTO cart_items (Order_ID, P_ID, quantity, total_price) VALUES (?, ?, ?, ?)";

        try (PreparedStatement orderStmt = connection.prepareStatement(orderSQL, PreparedStatement.RETURN_GENERATED_KEYS)) {
            // Insert order
            orderStmt.setInt(1, order.getUserId());
            orderStmt.setInt(2, order.getTotalAmount());
            orderStmt.setTimestamp(3, new java.sql.Timestamp(order.getOrderDate().getTime()));
            orderStmt.executeUpdate();

            // Get generated order ID
            var generatedKeys = orderStmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int orderId = generatedKeys.getInt(1);

                // Insert cart items
                try (PreparedStatement cartItemStmt = connection.prepareStatement(cartItemSQL)) {
                    for (CartItem item : order.getCartItems()) {
                        cartItemStmt.setInt(1, orderId);
                        cartItemStmt.setInt(2, item.getProduct().getId());
                        cartItemStmt.setInt(3, item.getQuantity());
                        cartItemStmt.setInt(4, item.getTotalPrice());
                        cartItemStmt.addBatch();
                    }
                    cartItemStmt.executeBatch();
                }
                return true;
            }
        }
        return false;
    }
    // Lấy tất cả đơn hàng
    public List<Orders> getAllOrders() throws SQLException {
        List<Orders> orders = new ArrayList<>();
        String orderSQL = "SELECT * FROM orders";
        String cartItemSQL = "SELECT * FROM cart_items WHERE Order_ID = ?";

        try (PreparedStatement orderStmt = connection.prepareStatement(orderSQL);
             ResultSet orderRs = orderStmt.executeQuery()) {

            // Duyệt qua tất cả các đơn hàng
            while (orderRs.next()) {
                int orderId = orderRs.getInt("Order_ID");
                int userId = orderRs.getInt("User_ID");
                int totalAmount = orderRs.getInt("total_amount");
                Timestamp orderDate = orderRs.getTimestamp("order_date");

                // Tạo đối tượng Order và thêm vào danh sách
                Orders order = new Orders(orderId, userId, totalAmount, orderDate);

                // Lấy các cart items tương ứng với đơn hàng
                try (PreparedStatement cartItemStmt = connection.prepareStatement(cartItemSQL)) {
                    cartItemStmt.setInt(1, orderId);
                    try (ResultSet cartItemRs = cartItemStmt.executeQuery()) {
                        List<CartItem> cartItems = new ArrayList<>();

                        while (cartItemRs.next()) {
                            int productId = cartItemRs.getInt("P_ID");
                            int quantity = cartItemRs.getInt("quantity");
                            int totalPrice = cartItemRs.getInt("total_price");

                            // Tạo đối tượng CartItem và thêm vào danh sách
                            Products product = new Products(productId); // Giả sử Product chỉ cần ID, bạn có thể thêm chi tiết sản phẩm nếu cần
                            CartItem cartItem = new CartItem(product, quantity);
                            cartItems.add(cartItem);
                        }

                        order.setCartItems(cartItems); // Thiết lập cart items cho đơn hàng
                    }
                }

                orders.add(order); // Thêm đơn hàng vào danh sách
            }
        }
        return orders;
    }
    public Orders getOrderById(int orderId) throws SQLException {
        String orderSQL = "SELECT * FROM orders WHERE Order_ID = ?";
        String cartItemSQL = "SELECT * FROM cart_items WHERE Order_ID = ?";

        try (PreparedStatement orderStmt = connection.prepareStatement(orderSQL)) {
            orderStmt.setInt(1, orderId);
            try (ResultSet orderRs = orderStmt.executeQuery()) {
                if (orderRs.next()) {
                    int userId = orderRs.getInt("User_ID");
                    int totalAmount = orderRs.getInt("total_amount");
                    Timestamp orderDate = orderRs.getTimestamp("order_date");

                    Orders order = new Orders(orderId, userId, totalAmount, orderDate);

                    try (PreparedStatement cartItemStmt = connection.prepareStatement(cartItemSQL)) {
                        cartItemStmt.setInt(1, orderId);
                        try (ResultSet cartItemRs = cartItemStmt.executeQuery()) {
                            List<CartItem> cartItems = new ArrayList<>();
                            while (cartItemRs.next()) {
                                int productId = cartItemRs.getInt("P_ID");
                                int quantity = cartItemRs.getInt("quantity");
                                int totalPrice = cartItemRs.getInt("total_price");

                                Products product = new Products(productId); // Chỉ sử dụng ID, hoặc thêm chi tiết nếu cần
                                CartItem cartItem = new CartItem(product, quantity);
                                cartItems.add(cartItem);
                            }
                            order.setCartItems(cartItems);
                        }
                    }
                    return order;
                }
            }
        }
        return null; // Không tìm thấy đơn hàng
    }
    public List<Orders> getOrdersByUserId(int userId) throws SQLException {
        List<Orders> orders = new ArrayList<>();
        String orderSQL = "SELECT * FROM orders WHERE User_ID = ?";
        String cartItemSQL = "SELECT * FROM cart_items WHERE Order_ID = ?";

        try (PreparedStatement orderStmt = connection.prepareStatement(orderSQL)) {
            orderStmt.setInt(1, userId);
            try (ResultSet orderRs = orderStmt.executeQuery()) {
                while (orderRs.next()) {
                    int orderId = orderRs.getInt("Order_ID");
                    int totalAmount = orderRs.getInt("total_amount");
                    Timestamp orderDate = orderRs.getTimestamp("order_date");

                    Orders order = new Orders(orderId, userId, totalAmount, orderDate);

                    try (PreparedStatement cartItemStmt = connection.prepareStatement(cartItemSQL)) {
                        cartItemStmt.setInt(1, orderId);
                        try (ResultSet cartItemRs = cartItemStmt.executeQuery()) {
                            List<CartItem> cartItems = new ArrayList<>();
                            while (cartItemRs.next()) {
                                int productId = cartItemRs.getInt("P_ID");
                                int quantity = cartItemRs.getInt("quantity");
                                int totalPrice = cartItemRs.getInt("total_price");

                                Products product = new Products(productId);
                                CartItem cartItem = new CartItem(product, quantity);
                                cartItems.add(cartItem);
                            }
                            order.setCartItems(cartItems);
                        }
                    }
                    orders.add(order);
                }
            }
        }
        return orders;
    }

}
