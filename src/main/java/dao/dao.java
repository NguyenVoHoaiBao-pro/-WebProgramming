package dao;

import entity.CartItem;
import entity.Categories;
import entity.Products;
import entity.Users;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import static dao.MySQLConnection.getConnection;

public class dao {
    // Phương thức lấy danh sách tất cả sản phẩm
    public List<Products> getAllProducts() {
        List<Products> l = new ArrayList<>();
        String query = "SELECT * FROM Product";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                Products product = new Products(
                        rs.getInt("p_id"), // Sử dụng 'p_id' thay vì 'id'
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getInt("category_id"),
                        rs.getString("img")
                );
                l.add(product);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return l;
    }

    public List<Categories> getAllCategories() {
        List<Categories> l = new ArrayList<>();
        String query = "SELECT * FROM category";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                Categories product = new Categories(
                        rs.getInt("c_id"),
                        rs.getString("name")
                );
                l.add(product);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return l;
    }

    public static Products getLatestProduct() {
        String query = "SELECT * FROM Product ORDER BY p_id DESC LIMIT 1";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            if (rs.next()) {
                return new Products(
                        rs.getInt("p_id"), // Sử dụng 'p_id' thay vì 'id'
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getInt("category_id"),
                        rs.getString("img")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public List<Products> getProductsByCategory(int category_id) {
        List<Products> l = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE category_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            // Gán giá trị của category_id vào câu truy vấn tại vị trí tham số ?
            statement.setInt(1, category_id);
            // Thực thi câu truy vấn
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Products product = new Products(
                        rs.getInt("p_id"), // Sử dụng 'p_id' thay vì 'id'
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getInt("category_id"),
                        rs.getString("img")
                );
                l.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return l;
    }

    public Products getProductById(int productId) {
        Products product = null;
        String query = "SELECT * FROM Product WHERE p_id = ?";  // Câu lệnh SQL để lấy sản phẩm theo ID

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Thiết lập tham số cho PreparedStatement
            statement.setInt(1, productId);

            // Thực thi câu lệnh và lấy kết quả
            try (ResultSet rs = statement.executeQuery()) {
                // Nếu có sản phẩm với ID tương ứng
                if (rs.next()) {
                    product = new Products(
                            rs.getInt("p_id"), // Sử dụng 'p_id' thay vì 'id'
                            rs.getString("name"),
                            rs.getInt("price"),
                            rs.getInt("stock"),
                            rs.getString("description"),
                            rs.getInt("category_id"),
                            rs.getString("img")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();  // In ra lỗi nếu có
        }
        return product;  // Trả về sản phẩm nếu tìm thấy, nếu không trả về null
    }

    public Products getProductByName(String productName) {
        Products product = null;
        String query = "SELECT * FROM Product WHERE name like ?";  // Câu lệnh SQL để lấy sản phẩm theo ID

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Thiết lập tham số cho PreparedStatement
            statement.setString(1, "%" + productName + "%");

            // Thực thi câu lệnh và lấy kết quả
            try (ResultSet rs = statement.executeQuery()) {
                // Nếu có sản phẩm với ID tương ứng
                if (rs.next()) {
                    product = new Products(
                            rs.getInt("p_id"), // Sử dụng 'p_id' thay vì 'id'
                            rs.getString("name"),
                            rs.getInt("price"),
                            rs.getInt("stock"),
                            rs.getString("description"),
                            rs.getInt("category_id"),
                            rs.getString("img")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();  // In ra lỗi nếu có
        }
        return product;  // Trả về sản phẩm nếu tìm thấy, nếu không trả về null
    }

    /// ///////////////////
    public void addProduct(String name, double price, int stock, String description, int category_id, String image) {
        String sql = "INSERT INTO Product (name, price, stock, description, category_id, image) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setDouble(2, price);
            stmt.setInt(3, stock);
            stmt.setString(4, description);
            stmt.setInt(5, category_id);
            stmt.setString(6, image);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addCategories(String name) {
        String sql = "INSERT INTO category (name) VALUES (?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Sửa sản phẩm
    public void updateProduct(int id, String name, int price, int stock, String description, int category_id, String image) {
        String sql = "UPDATE Product SET name=?, description=?, price=?, stock=?, image=?, category_id=? WHERE p_id=?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setDouble(2, price);
            stmt.setInt(3, stock);
            stmt.setString(4, description);
            stmt.setInt(5, category_id);
            stmt.setString(6, image);
            stmt.setInt(7, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa sản phẩm
    public void deleteProduct(int id) {
        String sql = "DELETE FROM Product WHERE p_id=?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCategory(int id) {
        String sql = "DELETE FROM category  WHERE c_id=?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật số lượng tồn kho
    public int updateStock(int productId, int stock) {
        String query = "UPDATE Product SET stock = ? WHERE p_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, stock);
            statement.setInt(2, productId);
            return statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    //Tổng giá tiền của giỏ hàng
    public double getTotalCartPrice(ArrayList<CartItem> cartList) {
        double sum = 0;

        // Kiểm tra nếu giỏ hàng không rỗng
        if (cartList != null && !cartList.isEmpty()) {
            for (CartItem cartItem : cartList) {
                // Truy vấn giá của sản phẩm từ cơ sở dữ liệu theo ID
                String query = "SELECT price FROM product WHERE p_id = ?";

                try (Connection connection = getConnection();
                     PreparedStatement statement = connection.prepareStatement(query)) {

                    // Thiết lập tham số cho câu lệnh SQL (ID sản phẩm)
                    statement.setInt(1, cartItem.getProduct().getId());

                    try (ResultSet rs = statement.executeQuery()) {
                        // Nếu có sản phẩm, lấy giá và tính tổng
                        if (rs.next()) {
                            double price = rs.getDouble("price");
                            // Cộng giá trị của sản phẩm vào tổng giỏ hàng (có nhân với số lượng)
                            sum += price * cartItem.getQuantity();
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();  // In lỗi nếu có sự cố
                }
            }
        }

        return sum;  // Trả về tổng giá trị giỏ hàng
    }

    public Users login(String username, String password) {
        String query = "SELECT * FROM User WHERE username = ? AND password = ?";
        try (Connection connection = MySQLConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, password);

            // Kiểm tra kết quả truy vấn
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    // Lấy thông tin người dùng từ kết quả truy vấn
                    Users user = new Users(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("phone"),
                            rs.getString("role"),
                            rs.getString("address")
                            );
                    // Hiển thị thông tin người dùng ra console (debug)
                    System.out.println("Đăng nhập thành công! Người dùng: " + user);
                    return user;
                } else {
                    System.out.println("Không tìm thấy người dùng.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

    public Users checkExist(String username) {
        String query = "SELECT * FROM User WHERE username = ?";
        try (Connection connection = MySQLConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, username);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    // Trả về đối tượng người dùng nếu tìm thấy
                    Users user = new Users(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("phone"),
                            rs.getString("role"),
                            rs.getString("address")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            e.printStackTrace(); // In lỗi chi tiết ra để dễ dàng debug
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace(); // In lỗi nếu có lỗi không phải từ database
        }
        return null; // Trả về null nếu không tìm thấy người dùng
    }

    public void Register(String username, String email, String password, String phone, String address) {
        String query = "INSERT INTO User (username, email, password, role, phone, address) VALUES (?, ?, ?, 0, ?, ?)";
        try (Connection connection = MySQLConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Thiết lập các tham số theo thứ tự đúng
            statement.setString(1, username);
            statement.setString(2, email);
            statement.setString(3, password);
            statement.setString(4, phone);
            statement.setString(5, address);

            // Thực thi câu lệnh và kiểm tra kết quả
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("User registered successfully.");
            } else {
                System.out.println("Failed to register user.");
            }
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            e.printStackTrace(); // In lỗi chi tiết ra để dễ dàng debug
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace(); // In lỗi nếu có lỗi không phải từ database
        }
    }


    public List<Products> getRandomProducts() {
        List<Products> products = new ArrayList<>();
        String query = "SELECT * FROM Product ORDER BY RAND() LIMIT 4"; // Lấy 4 sản phẩm ngẫu nhiên

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            // Duyệt qua kết quả trả về và tạo đối tượng Products
            while (rs.next()) {
                Products product = new Products(
                        rs.getInt("p_id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getInt("category_id"),
                        rs.getString("img")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public static void main(String[] args) {
        dao d = new dao();
        List<Products> l = d.getAllProducts();
        List<Categories> l1 = d.getAllCategories();
        Products latestProduct = dao.getLatestProduct();
        // Kiểm tra kết quả
        if (latestProduct != null) {
            System.out.println("Sản phẩm mới nhất:");
            System.out.println("ID: " + latestProduct.getId());
            System.out.println("Tên: " + latestProduct.getName());
            System.out.println("Mô tả: " + latestProduct.getDescription());
            System.out.println("Giá: " + latestProduct.getPrice());
            System.out.println("Số lượng: " + latestProduct.getStock());
            System.out.println("Hình ảnh: " + latestProduct.getImage());
            System.out.println("ID Danh mục: " + latestProduct.getCategoryId());
        } else {
            System.out.println("Không có sản phẩm nào trong cơ sở dữ liệu.");
        }
        for (Products p : l) {
            System.out.println(p);
        }
        for (Categories c : l1) {
            System.out.println(c);
        }
    }
}
