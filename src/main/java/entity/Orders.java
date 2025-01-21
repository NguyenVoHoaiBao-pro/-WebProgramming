package entity;

import java.util.Date;
import java.util.List;

public class Orders {
    private int orderId;                 // Mã đơn hàng
    private int userId;                  // Mã người dùng
    private List<CartItem> cartItems;    // Danh sách sản phẩm trong giỏ hàng
    private int totalAmount;             // Tổng giá trị đơn hàng
    private Date orderDate;              // Ngày đặt hàng

    // Constructor
    public Orders(int orderId, int userId, List<CartItem> cartItems, Date orderDate) {
        this.orderId = orderId;
        this.userId = userId;
        this.cartItems = cartItems;
        this.orderDate = orderDate;
        this.totalAmount = calculateTotalAmount(); // Tự động tính tổng giá trị
    }

    // Getters và Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<CartItem> cartItems) {
        this.cartItems = cartItems;
        this.totalAmount = calculateTotalAmount(); // Cập nhật tổng giá trị
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    // Tính tổng giá trị đơn hàng
    private int calculateTotalAmount() {
        return cartItems.stream().mapToInt(CartItem::getTotalPrice).sum();
    }

    @Override
    public String toString() {
        return "Orders{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", totalAmount=" + totalAmount +
                ", orderDate=" + orderDate +
                '}';
    }
}
