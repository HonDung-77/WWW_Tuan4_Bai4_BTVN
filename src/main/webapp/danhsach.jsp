<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>IUH Bookstore - Thiên Đường Sách</title>
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

        * { box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; }
        body { background-color: var(--bg-light); margin: 0; padding: 0; color: var(--text-main); }

        /* Top Header */
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

        nav a {
            color: #e2e8f0;
            text-decoration: none;
            margin-left: 24px;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.2s;
        }
        nav a:hover { color: #fff; }

        /* Main Container */
        .wrapper {
            max-width: 1240px;
            margin: 30px auto;
            padding: 0 20px;
            display: flex;
            gap: 30px;
        }

        /* Sidebar */
        aside {
            width: 280px;
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
        .search-box {
            display: flex;
            margin-bottom: 24px;
        }
        .search-box input {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #cbd5e0;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
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
            transition: background 0.2s;
        }
        .cart-status:hover { background: #e2e8f0; }
        .cart-badge {
            background: var(--accent);
            color: white;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 12px;
        }

        /* Books Grid */
        main { flex: 1; }
        .grid-books {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(210px, 1fr));
            gap: 24px;
        }
        .book-card {
            background: #fff;
            border: 1px solid var(--card-border);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0,0,0,0.04);
            display: flex;
            flex-direction: column;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .book-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
        }
        .img-container {
            width: 100%;
            height: 220px;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 16px;
        }
        .img-container img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
            border-radius: 4px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.12);
        }
        .book-details {
            padding: 16px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .book-title {
            font-weight: 600;
            font-size: 14px;
            line-height: 1.4;
            height: 40px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            margin-bottom: 6px;
        }
        .book-author {
            font-size: 12px;
            color: var(--text-muted);
            margin-bottom: 10px;
        }
        .book-price {
            font-size: 16px;
            font-weight: 700;
            color: var(--accent);
            margin-top: auto;
            margin-bottom: 12px;
        }
        .btn-cart {
            width: 100%;
            background: var(--primary);
            color: white;
            border: none;
            padding: 9px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-cart:hover { background: var(--primary-dark); }
        .detail-link {
            text-align: center;
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 8px;
            text-decoration: none;
        }
        .detail-link:hover { text-decoration: underline; color: var(--primary); }
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
            <input type="text" name="keyword" value="${param.keyword}" placeholder="Nhập tên sách, tác giả..."/>
        </form>

        <h3>Giỏ Hàng Của Bạn</h3>
        <a class="cart-status" href="${pageContext.request.contextPath}/giohang">
            <span>🛒 Xem Giỏ Hàng</span>
            <span class="cart-badge">${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0} món</span>
        </a>
    </aside>

    <main>
        <c:choose>
            <c:when test="${empty books}">
                <div style="background: white; padding: 40px; text-align: center; border-radius: 12px; border: 1px solid var(--card-border);">
                    <p style="color: var(--text-muted); font-size: 16px;">Không tìm thấy quyển sách nào!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid-books">
                    <c:forEach items="${books}" var="b">
                        <div class="book-card">
                            <div class="img-container">
                                <img src="${pageContext.request.contextPath}/images/${b.imgURL}"
                                     alt="${b.title}"
                                     onerror="this.onerror=null; this.src='https://placehold.co/150x210/2b5c8f/ffffff?text=${b.id}';">
                            </div>
                            <div class="book-details">
                                <div class="book-title" title="${b.title}">${b.title}</div>
                                <div class="book-author">${b.author}</div>
                                <div class="book-price">
                                    <fmt:formatNumber value="${b.price}" type="currency" currencyCode="VND"/>
                                </div>
                                <form action="${pageContext.request.contextPath}/giohang" method="post" style="margin: 0;">
                                    <input type="hidden" name="id" value="${b.id}">
                                    <input type="hidden" name="action" value="add">
                                    <button type="submit" class="btn-cart">Thêm Vào Giỏ</button>
                                </form>
                                <a class="detail-link" href="${pageContext.request.contextPath}/chitietsach?id=${b.id}">Xem chi tiết</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</div>

</body>
</html>