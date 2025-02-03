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
    // Cập nhật trạng thái đơn hàng
    public void updateOrderStatus(int orderId, String status) throws SQLException {
        String query = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        }
    }

    // Lấy tất cả đơn hàng với trạng thái 'Pending'
    public List<Order> getPendingOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE order_status = 'Pending'";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                String orderStatus = rs.getString("order_status");
                Timestamp orderDate = rs.getTimestamp("order_date");
                // Tạo danh sách orderItems cho đơn hàng
                List<OrderItem> orderItems = getOrderItems(orderId);
                Order order = new Order(orderId, userId, orderStatus, orderDate, orderItems);
                orders.add(order);
            }
        }
        return orders;
    }

    // Lấy các sản phẩm trong đơn hàng (order_items)
    private List<OrderItem> getOrderItems(int orderId) throws SQLException {
        List<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT * FROM order_items WHERE order_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                // Giả sử đã có ProductDAO để lấy thông tin sản phẩm
                Product product = new ProductDAO(conn).getProductById(productId);
                orderItems.add(new OrderItem(0, null, product, quantity));  // orderItemId = 0 vì chưa có trong db
            }
        }
        return orderItems;
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
