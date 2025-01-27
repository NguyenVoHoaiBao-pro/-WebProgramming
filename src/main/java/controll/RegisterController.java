package controll;

import dao.dao;
import entity.Users;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/register") // Đường dẫn để gọi servlet
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(RegisterController.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form đăng ký
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Kiểm tra nếu có tham số nào rỗng hoặc null
        if (isEmpty(username) || isEmpty(email) || isEmpty(password) || isEmpty(confirmPassword) || isEmpty(phone) || isEmpty(address)) {
            request.setAttribute("error", "All fields are required.");
            forwardToRegisterPage(request, response);
            return;
        }

        // Kiểm tra nếu mật khẩu và xác nhận mật khẩu không khớp
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            forwardToRegisterPage(request, response);
            return;
        }

        dao d = new dao();
        Users existingUser = d.checkExist(username);

        // Kiểm tra nếu tài khoản đã tồn tại
        if (existingUser != null) {
            request.setAttribute("error", "Username already exists.");
            forwardToRegisterPage(request, response);
        } else {
            try {
                // Mã hóa mật khẩu (thay thế với mã hóa mật khẩu thực tế như BCrypt)
                String hashedPassword = hashPassword(password);

                // Đăng ký người dùng mới
                d.Register(username, email, hashedPassword, phone, address);
                request.setAttribute("success", "Registration successful!");
                response.sendRedirect("doanweb/html/index.jsp"); // Chuyển hướng đến trang chính sau khi đăng ký
            } catch (Exception e) {
                // Ghi log ngoại lệ và thông báo lỗi cho người dùng
                LOGGER.log(Level.SEVERE, "Error during registration", e);
                request.setAttribute("error", "An error occurred during registration. Please try again.");
                forwardToRegisterPage(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển hướng về trang đăng ký nếu truy cập GET
        forwardToRegisterPage(request, response);
    }

    private void forwardToRegisterPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/doanweb/html/Register.jsp");
        dispatcher.forward(request, response);
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String hashPassword(String password) {
        // Thay thế bằng mã hóa mật khẩu thực tế như BCrypt
        // Ví dụ: return BCrypt.hashpw(password, BCrypt.gensalt());
        return password; // Đoạn này chỉ để minh họa, cần thay thế bằng mã hóa thực tế
    }
}
