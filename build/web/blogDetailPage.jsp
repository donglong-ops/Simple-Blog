<%-- 
    Document   : blogDetailPage
    Created on : Sep 13, 2021, 12:08:04 PM
    Author     : Dong Long
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Blog Detail Page</title>
        <link href="css/tooplate_style.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="tooplate_header_wrapper">
            <div id="tooplate_header">

                <div id="tooplate_menu">
                    <ul>
                        <ul>
                            <li><a style="width: 30%"> </a></li>
                            <li><a href="homeAction">Home</a></li>
                                <c:if test="${not empty sessionScope.USER}">
                                <li><a href="newPost" style="width: 120px">Create Your Article</a></li> 
                                </c:if>
                                <c:if test="${not empty sessionScope.USER}"> 
                                <li>
                                    <a class="btn border btn-light" href="logoutAction">LogOut</a>
                                </li></c:if>
                            <c:if test="${empty sessionScope.USER}"> <li><a href="try">Login Here</a></li> </c:if>
                            </ul>    
                        </ul>    	
                    </div> <!-- end of tooplate_menu -->
                    <div id="site_title">
                        <h1 style="color: white">Welcome  <font color="red" >${sessionScope.USER.fullname}</font> to Your Blog</h1><br>
                    <h3><a rel="nofollow" style="color: gray">Place to inspire you. Let's post your article now!</a></h3>
                </div>

            </div> <!-- end of header -->
        </div> <!-- end of header wrapper -->
        <div id="tooplate_main_wrapper">
            <div id="tooplate_top"></div>
            <c:set var="dto" value="${requestScope.DTO}" />

            <div id="tooplate_main">
                <div id="tooplate_content_wrapper">

                    <div id="tc_top"></div>
                    <jsp:useBean id="dao" class="longdh.utils.Util"/>
                    <div id="tooplate_content">
                        <c:if test="${not empty requestScope.DTO}">
                            <div class="post_box">
                                <div class="post_header">
                                    <p class="date">
                                        ${dao.getDate(dto.date)}<span> ${dao.getMonthYear(dto.date)}</span>
                                    </p>
                                    <p class="meta">
                                        Posted by <a href="#">${dto.email}</a></a>
                                    </p>
                                    <div class="cleaner"></div>
                                </div>
                                <h2 style="width:550px">${dto.title}</h2>
                                <p style="color: #CCC">
                                    <img src="${dto.image}"class="pirobox gallery_img image_wrapper" style="width: 200px; height: 190px; float: left; margin-right:15px;"/>                                    
                                    ${dto.description} 
                                </p>
                                <div class="cleaner"></div>
                            </div>

                            <h3>Comments</h3>

                            <div id="comment_section">
                                <ol class="comments first_level">
                                    <c:if test="${not empty requestScope.COMMENT}">
                                        <c:forEach var="comment" items="${requestScope.COMMENT}">
                                            <li>
                                                <div class="comment_box commentbox1">
                                                    <div class="gravatar">
                                                        <img src="./images/comment.jpg" alt="author" />
                                                    </div>
                                                    <div class="comment_text">
                                                        <div class="comment_author">${comment.userDto.fullname}<span class="date">${comment.date}</span></div>
                                                        <p>${comment.content}</p>
                                                        <div class="btn_more float_r"><a href="#"><span>+</span> Reply</a></div>
                                                    </div>
                                                    <div class="cleaner"></div>
                                                </div> 
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty requestScope.COMMENT}">
                                        <li>
                                            <div class="comment_box commentbox1">
                                                <p style="color: #8da332"><strong>Be the first one</strong> to comment this article</p>
                                                <div class="cleaner"></div>
                                            </div> 
                                        </li>
                                    </c:if> 
                                </ol>
                            </div> <!-- end of comment -->

                            <div id="comment_form">
                                <h3>Leave your comment</h3>
                                <form action="postCommentAction" method="POST">
                                    <div class="form_row">
                                        <input type="hidden" name="txtPostID" value="${dto.postID}" />
                                        <label style="color: #ffffff">Comment</label><br />
                                        <textarea style="height: 60px; color: white" name="txtComment"></textarea>
                                    </div>
                                    <input type="submit" value="Comment" name="action" style="color: #CCC" class="submit_btn" />
                                </form>

                            </div>
                        </c:if>
                        <c:if test="${empty requestScope.DTO}">
                            <div class="alert alert-dark my-5 text-center">
                                <img src="./images/saying.png" width="552" />
                                <h2 style="text-align: center; margin-top: 10px; color: red"> The post has been removed by the owner </h2>
                            </div>
                        </c:if>
                    </div>
                    <div id="tc_bottom"></div>
                </div> <!-- end of content wrapper -->

                <div id="tooplate_sidebar_wrapper">
                    <div id="tooplate_sidebar_top"></div>

                    <div id="tooplate_sidebar">

                        <div class="ads_250x250">
                            <a href="#"><img src="./images/tooplate_ads.jpg" alt="banner" /></a>
                        </div>

                        <div class="sb_box">
                            <h3>Other Posts</h3>
                            <ul class="tooplate_list">
                                <c:forEach var="dto" items="${sessionScope.LISTARTICLE}" >
                                    <c:url var="readMoreArtical" value="viewArticleDetailAction">
                                        <c:param name="txtPostID" value="${dto.postID}"/>
                                    </c:url>
                                    <li><a href="${readMoreArtical}">${dto.title}</a></li>    
                                    </c:forEach>
                            </ul>
                        </div>

                        <div class="cleaner"></div>
                    </div>

                    <div id="tooplate_sidebar_bottom"></div>
                </div> <!-- end of sidebar wrapper -->

                <div class="cleaner"></div>
            </div>

            <div id="tooplate_bottom"></div>
        </div> <!-- end of main wrapper -->

        <div id="tooplate_footer">
            Copyright © 2048 <a href="#">Dong Long - Ops</a>
        </div> <!-- end of tooplate_footer -->
    </body>
</html>
