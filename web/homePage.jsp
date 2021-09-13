<%-- 
    Document   : homePage
    Created on : Sep 13, 2021, 11:54:18 AM
    Author     : Dong Long
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>My Blog</title>
        <link href="css/tooplate_style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
    </head>
    <body>
        <div id="tooplate_header_wrapper">
            <div id="tooplate_header">

                <div id="tooplate_menu">
                    <ul>
                        <li>
                            <a style="width: 250px">
                                <form action="MainController">
                                    <input type="text" placeholder="Search" value="${param.txtSearch}" name="txtSearch">
                                    <input type="submit" value="Search" name="action" />
                                </form>
                            </a>
                        </li>
                        <li><a href="homePage.jsp">Home</a></li>
                            <c:if test="${not empty sessionScope.USER}">
                            <li><a href="blogDetailPage.jsp" style="width: 140px">Manage Your Article</a></li>
                            </c:if>
                            <c:if test="${not empty sessionScope.USER}">
                            <li><a href="about.jsp" style="width: 120px">Create Your Article</a></li> 
                            </c:if>
                            <c:if test="${not empty sessionScope.USER}"> 
                            <li>
                                <a class="btn border btn-light" href="MainController?action=LogOut">LogOut</a>
                            </li></c:if>
                        <c:if test="${empty sessionScope.USER}"> <li><a href="login.html">Login Here</a></li> </c:if>
                        </ul>    	
                    </div> <!-- end of tooplate_menu -->
                    <div id="site_title">
                        <h1 style="color: white">Welcome  <font color="red" >${sessionScope.NAME}</font> to Your Blog</h1><br>
                    <h3><a rel="nofollow" style="color: gray">Place to inspire you. Let's post your article now!</a></h3>
                </div>

            </div> <!-- end of header -->
        </div> <!-- end of header wrapper -->
        <div id="tooplate_main_wrapper">
            <div id="tooplate_top">
            </div>
            <div id="tooplate_sidebar_wrapper">
                <div id="tooplate_sidebar_top"></div>

                <div id="tooplate_sidebar">

                    <div class="ads_250x250">
                        <a href="#"><img src="./images/tooplate_ads.jpg" alt="banner" /></a>
                    </div>

                    <div class="sb_box">
                        <h3>Posts Today</h3>
                        <ul class="tooplate_list">
                            <c:forEach var="dto" items="${sessionScope.LIST}" >
                                <li><a href="MainController?action=View Detail&txtPostID=${dto.postID}">${dto.title}</a></li>
                                </c:forEach>
                        </ul>
                    </div>
                    <div class="sb_box">
                        <h3>Recent comments</h3>
                        <div class="recent_comment_box">
                            <a href="#">Praesent malesuada turpis</a>
                            <p>Duis mi elit, aliquet id euismod egestas, venenatis sit amet lectus.</p>
                        </div>

                        <div class="recent_comment_box">
                            <a href="#">Nullam consequat mauris </a>
                            <p>Etiam porttitor metus ac est mattis luctus. Integer mi tortor, tempus eget.</p>
                        </div>

                        <div class="recent_comment_box ">
                            <a href="#"> Sed bibendum augue in</a>
                            <p>Curabitur ullamcorper ultricies nisi.  Nam eget dui. Validate <a href="http://validator.w3.org/check?uri=referer" rel="nofollow"><strong>XHTML</strong></a> and <a href="http://jigsaw.w3.org/css-validator/check/referer" rel="nofollow"><strong>CSS</strong></a>.</p>
                        </div>

                        <div class="recent_comment_box">
                            <a href="#">Aenean feugiat mattis </a>
                            <p>Sed ultricies erat nec leo semper nec sollicitudin odio accumsan. </p>
                        </div>

                        <a href="#" class="more float_r">Read more</a>
                        <div class="cleaner"></div>
                    </div>

                    <div class="cleaner"></div>
                </div>

                <div id="tooplate_sidebar_bottom"></div>

            </div> <!-- end of sidebar wrapper -->

            <c:if test="${not empty sessionScope.LIST}"> 
                <c:if var="checkList" test="${not empty sessionScope.LIST}" >
                    <c:forEach var="dto" items="${sessionScope.LIST}" >
                        <div id="tooplate_main">
                            <div id="tooplate_content_wrapper">
                                <div id="tc_top"></div>

                                <div id="tooplate_content">
                                    <div class="post_box">
                                        <div class="post_header">
                                            <p class="date">
                                                26 <span>May 2048</span>
                                            </p>
                                            <p class="meta">
                                                Posted by <a href="#">${dto.email}</a></a>
                                            </p>
                                            <div class="cleaner"></div>
                                        </div>

                                        <h2>${dto.title}</h2>
                                        <p style="color: #CCC">
                                            <img src="${dto.image}" style="width: 180px; height: 180px; float: left; margin-right:15px;"/>                                    
                                            ${dto.description}
                                        </p>
                                        <div class="post_footer">
                                            <p class="comment" style="color: #CCC">${dto.countComment} comments</p>
                                            <a href="MainController?action=View Detail&txtPostID=${dto.postID}" class="more float_r" style="color: #CCC">Read more</a>
                                            <div class="cleaner"></div>
                                        </div>
                                        <div class="cleaner"></div>
                                    </div>
                                </div>

                                <div id="tc_bottom"></div></br>
                            </div> <!-- end of content wrapper -->
                        </c:forEach>
                    </c:if>
                    <c:if test="${!checkList}">
                        <div class="alert alert-dark my-5">
                            <i class="fas fa-search"></i><strong> NOT FOUND </strong> OOPSS There is no result.
                        </div>
                    </c:if>
                </c:if>
                <div class="cleaner"></div>
            </div>
            <div id="tooplate_bottom"></div>
        </div> <!-- end of main wrapper -->

        <div id="tooplate_footer">
            Copyright © 2048 <a href="#">Dong Long - Ops</a>
        </div> 
    </body>
</html>
