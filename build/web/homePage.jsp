<%-- 
    Document   : homePage
    Created on : Sep 16, 2021, 11:54:18 AM
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
        <link href="css/paging.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
    </head>
    <body>
        <div id="tooplate_header_wrapper">
            <div id="tooplate_header">

                <div id="tooplate_menu">
                    <ul>
                        <li>
                            <a style="width: 270px; ">
                                <form action="searchAction" method="POST">
                                    <div class="form-group has-search">
                                        <span class="fa fa-search form-control-feedback"></span>
                                        <input type="text" class="form-control" placeholder="Search" value="${param.txtSearch}" name="txtSearch">
                                        <input type="submit" value="Search" name="action" />
                                    </div>
                                </form>
                            </a>
                        </li>
                        <li><a href="homeAction">Home</a></li>
                            <c:if test="${not empty sessionScope.USER}">
                            <li><a href="newPost" style="width: 150px"> Create Your Article</a></li> 
                            </c:if>
                            <c:if test="${not empty sessionScope.USER}"> 
                            <li>
                                <a class="btn border btn-light" href="logoutAction">LogOut</a>
                            </li></c:if>
                        <c:if test="${empty sessionScope.USER}"> <li><a href="try">Login Here</a></li> </c:if>
                        </ul>    	
                    </div>
                    <div id="site_title">
                        <h1 style="color: white">Welcome <font color="red">${sessionScope.USER.fullname}</font> to Your Blog</h1><br>
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
                        <h3>Recent Posts</h3>
                        <ul class="tooplate_list">
                            <c:forEach var="dto" items="${sessionScope.LISTARTICLE}">
                                <c:url var="readMoreArtical" value="viewArticleDetailAction">
                                    <c:param name="txtPostID" value="${dto.postID}"/>
                                </c:url>
                                <li><a href="${readMoreArtical}">${dto.title}</a></li>
                                </c:forEach>
                        </ul>
                    </div>
                    <div class="sb_box">
                        <h3>Your recent comments</h3>
                        <c:forEach var="comment" items="${sessionScope.LISTCOMMENTBYMAIL}">
                            <div class="recent_comment_box">
                                <a href="#">${comment.aticleTitle}</a>
                                <p><a style="color: #4b2a06">You</a>: ${comment.content}</p>
                            </div>
                        </c:forEach>
                        <div class="cleaner"></div>
                    </div>
                    <div class="sb_box">
                        <h3>People also comments</h3>
                        <c:forEach var="comment" items="${sessionScope.LISTCOMMENTRECENT}">
                            <div class="recent_comment_box">
                                <a href="#">${comment.aticleTitle}</a>
                                <p><a style="color: #4b2a06">${comment.author}</a>: ${comment.content}</p>
                            </div>
                        </c:forEach>
                        <a href="#" class="more float_r">Read more</a>
                        <div class="cleaner"></div>
                    </div>

                    <div class="cleaner"></div>
                </div>

                <div id="tooplate_sidebar_bottom"></div>

            </div> <!-- end of sidebar wrapper -->

            <c:if test="${not empty sessionScope.LIST}"> 
                <c:if var="checkList" test="${not empty sessionScope.LIST}" >
                    <jsp:useBean id="dao" class="longdh.utils.Util"/>
                    <c:forEach var="dto" items="${sessionScope.LIST}" >
                        <div id="tooplate_main" >
                            <div id="tooplate_content_wrapper">
                                <div id="tc_top" ></div>

                                <div id="tooplate_content"  >
                                    <div class="post_box">
                                        <div class="post_header" >
                                            <p class="date">
                                               ${dao.getDate(dto.date)}<span> ${dao.getMonthYear(dto.date)}</span>
                                            </p>
                                            <p class="meta">
                                                Posted by <a href="#">${dto.email}</a></a>
                                            </p>
                                            <div class="cleaner"></div>
                                        </div>
                                        <div style="width:550px">
                                            <c:url var="readMore" value="viewArticleDetailAction">
                                                <c:param name="txtPostID" value="${dto.postID}"/>
                                            </c:url>
                                            <a href="${readMore}" style="height: 25px"><h3>${dto.title}</h3></a>
                                        </div>
                                        <p style="color: #CCC" >
                                            <img src="${dto.image}" class="pirobox gallery_img image_wrapper" style="width: 170px; height: 130px; float: left; margin-right:15px;"/>                                    
                                            ${dao.truncate(dto.description,400)}
                                        </p>
                                        <div class="post_footer">
                                            <p class="comment" style="color: #CCC">${dto.countComment} comments</p>
                                            <form action="viewArticleDetailAction" method="POST">
                                                <input type="hidden" name="txtPostID" value="${dto.postID}" />
                                                <input type="submit" class="more float_r" value="Read more &raquo;" />
                                            </form>
                                            <div class="cleaner"></div>
                                        </div>
                                        <div class="cleaner"></div>
                                    </div>
                                </div>

                                <div id="tc_bottom"></div></br>
                            </div> <!-- end of content wrapper -->
                        </c:forEach>
                    </c:if>
                </c:if>
                <c:if test="${empty sessionScope.LIST}">
                    <div class="alert alert-dark my-5">
                        <h1 style="text-align: center; margin-top: 100px"> There is no result for <font style="color: white">${param.txtSearch}</font> </h1>
                    </div>
                </c:if>
                <div class="cleaner">
                    <form action="homeAction" method="POST">
                        <input type="hidden" name="pageNum" value="${param.pageNum + 1}" />
                        <div class="pagination">
                            <input class="previous" value="Next &raquo;" type="submit"/>
                            <a  style="color: black;">........................................................................................................</a>
                        </div>
                    </form>

                    <form action="homeAction" method="POST">
                        <input type="hidden" name="pageNum" value="${param.pageNum - 1}" />
                        <div class="pagination">
                            <input class="previous" value="&laquo; Previous" type="submit"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
