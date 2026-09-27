package iuh.fit.tuan4_bai4_23639641_phamthihongdung.servlet;

import iuh.fit.tuan4_bai4_23639641_phamthihongdung.beans.Book;
import iuh.fit.tuan4_bai4_23639641_phamthihongdung.dao.BookDAO;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

@WebServlet({"/books", "/chitietsach"})
public class BookServlet extends HttpServlet {
    @Resource(name = "jdbc/bookstoredb")
    private DataSource dataSource;
    private BookDAO bookDAO;

    @Override
    public void init() {
        bookDAO = new BookDAO(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();

        if ("/chitietsach".equals(servletPath)) {
            String id = req.getParameter("id");
            if (id != null) {
                Book book = bookDAO.getBookById(id);
                req.setAttribute("book", book);
            }
            req.getRequestDispatcher("/chitietsach.jsp").forward(req, resp);
            return;
        }

        String search = req.getParameter("keyword");
        List<Book> list = bookDAO.getAllBooks(search);
        req.setAttribute("books", list);
        req.getRequestDispatcher("/danhsach.jsp").forward(req, resp);
    }
}