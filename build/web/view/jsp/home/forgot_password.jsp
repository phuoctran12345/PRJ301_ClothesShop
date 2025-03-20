<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Forgot password</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="view\assets\home\img\favicon.png">

        <!-- all css here -->
        <%@include file="../../common/web/add_css.jsp"%>
    </head>
    <body>
        <!-- Add your site or application content here -->

        <!--pos page start-->
        <div class="pos_page">
            <div class="container"> 
                <!--pos page inner-->
                <div class="pos_page_inner">  
                    <!--header area -->
                    <%@include file="../../common/web/header.jsp"%>
                    <!--header end -->
                    <!--breadcrumbs area start-->
                    <div class="breadcrumbs_area">
                        <div class="row">
                            <div class="col-12">
                                <div class="breadcrumb_content">
                                    <ul>
                                        <li><a href="DispatchServlet">home</a></li>
                                        <li><i class="fa fa-angle-right"></i></li>
                                        <li>Forgot password</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--breadcrumbs area end-->

                    <!-- customer login start -->
                    <div class="customer_login">
                        <div class="row">
                            <!--login area start-->
                            <div class="col-lg-6 col-md-6">
                                <div class="account_form">
                                    <h2>Reset your password</h2>
                                    <form action="ForgotPasswordServlet" method="get">
                                        <p> 
                                            <c:if test="${requestScope.STATUS == 'forgot'}">
                                                <label>Enter email you want to receive the code to reset your password?</label><br/>
                                                <input type="email" name="txtEmail" value="${sessionScope.email}"/>
                                            </c:if>
                                            <c:if test="${requestScope.check == 'true'}">
                                            <h7 style="color: green">${requestScope.message}</h7>
                                            </c:if>
                                            <c:if test="${requestScope.check == 'false'}">
                                            <h7 style="color: red">${requestScope.message}</h7>
                                            </c:if>
                                        </p>
                                        <c:if test="${requestScope.STATUS == 'confirm'}">
                                            <p style="position: relative">   
                                                <label>Code - 6 digit <span>*</span></label>
                                                <input  type="number" name="txtCode" value="${requestScope.code}"/>
                                            </p>

                                        </c:if>
                                        <c:if test="${requestScope.STATUS == 'enterpass'}">
                                            <p style="position: relative">
                                                <label>Passwords <span>*</span></label>
                                                <input id="password" type="password" name="txtPassword" value="${requestScope.newpass}" minlength="6"/>
                                                <i id="iconsee" style="cursor: pointer; position: absolute; top: 40px; right: 10px" onclick="changeIcon(this)" class="fa-solid fa-eye-slash"></i>
                                            </p>
                                            <p style="position: relative">
                                                <label>Confirm passwords <span>*</span></label>
                                                <input id="password" type="password" name="txtConfirm" value="${requestScope.confirmpass}" minlength="6"/>
                                                <!--<i id="iconsee" style="cursor: pointer; position: absolute; top: 40px; right: 10px" onclick="changeIcon(this)" class="fa-solid fa-eye-slash"></i>-->
                                            </c:if>
                                        </p>
                                        <c:if test="${requestScope.STATUS != 'success'}">
                                            <div class="login_submit">
                                                <button name="btnAction" value="Enter" type="submit">Enter</button>
                                            </div>
                                        </c:if>
                                        <c:if test="${requestScope.STATUS == 'success'}">
                                            <div class="user-actions mb-20">
                                               <div>
                                                        Cập nhật mật khẩu thành công!
                                                        <a href="${pageContext.request.contextPath}/DispatchServlet">Click here to login</a>
                                              </div>
                                            </div>
                                        </c:if>
                                    </form>
                                </div>    
                            </div>
                            <!--login area start-->

                        </div>
                    </div>
                    <!-- customer login end -->

                </div>
                <!--pos page inner end-->
            </div> 
        </div>
        <!--pos page end-->

        <!--footer area start-->
        <%@include file="../../common/web/footer.jsp"%>
        <!--footer area end-->

       
    </body>
</html>

