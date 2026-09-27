<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>IUH Bookstore - Giỏ Hàng Của Bạn</title>
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
        nav a { color: #e2e8f0; text-decoration: none; margin-left: 24px; font-size: 14px; font-weight: 500; }
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
        .cart-badge { background: var(--accent); color: white; padding: 3px 10px; border-radius: 12px; font-size: 12px; }

        main { flex: 1; }
        .cart-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid var(--card-border);
            padding: 30px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.05);
        }
        .cart-header-title {
            font-size: 18px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--primary-dark);
            margin: 0 0 20px 0;
            border-bottom: 2px solid #edf2f7;
            padding-bottom: 12px;
        }

        table { width: 100%; border-collapse: collapse; }
        th {
            background-color: var(--primary);
            color: #fff;
            font-weight: 600;
            padding: 12px 16px;
            text-align: left;
            font-size: 14px;
        }
        th:first-child { border-top-left-radius: 8px; }
        th:last-child { border-top-right-radius: 8px; }
        td {
            padding: 14px 16px;
            border-bottom: 1px solid var(--card-border);
            font-size: 14px;
            vertical-align: middle;
        }
        .center-col { text-align: center; }

        .btn-remove {
            background: none;
            border: none;
            color: #e53e3e;
            font-weight: 600;
            cursor: pointer;
            padding: 4px 8px;
            border-radius: 4px;
            transition: background 0.2s;
        }
        .btn-remove:hover { background: #fee2e2; }

        .total-summary {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-top: 24px;
            font-size: 20px;
            font-weight: 700;
            color: var(--accent);
        }

        .action-bar {
            display: flex;
            justify-content: space-between;
            margin-top: 24px;
        }
        .btn {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            cursor: pointer;
            border: none;
            transition: 0.2s;
        }
        .btn-checkout { background: var(--primary); color: white; }
        .btn-checkout:hover { background: var(--primary-dark); }
        .btn-continue { background: #edf2f7; color: var(--text-main); }
        .btn-continue:hover { background: #e2e8f0; }
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

        <h3>Giỏ Hàng CỦA BẠN</h3>
        <a class="cart-status" href="${pageContext.request.contextPath}/giohang">
            <span>🛒 Xem Giỏ Hàng</span>
            <span class="cart-badge">${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0} món</span>
        </a>
    </aside>

    <main>
        <div class="cart-card">
            <div class="cart-header-title">YOUR SHOPPING CART</div>

            <c:choose>
                <c:when test="${empty cart or empty cart.items}">
                    <p style="text-align: center; color: var(--text-muted); padding: 40px 0;">Giỏ hàng của bạn đang trống.</p>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                        <tr>
                            <th style="width: 15%;">Product ID</th>
                            <th style="width: 45%;">Product name</th>
                            <th style="width: 15%;">Price</th>
                            <th style="width: 10%;" class="center-col">Qty</th>
                            <th style="width: 15%;">Total</th>
                            <th style="width: 10%;" class="center-col">Remove</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${cart.items}" var="item">
                            <tr>
                                <td>pro${item.book.id < 10 ? '0' : ''}${item.book.id}</td>
                                <td><strong>${item.book.title}</strong></td>
                                <td><fmt:formatNumber value="${item.book.price}" type="currency" currencyCode="VND"/></td>
                                <td class="center-col">
                                    <form action="${pageContext.request.contextPath}/giohang" method="post" style="margin: 0; display: inline-flex; align-items: center; gap: 4px;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="${item.book.id}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" style="width: 45px; padding: 4px; text-align: center; border: 1px solid #cbd5e0; border-radius: 4px;">
                                        <button type="submit" style="padding: 4px 6px; font-size: 11px; cursor: pointer; border: 1px solid #cbd5e0; border-radius: 4px; background: #fff;">Lưu</button>
                                    </form>
                                </td>
                                <td><fmt:formatNumber value="${item.total}" type="currency" currencyCode="VND"/></td>
                                <td class="center-col">
                                    <form action="${pageContext.request.contextPath}/giohang" method="post" style="margin: 0;">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="id" value="${item.book.id}">
                                        <button type="submit" class="btn-remove">Remove</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="total-summary">
                        Total price: &nbsp; <fmt:formatNumber value="${cart.totalPrice}" type="currency" currencyCode="VND"/>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="action-bar">
                <a href="${pageContext.request.contextPath}/books" class="btn btn-continue">← Continue shopping</a>
                <a href="${pageContext.request.contextPath}/thanhtoan.jsp" class="btn btn-checkout">Checkout →</a>
            </div>
        </div>
    </main>
</div>

</body>
</html>