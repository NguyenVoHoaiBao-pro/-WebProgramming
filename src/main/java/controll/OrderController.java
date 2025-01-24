package controll;

import com.google.gson.Gson;
import dao.OrderDao;
import entity.CartItem;
import entity.Orders;
import entity.Users;
import entity.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.dao ;
import entity.Products;
import entity.Categories;
import java.sql.Connection;
import dao.MySQLConnection;
import java.io.IOException;
import java.util.ArrayList;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/process-order")
public class OrderController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy user từ session
        Users user = (Users) req.getSession().getAttribute("user");
        if (user == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.getWriter().write("User not logged in");
            return;
        }

        // Lấy cart từ session
        List<CartItem> cart = (List<CartItem>) req.getSession().getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("Cart is empty");
            return;
        }

        // Tạo đơn hàng
        Orders order = new Orders(0, user.getId(), cart, new Date());
        try (var connection = MySQLConnection.getConnection()) {
            OrderDao orderDao = new OrderDao(connection);
            boolean isSaved = orderDao.saveOrder(order);

            if (isSaved) {
                // Chuyển đơn hàng sang JSON để gửi đến admin
                String orderJson = new Gson().toJson(order);
                resp.setContentType("application/json");
                resp.getWriter().write(orderJson);
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("Failed to save order");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Error processing order: " + e.getMessage());
        }
    }
}
