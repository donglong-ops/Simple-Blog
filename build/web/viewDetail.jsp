<%-- 
    Document   : viewDetail
    Created on : Sep 28, 2020, 9:20:02 PM
    Author     : Cyrus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/index.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <link rel="stylesheet" href="./css/bootstrap.min.css">
    </head>

    <body>
        <c:if test="${empty sessionScope.USER}">
            <c:redirect url="login.jsp"/>
        </c:if>
        <c:set var="id" value="${sessionScope.USER.email}"/>
        <div class="container">
            <form action="MainController" method="POST">

                <c:if test="${not empty requestScope.DTO}">

                    <c:set var="dto" value="${requestScope.DTO}" />
                    <h1 class="d-flex justify-content-center mx-3 display-4"
                        style="font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif">${dto.title}</h1>
                    <input type="hidden" name="txtPostID" value="${dto.postID}" />
                    <blockquote style="font-size: small; float: right" class="blockquote-footer text-right my-2">From
                        ${dto.email}</blockquote> <br /> <br />
                    <p class="text-monospace jumbotron">" ${dto.description} "</p> <br />

                    <img class="img-thumbnail mx-auto d-block" src="img/${dto.image}">
                    <br /> <br />


                    <div class="float-right">
                        <i class="fas fa-calendar-times"></i> ${dto.date}
                    </div>
                    <br />
                    Status: <font color="green">${dto.status}</font>
                    <br /> <br />
                    <hr />
                    <div class="py-5">

                        <c:if test="${requestScope.LIKED}">
                            <a href="MainController?action=Like&txtPostID=<c:out value="${dto.postID}"/>">
                                <button class="btn btn-primary" type="button">
                                    <i class="far fa-thumbs-up"></i></button> </a>



                        </c:if>

                        <c:if test="${not requestScope.LIKED}">
                             <a href="MainController?action=Like&txtPostID=<c:out value="${dto.postID}"/>">
                            <button class="btn btn-outline-primary" type="button"
                            ><i class="far fa-thumbs-up"></i></button> </a>
                            </c:if>

                    </div>
                    <br/>
                    <div class="form-group">

                        <label for="comment">Comment:</label>
                        <textarea class="form-control col-md-6" rows="5"  name="txtComment" id="comment"></textarea> <br/>
                        <input class="btn btn-success" type="submit" value="Comment" name="action" />
                    </c:if>

                    <c:if test="${not empty requestScope.COMMENT}">                       
                        <c:forEach var="comment" items="${requestScope.COMMENT}">                        
                            <input type="hidden" value="${comment.commentID}" name="txtCommentID" />
                            <hr>
                            <h3>${comment.email}</h3> -  <span class="blockquote-footer"> ${comment.date}</span> <br/>
                            <p class="text-monospace jumbotron">" ${comment.content} "</p> 
                            <c:if test="${comment.email == id}">
                                <button class="btn btn-danger" data-target="#deleteModal" data-toggle="modal" type="button" >
                                    <i class="fas fa-trash"></i></button> 
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty requestScope.COMMENT}">
                        <div class ="alert alert-success">
                            <strong>Be the first one</strong> to comment this article
                        </div>
                    </c:if>       


                </div>

            </form>
        </div>
        <div class="modal" tabindex="-1" role="dialog" id="deleteModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Delete Confirm's comment</h5>
                    </div>
                    <div class="modal-body">
                        <p>Do you really want to delete your comment?</p>
                    </div>
                    <div class="modal-footer">
                        <form action="MainController" method="POST">
                            <input class="btn btn-danger" type="submit" value="Delete" name="action" />
                        </form>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No Thanks</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
            integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
            integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
    crossorigin="anonymous"></script>
    <script src="./js/bootstrap.min.js"></script>
</body>

</html>