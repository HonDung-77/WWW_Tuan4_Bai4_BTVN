package iuh.fit.tuan4_bai4_23639641_phamthihongdung.beans;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class CartBean implements Serializable {
    private List<CartItem> items = new ArrayList<>();

    public List<CartItem> getItems() { return items; }

    public void addBook(Book b) {
        for (CartItem item : items) {
            if (item.getBook().getId().equals(b.getId())) {
                item.setQuantity(item.getQuantity() + 1);
                return;
            }
        }
        items.add(new CartItem(b, 1));
    }

    public void removeBook(String id) {
        items.removeIf(item -> item.getBook().getId().equals(id));
    }

    public int getTotalQuantity() {
        return items.stream().mapToInt(CartItem::getQuantity).sum();
    }

    public double getTotalPrice() {
        return items.stream().mapToDouble(CartItem::getTotal).sum();
    }
}