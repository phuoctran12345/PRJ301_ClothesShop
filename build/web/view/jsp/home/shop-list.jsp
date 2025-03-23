<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Shop list</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="view/assets/home/img/favicon.png">
        <%@include file="../../common/web/add_css.jsp"%>
    </head>
    <body>
        <div class="pos_page">
            <div class="container">
                <div class="pos_page_inner">
                    <%@include file="../../common/web/header.jsp"%>
                    <div class="breadcrumbs_area">
                        <div class="row">
                            <div class="col-12">
                                <div class="breadcrumb_content">
                                    <ul>
                                        <li><a href="DispatchServlet">home</a></li>
                                        <li><i class="fa fa-angle-right"></i></li>
                                        <li>shop</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <c:set var="cat" value="${requestScope.LISTCATEGORIES}"/>
                    <div class="pos_home_section">
                        <div class="row pos_home">
                            <form id="form-filter" action="${requestScope.DATA_FROM == 'SearchServlet' ? 'SearchServlet' : 'FilterServlet'}" method="get" class="col-lg-3 col-md-12">
                                <input type="hidden" name="valueSort" value="${requestScope.VALUESORT}"/>
                                <c:if test="${requestScope.DATA_FROM == 'SearchServlet'}">
                                    <input type="hidden" name="txtSearch" value="${requestScope.txtSearch}">
                                </c:if>
                                <div class="sidebar_widget shop_c">
                                    <div class="categorie__titile">
                                        <h4>Phân loại</h4>
                                    </div>
                                    <div class="layere_categorie">
                                        <ul>
                                            <li>
                                                <input ${(chid[0]) ? "checked" : ""} id="defaultcate" value="0" name="id_filter" type="checkbox">
                                                <label for="defaultcate">Tất cả</label>
                                            </li>
                                            <c:forEach begin="0" end="${LISTCATEGORIES.size()-1}" var="i">
                                                <li>
                                                    <input ${chid[i+1] ? "checked" : ""} value="${cat.get(i).getId()}" id="${cat.get(i).getId()}" type="checkbox" name="id_filter">
                                                    <label for="${cat.get(i).getId()}">${cat.get(i).getName()}</label>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                                <div class="sidebar_widget color">
                                    <h2>Color</h2>
                                    <div class="widget_color">
                                        <ul>
                                            <li><input type="checkbox" name="color" value="Đen" <c:forEach var="c" items="${requestScope.COLORS}"><c:if test="${c == 'Đen'}">checked</c:if></c:forEach>><label>Đen</label></li>
                                            <li><input type="checkbox" name="color" value="Xanh lá" <c:forEach var="c" items="${requestScope.COLORS}"><c:if test="${c == 'Xanh lá'}">checked</c:if></c:forEach>><label>Xanh lá</label></li>
                                            <li><input type="checkbox" name="color" value="Cam" <c:forEach var="c" items="${requestScope.COLORS}"><c:if test="${c == 'Cam'}">checked</c:if></c:forEach>><label>Cam</label></li>
                                            <li><input type="checkbox" name="color" value="Xanh dương" <c:forEach var="c" items="${requestScope.COLORS}"><c:if test="${c == 'Xanh dương'}">checked</c:if></c:forEach>><label>Xanh dương</label></li>
                                            <li><input type="checkbox" name="color" value="Vàng" <c:forEach var="c" items="${requestScope.COLORS}"><c:if test="${c == 'Vàng'}">checked</c:if></c:forEach>><label>Vàng</label></li>
                                            <li><input type="checkbox" name="color" value="Nâu" <c:forEach var="c" items="${requestScope.COLORS}"><c:if test="${c == 'Nâu'}">checked</c:if></c:forEach>><label>Nâu</label></li>
                                            <li><input type="checkbox" name="color" value="Trắng" <c:forEach var="c" items="${requestScope.COLORS}"><c:if test="${c == 'Trắng'}">checked</c:if></c:forEach>><label>Trắng</label></li>
                                            <li><input type="checkbox" name="color" value="Đỏ" <c:forEach var="c" items="${requestScope.COLORS}"><c:if test="${c == 'Đỏ'}">checked</c:if></c:forEach>><label>Đỏ</label></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="sidebar_widget price">
                                    <h2>Price</h2>
                                    <div class="shopee-price-range-filter__inputs" style="margin: 1.25rem 2px 0.625rem; display: flex; justify-content: space-between; align-items: center; padding-right: 30px">
                                        <input type="number" style="height: 35px; width: 90px;" name="pricefrom" placeholder="đ FROM" value="${price1}" step="0.5" min="1">
                                        <div class="shopee-price-range-filter__range-line" style="flex: 1; height: 1px; background: #bdbdbd; margin: 0 10px;"></div>
                                        <input type="number" style="height: 35px; width: 90px;" name="priceto" placeholder="đ TO" value="${price2}" step="0.5" min="1">
                                    </div>
                                </div>
                                <div class="sidebar_widget shop_c">
                                    <div class="categorie__titile">
                                        <h4>Discount</h4>
                                    </div>
                                    <div class="layere_categorie">
                                        <ul>
                                            <li><input ${requestScope.DISCOUNT.equals("dis25") ? "checked" : ""} id="dis25" type="radio" name="discount" value="dis25"><label for="dis25">Up to 25%</label></li>
                                            <li><input ${requestScope.DISCOUNT.equals("dis40") ? "checked" : ""} id="dis40" type="radio" name="discount" value="dis40"><label for="dis40">Up to 40%</label></li>
                                            <li><input ${requestScope.DISCOUNT.equals("dis75") ? "checked" : ""} id="dis75" type="radio" name="discount" value="dis75"><label for="dis75">Up to 75%</label></li>
                                        </ul>
                                    </div>
                                </div>
                                <button type="submit" class="submit-price" style="font-size: 16px; background-color: black; color: white; padding: 5px 40px; border-radius: 20px; margin: 10px 0 20px">Apply</button>
                                <a href="ShopServlet" class="submit-price" style="font-size: 16px; background-color: black; color: white; padding: 5px 40px; border-radius: 20px; margin: 10px 0 20px">Reset</a>
                                <c:if test="${sessionScope.account != null || sessionScope.WISHLIST != null}">
                                    <div class="sidebar_widget wishlist mb-35">
                                        <div class="block_title">
                                            <h3><a href="WishlistServlet">Wishlist</a></h3>
                                        </div>
                                        <c:forEach items="${sessionScope.WISHLIST}" var="p" varStatus="loop">
                                            <c:if test="${loop.index <= 2}">
                                                <div class="cart_item">
                                                    <div class="cart_img">
                                                        <a href="SingleProductServlet?product_id=${p.id}"><img src="${p.images[0]}" alt=""></a>
                                                    </div>
                                                    <div class="cart_info">
                                                        <a href="SingleProductServlet?product_id=${p.id}">${p.name}</a>
                                                        <span class="cart_price">${p.salePrice}đ</span>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <div class="block_content">
                                            <p>${sessionScope.WISHLIST.size()} products</p>
                                            <a href="WishlistServlet">» My wishlists</a>
                                        </div>
                                    </div>
                                </c:if>
                            </form>
                            <div class="col-lg-9 col-md-12">
                                <div class="banner_slider mb-35">
                                    <img src="view/assets/home/img/banner/banner10.jpg" alt="">
                                </div>
                                <div class="shop_toolbar list_toolbar">
                                    <div class="list_button">
                                        <ul class="nav" role="tablist">
                                            <li><a class="active" data-toggle="tab" href="#large"><i class="fa fa-th-large"></i></a></li>
                                        </ul>
                                    </div>
                                    <div class="select_option" style="display: flex; justify-content: flex-end; align-items: center">
                                        <label>Sort By: </label>
                                        <form action="${requestScope.DATA_FROM == 'FilterServlet' ? 'FilterServlet' : requestScope.DATA_FROM == 'SearchServlet' ? 'SearchServlet' : 'ShopServlet'}" method="get">
                                            <select name="valueSort" onchange="this.form.submit()">
                                                <option value="0" ${requestScope.VALUESORT == '0' ? 'selected' : ''}>Nổi bật</option>
                                                <option value="1" ${requestScope.VALUESORT == '1' ? 'selected' : ''}>Giá: Thấp đến Cao</option>
                                                <option value="2" ${requestScope.VALUESORT == '2' ? 'selected' : ''}>Giá: Cao đến Thấp</option>
                                                <option value="3" ${requestScope.VALUESORT == '3' ? 'selected' : ''}>Tên: A-Z</option>
                                            </select>
                                            <c:if test="${requestScope.DATA_FROM == 'FilterServlet'}">
                                                <c:forEach var="id" items="${paramValues.id_filter}">
                                                    <input type="hidden" name="id_filter" value="${id}">
                                                </c:forEach>
                                                <c:forEach var="color" items="${paramValues.color}">
                                                    <input type="hidden" name="color" value="${color}">
                                                </c:forEach>
                                                <input type="hidden" name="pricefrom" value="${param.pricefrom}">
                                                <input type="hidden" name="priceto" value="${param.priceto}">
                                                <input type="hidden" name="discount" value="${param.discount}">
                                            </c:if>
                                            <c:if test="${requestScope.DATA_FROM == 'SearchServlet'}">
                                                <input type="hidden" name="txtSearch" value="${requestScope.txtSearch}">
                                                <c:forEach var="id" items="${paramValues.id_filter}">
                                                    <input type="hidden" name="id_filter" value="${id}">
                                                </c:forEach>
                                                <c:forEach var="color" items="${paramValues.color}">
                                                    <input type="hidden" name="color" value="${color}">
                                                </c:forEach>
                                                <input type="hidden" name="pricefrom" value="${param.pricefrom}">
                                                <input type="hidden" name="priceto" value="${param.priceto}">
                                                <input type="hidden" name="discount" value="${param.discount}">
                                            </c:if>
                                            <input type="hidden" name="page" value="${requestScope.CURRENTPAGE}">
                                        </form>
                                    </div>
                                </div>
                                <div class="shop_tab_product">
                                    <div class="tab-content" id="myTabContent">
                                        <div class="tab-pane fade show active" id="large" role="tabpanel">
                                            <div class="row" id="listproduct">
                                                <c:forEach items="${requestScope.LISTPRODUCTS}" var="p">
                                                    <div class="col-lg-4 col-md-6">
                                                        <div class="single_product">
                                                            <div class="product_thumb">
                                                                <a href="SingleProductServlet?product_id=${p.id}"><img style="width: 250px; height:250px" src="${p.images[0]}" alt=""></a>
                                                                <c:if test="${p.releasedate.getYear() == 124}">
                                                                    <div class="img_icone">
                                                                        <img src="assets/home/img/cart/span-new.png" alt="">
                                                                    </div>
                                                                </c:if>
                                                                <c:if test="${p.discount != 0}">
                                                                    <span class="discount">Up to ${p.discount * 100}%</span>
                                                                </c:if>
                                                                <div class="product_action">
                                                                    <form action="CartServlet" method="get">
                                                                        <input type="hidden" name="action" value="Add">
                                                                        <input type="hidden" name="product_id" value="${p.id}">
                                                                        <input type="hidden" name="quantity" value="1">
                                                                        <button type="submit" style="display: block; border: none; width: 100%; background: #018576; color: #fff; padding: 7px 0; font-size: 13px;">
                                                                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                            <div class="product_content">
                                                                <div style="display: flex; justify-content: center">
                                                                    <c:if test="${p.price != p.salePrice}">
                                                                        <span style="margin-right: 10px; font-weight: 400;" class="old_price">${p.price}đ</span>
                                                                    </c:if>
                                                                    <span class="current_price">${p.getSalePrice()}đ</span>
                                                                </div>
                                                                <h3 class="product_title"><a href="SingleProductServlet?product_id=${p.id}">${p.name}</a></h3>
                                                            </div>
                                                            <div class="product_info">
                                                                <ul>
                                                                    <li>
                                                                        <form action="WishlistServlet" method="get">
                                                                            <input type="hidden" name="action" value="Add">
                                                                            <input type="hidden" name="product_id" value="${p.id}">
                                                                            <button type="submit" style="color: red; border: none; border-radius: 4px; font-size: 13px; padding: 2px 11px; font-weight: 600;">Yêu thích</button>
                                                                        </form>
                                                                    </li>
                                                                    <li><a href="SingleProductServlet?product_id=${p.id}">Xem sản phẩm</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="pagination_style">
                                    <div class="page_number">
                                        <span>Pages: </span>
                                        <ul>
                                            <c:if test="${requestScope.DATA_FROM == 'ShopServlet'}">
                                                <c:set var="page" value="${requestScope.CURRENTPAGE}"/>
                                                <c:if test="${page > 1}">
                                                    <li><a href="ShopServlet?page=${page - 1}">«</a></li>
                                                </c:if>
                                                <c:forEach var="i" begin="1" end="${requestScope.NUMBERPAGE}">
                                                    <li><a style="${page == i ? 'color: #e84c3d' : ''}" href="ShopServlet?page=${i}">${i}</a></li>
                                                </c:forEach>
                                                <c:if test="${page < requestScope.NUMBERPAGE}">
                                                    <li><a href="ShopServlet?page=${page + 1}">»</a></li>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${requestScope.DATA_FROM == 'FilterServlet'}">
                                                <c:set var="page" value="${requestScope.CURRENTPAGE}"/>
                                                <c:if test="${page > 1}">
                                                    <li><a href="FilterServlet?page=${page - 1}&${requestScope.QUERYSTRING}">«</a></li>
                                                </c:if>
                                                <c:forEach var="i" begin="1" end="${requestScope.NUMBERPAGE}">
                                                    <li><a style="${page == i ? 'color: #e84c3d' : ''}" href="FilterServlet?page=${i}&${requestScope.QUERYSTRING}">${i}</a></li>
                                                </c:forEach>
                                                <c:if test="${page < requestScope.NUMBERPAGE}">
                                                    <li><a href="FilterServlet?page=${page + 1}&${requestScope.QUERYSTRING}">»</a></li>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${requestScope.DATA_FROM == 'SearchServlet'}">
                                                <c:set var="page" value="${requestScope.CURRENTPAGE}"/>
                                                <c:if test="${page > 1}">
                                                    <li><a href="SearchServlet?page=${page - 1}&txtSearch=${requestScope.txtSearch}&valueSort=${requestScope.VALUESORT}&${requestScope.QUERYSTRING}">«</a></li>
                                                </c:if>
                                                <c:forEach var="i" begin="1" end="${requestScope.NUMBERPAGE}">
                                                    <li><a style="${page == i ? 'color: #e84c3d' : ''}" href="SearchServlet?page=${i}&txtSearch=${requestScope.txtSearch}&valueSort=${requestScope.VALUESORT}&${requestScope.QUERYSTRING}">${i}</a></li>
                                                </c:forEach>
                                                <c:if test="${page < requestScope.NUMBERPAGE}">
                                                    <li><a href="SearchServlet?page=${page + 1}&txtSearch=${requestScope.txtSearch}&valueSort=${requestScope.VALUESORT}&${requestScope.QUERYSTRING}">»</a></li>
                                                </c:if>
                                            </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../../common/web/footer.jsp"%>
    </body>
</html>