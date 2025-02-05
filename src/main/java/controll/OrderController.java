package controll;

import com.google.gson.Gson;
import dao.OrderDao;
import entity.Orders;
import entity.Users;
import entity.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/processOrder") // Định tuyến servlet đến đường dẫn /processOrder
public class OrderController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
        Users user = (Users) session.getAttribute("user");

        if (cartItems == null || user == null) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"error\": \"Giỏ hàng hoặc thông tin người dùng không hợp lệ\"}");
            return;
        }

        // Tạo đơn hàng
        Orders order = new Orders(0, user.getId(), cartItems, new java.util.Date());

        // Lưu đơn hàng vào DB
        OrderDao orderDao = new OrderDao();
        boolean isOrderSaved = orderDao.saveOrder(order);

        // Phản hồi về client
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (isOrderSaved) {
            Gson gson = new Gson();
            String orderJson = gson.toJson(order);
            String userJson = gson.toJson(user);
            response.getWriter().write("{\"order\": " + orderJson + ", \"user\": " + userJson + "}");
        } else {
            response.getWriter().write("{\"error\": \"Không thể lưu đơn hàng\"}");
        }
    }
}
