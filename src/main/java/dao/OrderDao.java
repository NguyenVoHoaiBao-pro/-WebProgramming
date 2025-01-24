package dao;

import entity.CartItem;
import entity.Orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
