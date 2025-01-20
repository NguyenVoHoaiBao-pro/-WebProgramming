package controll;

import dao.UserDao;
import entity.Users;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao dao;

    @Override
    public void init() {
        dao = new UserDao(); // Khởi tạo đối tượng DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users loggedInUser = getLoggedInUser(request);

        if (loggedInUser == null) {
            response.sendRedirect("/login");
            return;
        }

        // Lấy action từ request (nếu có)
        String action = request.getParameter("action");
        request.setAttribute("action", action); // Truyền action sang JSP

        // Lấy thông tin người dùng để hiển thị
        Users user = dao.getUserByUsername(loggedInUser.getUsername());
        request.setAttribute("user", user);

        // Chuyển đến profile.jsp
        forwardToPage(request, response, "doanweb/html/profile.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users loggedInUser = getLoggedInUser(request);

        if (loggedInUser == null) {
            response.sendRedirect("/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("/profile");
            return;
        }

        switch (action) {
            case "changeInfo":
                handleEditProfile(request, response, loggedInUser);
                break;

            case "change-pass":
                handleChangePassword(request, response, loggedInUser);
                break;

            case "deleteAccount":
                handleDeleteAccount(request, response, loggedInUser);
                break;

            default:
                response.sendRedirect("/profile");
        }
    }

    private Users getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false); // Không tạo session mới nếu chưa tồn tại
        if (session != null) {
            return (Users) session.getAttribute("user");
        }
        return null;
    }

    private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    private void handleEditProfile(HttpServletRequest request, HttpServletResponse response, Users loggedInUser)
            throws IOException, ServletException {
        // Lấy các tham số từ request
        String newEmail = request.getParameter("newEmail");
        String newPhone = request.getParameter("newPhone");
        String newAddress = request.getParameter("newAddress");

        // Kiểm tra tính hợp lệ của các tham số nhập vào
        if (newEmail == null || newEmail.isEmpty() || !newEmail.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.setAttribute("errorMessage", "Email không hợp lệ.");
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }

        if (newPhone == null || newPhone.isEmpty() || !newPhone.matches("^\\d{10,15}$")) {
            request.setAttribute("errorMessage", "Số điện thoại không hợp lệ.");
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }

        // Cập nhật thông tin người dùng
        loggedInUser.setEmail(newEmail);
        loggedInUser.setPhone(newPhone);
        loggedInUser.setAddress(newAddress);

        // Gọi phương thức dao để cập nhật thông tin người dùng
        boolean isUpdated = dao.editUser(loggedInUser);

        if (isUpdated) {
            // Cập nhật session và gửi thông báo thành công
            request.getSession().setAttribute("user", loggedInUser);
            request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
        } else {
            // Gửi thông báo lỗi nếu cập nhật không thành công
            request.setAttribute("errorMessage", "Cập nhật thông tin thất bại. Vui lòng thử lại!");
        }

        // Chuyển hướng về trang thông tin người dùng
        response.sendRedirect("/profile?action=changeInfo");
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, Users loggedInUser)
            throws IOException, ServletException {
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        boolean isPasswordChanged = dao.changePassword(loggedInUser.getUsername(), oldPassword, newPassword);

        if (isPasswordChanged) {
            request.setAttribute("successMessage", "Mật khẩu đã được thay đổi thành công!");
        } else {
            request.setAttribute("errorMessage", "Mật khẩu cũ không đúng hoặc có lỗi xảy ra!");
        }

        response.sendRedirect("/profile?action=change-pass");
    }

    private void handleDeleteAccount(HttpServletRequest request, HttpServletResponse response, Users loggedInUser)
            throws IOException, ServletException {
        String password = request.getParameter("confirmDelete");

        boolean isAccountDeleted = dao.deleteAccount(loggedInUser.getUsername(), password);

        if (isAccountDeleted) {
            request.getSession().invalidate();
            response.sendRedirect("/login");
        } else {
            request.setAttribute("errorMessage", "Mật khẩu không đúng hoặc có lỗi xảy ra!");
            response.sendRedirect("/profile?action=deleteAccount");
        }
    }
}
