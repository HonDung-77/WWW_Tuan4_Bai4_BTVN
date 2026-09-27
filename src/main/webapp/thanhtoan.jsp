<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>IUH Bookstore - Thanh Toán Đơn Hàng</title>
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
        header h1 { margin: 0; font-size: 24px; font-weight: 700; }
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
        .checkout-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid var(--card-border);
            padding: 30px 40px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.05);
        }
        .checkout-title {
            font-size: 18px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--primary-dark);
            margin: 0 0 24px 0;
            border-bottom: 2px solid #edf2f7;
            padding-bottom: 12px;
        }

        .checkout-table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid var(--card-border);
            border-radius: 8px;
            overflow: hidden;
        }
        .checkout-table td {
            border: 1px solid var(--card-border);
            padding: 14px 20px;
            vertical-align: middle;
            font-size: 14px;
        }
        .checkout-table td.label-col {
            width: 25%;
            font-weight: 600;
            background-color: #f8fafc;
            color: var(--text-main);
        }

        .input-text {
            width: 100%;
            max-width: 400px;
            padding: 10px 12px;
            border: 1px solid #cbd5e0;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }
        .input-text:focus { border-color: var(--primary); }
        .input-readonly {
            background-color: #edf2f7;
            font-weight: 700;
            color: var(--accent);
            border: 1px solid #e2e8f0;
        }

        .radio-group label {
            margin-right: 20px;
            cursor: pointer;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .form-actions {
            margin-top: 30px;
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }
        .btn-save {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 10px 24px;
            font-size: 14px;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-save:hover { background-color: var(--primary-dark); }
        .btn-cancel {
            background-color: #edf2f7;
            color: var(--text-main);
            border: none;
            padding: 10px 24px;
            font-size: 14px;
            font-weight: 600;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
            transition: background 0.2s;
        }
        .btn-cancel:hover { background-color: #e2e8f0; }
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
        <div class="checkout-card">
            <div class="checkout-title">Checkout - Already registered? ...</div>

            <form action="${pageContext.request.contextPath}/books" method="get">
                <table class="checkout-table">
                    <tr>
                        <td class="label-col">Fullname:</td>
                        <td>
                            <input type="text" name="fullname" class="input-text" placeholder="Nhập họ và tên người nhận" required />
                        </td>
                    </tr>
                    <tr>
                        <td class="label-col">Shipping address:</td>
                        <td>
                            <input type="text" name="address" class="input-text" style="max-width: 550px;" placeholder="Nhập địa chỉ giao hàng" required />
                        </td>
                    </tr>
                    <tr>
                        <td class="label-col">Total price:</td>
                        <td>
                            <input type="text" name="totalPrice" class="input-text input-readonly"
                                   value="<fmt:formatNumber value='${sessionScope.cart != null ? sessionScope.cart.totalPrice : 0}' type='currency' currencyCode='VND'/>" readonly />
                        </td>
                    </tr>
                    <tr>
                        <td class="label-col">Payment method:</td>
                        <td class="radio-group">
                            <label><input type="radio" name="payment" value="paypal" checked /> Paypal</label>
                            <label><input type="radio" name="payment" value="atm" /> ATM Debit</label>
                            <label><input type="radio" name="payment" value="visa" /> Visa / Master card</label>
                        </td>
                    </tr>
                </table>

                <div class="form-actions">
                    <button type="submit" class="btn-save" onclick="alert('Đặt hàng thành công!');">Save</button>
                    <a href="${pageContext.request.contextPath}/giohang" class="btn-cancel">Cancel</a>
                </div>
            </form>
        </div>
    </main>
</div>

</body>
</html>