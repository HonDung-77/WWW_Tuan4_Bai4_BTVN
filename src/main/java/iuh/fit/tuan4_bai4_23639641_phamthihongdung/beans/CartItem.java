package iuh.fit.tuan4_bai4_23639641_phamthihongdung.beans;

import java.io.Serializable;

public class CartItem implements Serializable {
    private Book book;
    private int quantity;

    public CartItem(Book book, int quantity) {
        this.book = book;
        this.quantity = quantity;
    }

    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getTotal() { return book.getPrice() * quantity; }
}