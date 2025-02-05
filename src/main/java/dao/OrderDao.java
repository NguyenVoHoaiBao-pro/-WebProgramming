package dao;

import entity.Orders;
import entity.CartItem;
import com.google.gson.Gson;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class OrderDao {
    private static final String INSERT_ORDER_SQL = "INSERT INTO orders (User_ID, total_amount, order_date) VALUES (?, ?, ?)";
    private static final String INSERT_CART_ITEM_SQL = "INSERT INTO cart_items (Order_ID, P_ID, quantity, total_price) VALUES (?, ?, ?, ?)";

    // Method to save an order and its cart items into the database
    public boolean saveOrder(Orders order) {
        try (Connection connection = MySQLConnection.getConnection()) {
            // Begin transaction
            connection.setAutoCommit(false);

            // Save order
            try (PreparedStatement orderStatement = connection.prepareStatement(INSERT_ORDER_SQL)) {
                orderStatement.setInt(1, order.getUserId());
                orderStatement.setInt(2, order.getTotalAmount());
                orderStatement.setTimestamp(3, new java.sql.Timestamp(order.getOrderDate().getTime()));
                orderStatement.executeUpdate();
            }

            // Save cart items
            for (CartItem item : order.getCartItems()) {
                try (PreparedStatement cartItemStatement = connection.prepareStatement(INSERT_CART_ITEM_SQL)) {
                    cartItemStatement.setInt(1, order.getOrderId()); // Assuming orderId is auto-generated and assigned
                    cartItemStatement.setInt(2, item.getProduct().getId());
                    cartItemStatement.setInt(3, item.getQuantity());
                    cartItemStatement.setInt(4, item.getTotalPrice());
                    cartItemStatement.executeUpdate();
                }
            }

            // Commit transaction
            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
