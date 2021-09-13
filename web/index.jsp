<%-- 
    Document   : index
    Created on : Sep 14, 2020, 4:00:03 PM
    Author     : Cyrus
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mini Social Network</title>
        <link rel="stylesheet" href="css/index.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <link rel="stylesheet" href="./css/bootstrap.min.css">

    </head>

    <body>
        <c:if test="${empty sessionScope.USER}">
            <c:redirect url="login.jsp"/>
        </c:if>

        <div class="container-fluid">
            <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
                <c:set var="name" value="${sessionScope.NAME}" />
                <c:set var="id" value="${sessionScope.USER.email}"/>
                <div class="collapse navbar-collapse d-flex justify-content-between" id="navbarNav">
                    <form class="form-inline my-5 my-lg-0" action="MainController">
                        <input class="form-control mr-sm-2" type="text" placeholder="Search" value="${param.txtSearch}"
                               name="txtSearch">
                        <input class="btn btn-outline-success my-2 my-sm-0" type="submit" value="Search" name="action" />
                        <input type="button" value="Post your article" class="btn btn-outline-primary my-2 my-sm-0" data-toggle="modal"
                               data-target="#insertModal" />
                        <c:if test="${ not empty sessionScope.USER}">
                            <a class="btn btn-success" href="login.jsp">Manage Your Post!!!</a>
                        </c:if>
                        <c:if test="${empty sessionScope.USER}">
                            <a class="btn btn-success" href="login.jsp">Login here!!!</a>
                        </c:if>

                        <button type="submit" value="Logout" name="action" class="btn btn-warning my-2 my-sm-0">
                            <i class="fas fa-sign-out-alt"></i></button>
                    </form>
                </div>
            </nav>
            <c:if test="${not empty name}">
                <h2>Welcome back <font color="red">${name}</font>
                    </h1>
                </c:if>
                <c:if test="${not empty sessionScope.LIST}">
                    <c:if var="checkList" test="${not empty sessionScope.LIST}" >
                        <c:forEach var="dto" items="${requestScope.LIST}" >
                            <div class="well">
                                <div class="media">
                                    
                                    <c:if test="${not empty dto.image}">
                                        <a class="pull-left" href="#">
                                            <img class="img-fluid" src="${dto.image}">
                                        </a>
                                    </c:if>

                                    <div class class="media-body" style="margin-left: 100px">
                                        <input type="hidden" name="txtPostID" value="${dto.postID}" />
                                        <h1 style="font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif" class="py-4" >${dto.title}</h1>
                                        <blockquote style="font-size: small" class="blockquote-footer">From ${dto.email}</blockquote> <br /> <br />
                                        <p class="text-monospace jumbotron">" ${dto.description} "</p> <br />
                                        <ul class="list-inline list-unstyled">
                                            <li class="list-inline-item"><span><i class="fas fa-calendar-times"></i></span> ${dto.date}</li>
                                            <li class="list-inline-item">|</li>
                                            <span ><i class="fas fa-comments"></i> ${dto.countComment} comments</span> <br/>

                                            <h5 class="text-primary">Like: <small class="text-primary" >secondary text</small></h5>
                                            <h5 class="text-danger" >Dislike: <small class="text-danger" >secondary text</small></h5>

                                        </ul>
                                        <a href="MainController?action=View Detail&txtPostID=${dto.postID}"  type="submit" value="View Detail"
                                           name="action"> <button class="btn btn-warning">View Detail
                                            </button></a>


                                        <a href="MainController?action=Delete&txtPostID=<c:out value="${dto.postID}"/>">
                                            <button class="btn btn-danger" data-target="#deleteModal" data-toggle="modal" type="button" >
                                                <i class="fas fa-trash"></i></button> 
                                        </a>

                                    </div>

                                </div>
                            </div>
                            <hr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${!checkList}">
                        <div class="alert alert-dark my-5">
                            <i class="fas fa-search"></i><strong> NOT FOUND </strong> OOPSS There is no result.
                        </div>
                    </c:if>
                </c:if>


                <div class="modal" tabindex="-1" role="dialog" id="deleteModal">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Delete Confirm's form</h5>
                            </div>
                            <div class="modal-body">
                                <p>Do you really want to delete your article?</p>
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

                <ul class="pagination d-flex- justify-content-center">
                    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">Next</a></li>
                </ul>

        </div>
        <div class="modal" id="insertModal"> <!--  này là tạo mới post-->
            <form enctype="multipart/form-data" action="MainController" method="POST">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h5 class="modal-title d-flex justify-content-center">Create Post</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body form-group">

                            Title: <input class="form-control" type="text" name="txtTitle" value="${param.txtTitle}" />
                            <br />
                            <input type="hidden" name="txtPostID" value="" />
                            <label>Description:</label>
                            <textarea name="txtDescription" class="form-control" rows="5" id="comment"
                                      placeholder="What's on your mind ${name}?">${param.txtDescription}</textarea>
                            <label>Image:</label>
                            <input class="form-control" type="file" name="txtImage" value="${param.txtImage}" /> <br />


                        </div>

                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <input class="btn btn-outline-danger" type="submit" value="Post the article" name="action" />
                        </div>

                    </div>
                </div>
            </form>
        </div>
        <c:if test="${not empty requestScope.ERROR}">
            <div class="modal" id="errorModal">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h5 class="modal-title-danger d-flex justify-content-center">Error</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body form-group">
                            <c:out value="${requestScope.ERROR}" />
                        </div>
                    </div>
                </div>
            </div>
        </c:if>



        <script>
            $(document).ready(function () {
                console.log('<c:out value="${sessionScope.USER.email}"/>');
            });
        </script>
        <c:if test="${not empty requestScope.ERROR}">
            <script>
                $(document).ready(() => {
                    $('#errorModal').modal({
                        show: true
                    });
                });

            </script>
        </c:if>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
                integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
                integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
        <script src="./js/bootstrap.min.js"></script>
    </body>

</html>
