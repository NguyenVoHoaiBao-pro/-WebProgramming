package controll;

import entity.CartItem;
import dao.dao;
import entity.Products;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/add-to-cart") // Đường dẫn để gọi servlet
public class AddToCartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private dao dao = new dao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy ID sản phẩm từ tham số truy vấn
        String productId = request.getParameter("id");
        String action = request.getParameter("action"); // Lấy hành động (buy-now, thêm vào giỏ hàng, hoặc remove)

        // Kiểm tra nếu ID sản phẩm không hợp lệ
        if (productId == null || productId.isEmpty()) {
            response.sendRedirect("error.jsp"); // Chuyển hướng đến trang lỗi nếu không có ID
            return;
        }

        // Lấy sản phẩm từ cơ sở dữ liệu
        Products product = dao.getProductById(Integer.parseInt(productId));

        // Nếu sản phẩm không tồn tại, chuyển hướng đến trang lỗi
        if (product == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Lấy giỏ hàng từ session (nếu có)
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        // Nếu giỏ hàng chưa được tạo, khởi tạo giỏ hàng mới
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Xử lý hành động xóa sản phẩm khỏi giỏ hàng
        if ("remove".equals(action)) {
            if (cart != null) {
                cart.removeIf(cartItem -> cartItem.getProduct().getId() == Integer.parseInt(productId));
            }
        } else {
            // Kiểm tra sản phẩm đã có trong giỏ hàng chưa
            boolean productFound = false;
            for (CartItem cartItem : cart) {
                if (cartItem.getProduct().getId() == product.getId()) {
                    // Nếu sản phẩm đã có trong giỏ hàng, tăng số lượng lên
                    cartItem.setQuantity(cartItem.getQuantity() + 1);
                    productFound = true;
                    break;
                }
            }

            // Nếu sản phẩm chưa có trong giỏ, thêm vào giỏ hàng
            if (!productFound) {
                cart.add(new CartItem(product, 1)); // Mặc định thêm 1 sản phẩm vào giỏ
            }
        }

        // Cập nhật tổng số lượng sản phẩm trong giỏ hàng
        int totalItems = 0;
        for (CartItem cartItem : cart) {
            totalItems += cartItem.getQuantity(); // Tính tổng số lượng sản phẩm trong giỏ
        }
        session.setAttribute("totalItems", totalItems); // Lưu số lượng vào session

        // Tính tổng giá tiền của tất cả sản phẩm trong giỏ hàng
        double totalPrice = dao.getTotalCartPrice((ArrayList<CartItem>) cart);
        session.setAttribute("totalPrice", totalPrice);

        // Kiểm tra hành động "Mua ngay" , "Xóa sản phẩm", "Thêm sản phẩm ở shop"
        if ("buy-now".equals(action) || "remove".equals(action)) {
            // Chuyển hướng đến trang giỏ hàng sau khi thêm sản phẩm
            response.sendRedirect("/cart");
        }else if ("add-cart".equals(action) ) {
            // THêm sản phẩm vào giỏ không chuyển trang
            response.sendRedirect("/shop");
        } else {
            // Thông báo khi thêm sản phẩm thành công
            request.setAttribute("message", "Sản phẩm đã được thêm vào giỏ hàng!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/detail");
            dispatcher.forward(request, response);
        }
    }

    // Xử lý yêu cầu POST (dùng chung với doGet)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}