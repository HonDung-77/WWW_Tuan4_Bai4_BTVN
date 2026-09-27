package iuh.fit.tuan4_bai4_23639641_phamthihongdung.beans;

import java.io.Serializable;

public class Book implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String title;
    private String author;
    private double price;
    private String imgURL;

    public Book() {}

    public Book(String id, String title, String author, double price, String imgURL) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.price = price;
        this.imgURL = imgURL;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImgURL() { return imgURL; }
    public void setImgURL(String imgURL) { this.imgURL = imgURL; }
}