import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private Connection conn;

    public OrderDAO(Connection conn) {
        this.conn = conn;
    }

    // Thêm đơn hàng mới
    public int addOrder(Order order) throws SQLException {
        String query = "INSERT INTO orders (user_id, order_status, order_date) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getUserId());
            stmt.setString(2, order.getOrderStatus());
            stmt.setTimestamp(3, order.getOrderDate());
            stmt.executeUpdate();

            // Lấy order_id vừa tạo
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);  // Trả về ID của order vừa tạo
            }
            return -1;
        }
    }

    // Thêm sản phẩm vào đơn hàng (order_items)
    public void addOrderItem(OrderItem orderItem) throws SQLException {
        String query = "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, orderItem.getOrder().getOrderId());
            stmt.setInt(2, orderItem.getProduct().getId());
            stmt.setInt(3, orderItem.getQuantity());
            stmt.executeUpdate();
        }
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
}
