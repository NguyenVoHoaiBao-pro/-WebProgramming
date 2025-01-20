package controll;
import entity.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.dao ;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/PlaceOrder")
public class PlaceOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin người dùng từ session
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        // Lấy thông tin giỏ hàng từ session
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");

        // Tính tổng giá trị giỏ hàng
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            totalAmount = totalAmount.add(BigDecimal.valueOf(item.getTotalPrice()));
        }

        // Tạo đối tượng Order và lưu thông tin đơn hàng
        Orders order = new Orders();
        order.setUserId(user.getId());
        order.setTotalAmount(totalAmount);
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));

        // Lưu đơn hàng vào database (tùy vào cách bạn lưu trữ dữ liệu)
        // Ví dụ: orderDao.save(order);

        // Gửi thông tin đơn hàng sang trang admin.jsp
        request.setAttribute("order", order);
        request.setAttribute("user", user);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);

        // Chuyển hướng tới trang admin.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("doanweb/html/ad.jsp");
        dispatcher.forward(request, response);
    }
}

