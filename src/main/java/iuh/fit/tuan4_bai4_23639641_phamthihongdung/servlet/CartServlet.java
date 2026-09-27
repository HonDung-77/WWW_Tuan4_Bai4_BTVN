package iuh.fit.tuan4_bai4_23639641_phamthihongdung.servlet;

import iuh.fit.tuan4_bai4_23639641_phamthihongdung.beans.Book;
import iuh.fit.tuan4_bai4_23639641_phamthihongdung.beans.CartBean;
import iuh.fit.tuan4_bai4_23639641_phamthihongdung.dao.BookDAO;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import javax.sql.DataSource;
import java.io.IOException;

@WebServlet("/giohang")
public class CartServlet extends HttpServlet {
    @Resource(name = "jdbc/bookstoredb")
    private DataSource dataSource;
    private BookDAO bookDAO;

    @Override
    public void init() {
        bookDAO = new BookDAO(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/giohang.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartBean cart = (CartBean) session.getAttribute("cart");
        if (cart == null) {
            cart = new CartBean();
            session.setAttribute("cart", cart);
        }

        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if ("add".equals(action)) {
            Book b = bookDAO.getBookById(id);
            if (b != null) cart.addBook(b);
        } else if ("remove".equals(action)) {
            cart.removeBook(id);
        }

        resp.sendRedirect(req.getContextPath() + "/giohang");
    }
}
