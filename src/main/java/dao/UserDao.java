package dao;

import entity.Products;
import entity.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static dao.MySQLConnection.getConnection;

public class UserDao {
    public Users loginUser(String email, String password) {
        return null;
    }


    public Users getUserByUsername(String username) {
        Users user = null;
        String query = "SELECT * FROM User WHERE username = ?";  // Câu lệnh SQL để lấy người dùng theo username

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Thiết lập tham số cho PreparedStatement
            statement.setString(1, username);

            // Thực thi câu lệnh và lấy kết quả
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    user = new Users(
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

        } catch (Exception e) {
            e.printStackTrace();  // In ra lỗi nếu có
        }
        return user;  // Trả về người dùng nếu tìm thấy, nếu không trả về null
    }
    public boolean changePassword(String username, String oldPassword, String newPassword) {
        boolean isUpdated = false;
        String queryCheck = "SELECT password FROM User WHERE username = ?";  // Câu lệnh kiểm tra mật khẩu cũ
        String queryUpdate = "UPDATE User SET password = ? WHERE username = ?";  // Câu lệnh cập nhật mật khẩu mới

        try (Connection connection = getConnection();
             PreparedStatement checkStatement = connection.prepareStatement(queryCheck)) {

            // Thiết lập tham số cho PreparedStatement kiểm tra mật khẩu cũ
            checkStatement.setString(1, username);

            // Thực thi câu lệnh kiểm tra và lấy kết quả
            try (ResultSet rs = checkStatement.executeQuery()) {
                if (rs.next()) {
                    String currentPassword = rs.getString("password");

                    // Kiểm tra mật khẩu cũ có đúng không
                    if (currentPassword.equals(oldPassword)) {
                        // Mật khẩu cũ đúng, cập nhật mật khẩu mới
                        try (PreparedStatement updateStatement = connection.prepareStatement(queryUpdate)) {
                            updateStatement.setString(1, newPassword);
                            updateStatement.setString(2, username);

                            int rowsAffected = updateStatement.executeUpdate();
                            if (rowsAffected > 0) {
                                isUpdated = true;  // Đổi mật khẩu thành công
                            }
                        }
                    } else {
                        System.out.println("Mật khẩu cũ không đúng.");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();  // In ra lỗi nếu có
        }
        return isUpdated;  // Trả về true nếu đổi mật khẩu thành công, ngược lại là false
    }

    public boolean deleteAccount(String username, String password) {
        boolean isDeleted = false;
        String queryCheck = "SELECT password FROM User WHERE username = ?";  // Câu lệnh kiểm tra mật khẩu
        String queryDelete = "DELETE FROM User WHERE username = ?";  // Câu lệnh xóa tài khoản

        try (Connection connection = getConnection();
             PreparedStatement checkStatement = connection.prepareStatement(queryCheck)) {

            // Thiết lập tham số cho PreparedStatement kiểm tra mật khẩu
            checkStatement.setString(1, username);

            // Thực thi câu lệnh kiểm tra và lấy kết quả
            try (ResultSet rs = checkStatement.executeQuery()) {
                if (rs.next()) {
                    String currentPassword = rs.getString("password");

                    // Kiểm tra mật khẩu có đúng không
                    if (currentPassword.equals(password)) {
                        // Mật khẩu đúng, xóa tài khoản
                        try (PreparedStatement deleteStatement = connection.prepareStatement(queryDelete)) {
                            deleteStatement.setString(1, username);

                            int rowsAffected = deleteStatement.executeUpdate();
                            if (rowsAffected > 0) {
                                isDeleted = true;  // Xóa tài khoản thành công
                            } else {
                                System.out.println("Không thể xóa tài khoản, vui lòng thử lại.");
                            }
                        }
                    } else {
                        System.out.println("Mật khẩu không đúng.");
                    }
                } else {
                    System.out.println("Không tìm thấy tài khoản với username: " + username);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi cơ sở dữ liệu: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Lỗi: " + e.getMessage());
            e.printStackTrace();
        }

        return isDeleted;  // Trả về true nếu xóa tài khoản thành công, ngược lại là false
    }


    public boolean checkCurrentPassword(String username, String currentPassword) {
        String sql = "SELECT password FROM User WHERE username = ?"; // Câu lệnh SQL để lấy mật khẩu từ DB
        try (Connection conn = getConnection(); // Mở kết nối tới DB
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username); // Gán giá trị username vào câu truy vấn
            try (ResultSet rs = stmt.executeQuery()) { // Thực thi truy vấn
                if (rs.next()) { // Nếu tồn tại người dùng
                    String storedPassword = rs.getString("password"); // Lấy mật khẩu từ DB
                    return storedPassword.equals(currentPassword); // So sánh mật khẩu từ DB và mật khẩu nhập vào
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log lỗi nếu xảy ra vấn đề với DB
        }
        return false; // Trả về false nếu không tìm thấy hoặc có lỗi xảy ra
    }

    public boolean editUser(Users user) {
        boolean isUpdated = false;
        String query = "UPDATE User SET email = ?, phone = ?, address = ? WHERE username = ?"; // Câu lệnh SQL cập nhật thông tin người dùng

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Thiết lập tham số cho câu lệnh PreparedStatement
            statement.setString(1, user.getEmail());
            statement.setString(2, user.getPhone());
            statement.setString(3, user.getAddress());
            statement.setString(4, user.getUsername());

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true; // Cập nhật thành công
            }

        } catch (Exception e) {
            e.printStackTrace(); // In lỗi nếu có
        }
        return isUpdated; // Trả về true nếu thành công, false nếu không
    }


}
