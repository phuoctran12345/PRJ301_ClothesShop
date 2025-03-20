<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Chỉnh sửa nhà cung cấp | Quản trị Admin</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="view/assets/admin/css/main.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
</head>
<body class="app sidebar-mini rtl">
    <%@include file="../../common/admin/sidebar.jsp"%>
    <main class="app-content">
        <div class="app-title">
            <ul class="app-breadcrumb breadcrumb">
                <li class="breadcrumb-item"><a href="ManageSupplierServlet">Danh sách nhà cung cấp</a></li>
                <li class="breadcrumb-item active">Chỉnh sửa nhà cung cấp</li>
            </ul>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h3 class="tile-title">Chỉnh sửa nhà cung cấp</h3>
                    <div class="tile-body">
                        <h3 style="color: green; text-align: center; margin: 20px 0">${requestScope.mess}</h3>
                        <h3 style="color: red; text-align: center; margin: 20px 0">${requestScope.error}</h3>
                        <form class="row" action="ManageSupplierServlet" method="post">
                            <input type="hidden" name="action" value="Update">
                            <input type="hidden" name="supplierId" value="${supplierId}">
                            <div class="form-group col-md-6">
                                <label class="control-label">Tên nhà cung cấp</label>
                                <input class="form-control" required name="name" type="text" value="${name}">
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label">Ảnh nhà cung cấp</label>
                                <input type="file" name="image" accept="image/*" />
                                <c:if test="${not empty image}">
                                    <p>Ảnh hiện tại: <img src="${image}" alt="Current image" width="50px;"></p>
                                </c:if>
                            </div>
                            <div class="form-group col-md-12">
                                <button class="btn btn-save" type="submit">Lưu lại</button>
                                <a class="btn btn-cancel" href="ManageSupplierServlet">Hủy bỏ</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>