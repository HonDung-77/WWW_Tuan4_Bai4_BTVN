<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>IUH Bookstore - Chi Tiết Sách</title>
    <style>
        :root {
            --primary: #2b5c8f;
            --primary-dark: #1b3d61;
            --accent: #e65100;
            --bg-light: #f5f7fa;
            --card-border: #e3e8ee;
            --text-main: #2d3748;
            --text-muted: #718096;
        }

        * { box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        body { background-color: var(--bg-light); margin: 0; padding: 0; color: var(--text-main); }

        header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: #fff;
            padding: 16px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        header h1 { margin: 0; font-size: 24px; font-weight: 700; letter-spacing: 0.5px; }
        nav a { color: #e2e8f0; text-decoration: none; margin-left: 24px; font-size: 14px; font-weight: 500; transition: color 0.2s; }
        nav a:hover { color: #fff; }

        .wrapper {
            width: 95%;
            max-width: 1440px;
            margin: 30px auto;
            display: flex;
            gap: 30px;
        }

        aside {
            width: 280px;
            min-width: 280px;
            background: #fff;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            border: 1px solid var(--card-border);
            height: fit-content;
        }
        aside h3 {
            margin-top: 0;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--primary-dark);
            border-bottom: 2px solid var(--primary);
            padding-bottom: 8px;
        }
        .search-box { display: flex; margin-bottom: 24px; }
        .search-box input {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #cbd5e0;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
        }
        .search-box input:focus { border-color: var(--primary); }

        .cart-status {
            background: #edf2f7;
            padding: 14px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            text-decoration: none;
            color: var(--text-main);
            font-weight: 600;
            font-size: 14px;
        }
        .cart-status:hover { background: #e2e8f0; }
        .cart-badge {
            background: var(--accent);
            color: white;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 12px;
        }

        main { flex: 1; }
        .detail-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid var(--card-border);
            padding: 36px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.05);
            display: flex;
            gap: 40px;
        }
        .img-box {
            width: 280px;
            min-width: 280px;
            height: 380px;
            background: #f8fafc;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            border: 1px solid #edf2f7;
        }
        .img-box img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            border-radius: 4px;
            box-shadow: 0 6px 14px rgba(0,0,0,0.12);
        }
        .info-box { flex: 1; display: flex; flex-direction: column; }
        .book-id { font-size: 13px; color: var(--text-muted); text-transform: uppercase; margin-bottom: 6px; }
        .book-name { font-size: 26px; font-weight: 700; color: var(--primary-dark); margin: 0 0 10px 0; }
        .author { font-size: 16px; color: var(--text-muted); margin-bottom: 20px; }
        .price-tag { font-size: 28px; font-weight: 700; color: var(--accent); margin-bottom: 24px; }

        .btn-add {
            background: var(--primary);
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.2s;
            width: fit-content;
        }
        .btn-add:hover { background: var(--primary-dark); }
        .back-link { display: inline-block; margin-top: 24px; color: var(--primary); text-decoration: none; font-size: 14px; font-weight: 500; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<header>
    <h1>IUH BOOKSTORE</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/books">HOME</a>
        <a href="#">CATEGORIES</a>
        <a href="#">PROMOTIONS</a>
        <a href="${pageContext.request.contextPath}/books">ALL BOOKS</a>
        <a href="#">CONTACT</a>
    </nav>
</header>

<div class="wrapper">
    <aside>
        <h3>Tìm Kiếm Sách</h3>
        <form class="search-box" action="${pageContext.request.contextPath}/books" method="get">
            <input type="text" name="keyword" placeholder="Nhập tên sách, tác giả..."/>
        </form>

        <h3>Giỏ Hàng Của Bạn</h3>
        <a class="cart-status" href="${pageContext.request.contextPath}/giohang">
            <span>🛒 Xem Giỏ Hàng</span>
            <span class="cart-badge">${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0} món</span>
        </a>
    </aside>

    <main>
        <div class="detail-card">
            <c:choose>
                <c:when test="${not empty book}">
                    <div class="img-box">
                        <img src="${pageContext.request.contextPath}/images/${book.imgURL}"
                             alt="${book.title}"
                             onerror="this.onerror=null; this.src='https://placehold.co/220x300/2b5c8f/ffffff?text=${book.id}';">
                    </div>
                    <div class="info-box">
                        <span class="book-id">Mã Sách: #${book.id}</span>
                        <h2 class="book-name">${book.title}</h2>
                        <div class="author"><strong>Tác giả:</strong> ${book.author}</div>
                        <div class="price-tag">
                            <fmt:formatNumber value="${book.price}" type="currency" currencyCode="VND"/>
                        </div>

                        <form action="${pageContext.request.contextPath}/giohang" method="post">
                            <input type="hidden" name="id" value="${book.id}">
                            <input type="hidden" name="action" value="add">
                            <button type="submit" class="btn-add">🛒 Thêm Vào Giỏ Hàng</button>
                        </form>

                        <a class="back-link" href="${pageContext.request.contextPath}/books">← Quay lại danh sách sách</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <p style="color: #e53e3e;">Không tìm thấy thông tin sách!</p>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

</body>
</html>