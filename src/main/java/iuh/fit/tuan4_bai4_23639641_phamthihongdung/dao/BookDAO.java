package iuh.fit.tuan4_bai4_23639641_phamthihongdung.dao;

import iuh.fit.tuan4_bai4_23639641_phamthihongdung.beans.Book;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    private DataSource dataSource;

    public BookDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public List<Book> getAllBooks(String keyword) {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT id, tittle, author, price, imgbook FROM books";
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " WHERE tittle LIKE ? OR author LIKE ?";
        }

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword.trim() + "%";
                ps.setString(1, searchPattern);
                ps.setString(2, searchPattern);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Book b = new Book();
                    b.setId(String.valueOf(rs.getInt("id")));
                    b.setTitle(rs.getString("tittle"));
                    b.setAuthor(rs.getString("author"));
                    b.setPrice(rs.getDouble("price"));
                    b.setImgURL(rs.getString("imgbook"));
                    list.add(b);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Book getBookById(String id) {
        String sql = "SELECT id, tittle, author, price, imgbook FROM books WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Book b = new Book();
                    b.setId(String.valueOf(rs.getInt("id")));
                    b.setTitle(rs.getString("tittle"));
                    b.setAuthor(rs.getString("author"));
                    b.setPrice(rs.getDouble("price"));
                    b.setImgURL(rs.getString("imgbook"));
                    return b;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}