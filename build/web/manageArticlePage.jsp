<%-- 
    Document   : manageArticlePage
    Created on : Sep 17, 2021, 11:54:18 AM
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    </head>
    <body>
        <div id="tooplate_header_wrapper">
            <div id="tooplate_header">
                <div id="tooplate_menu">
                    <ul>
                        <li><a style="width: 25%"> </a></li>
                        <li><a href="aboutUs">About Us</a></li>
                        <li><a href="gallery">Gallery</a></li>
                        <li><a href="#">Contact</a></li>
                            <c:if test="${not empty sessionScope.USER}"> 
                            <li>
                                <a href="logoutAction">LogOut</a>
                            </li></c:if>
                        <c:if test="${empty sessionScope.USER}"> <li><a href="try">Login Here</a></li> </c:if>
                        </ul>    	
                    </div> <!-- end of tooplate_menu -->
                    <div style="margin-left: 150px; margin-top: 40px">
                        <h1 style="color: white">Welcome admin <font color="red" >${sessionScope.USER.fullname}</font></h1><br>
                </div>
            </div> 

            <Form action="adminSearchAricleAction" method="POST">
                <div class="form-row" >          
                    <div class="col-md-3" >

                    </div>
                    <div class="col-md-2 mt-3">
                        <input placeholder=" Search by article title" type="text" class="form-control" name="txtSearchName" value="${param.txtSearchName}" />        
                    </div> 
                    <div class="col-md-2 mt-3">
                        <select class="form-control form-control-line" name="txtStatus">
                            <option value="2" 
                                    <c:if test="${param.txtStatus eq '2'}">
                                        selected="selected"
                                    </c:if>>Status: Active</option>
                            <option value="1"
                                    <c:if test="${param.txtStatus eq '1'}">
                                        selected="selected"
                                    </c:if>>Status: New</option>
                            <option value="3"
                                    <c:if test="${param.txtStatus eq '3'}">
                                        selected="selected"
                                    </c:if>>Status: Delete</option>
                        </select>
                    </div> 

                    <div class="col-md-2 mt-3">
                        .<input class="col-md- btn btn-primary px-5" type="submit" name="btAction" value="Search" />
                    </div> 
                </div>
            </Form>

        </div> <!-- end of header wrapper -->
        <div style="background-color: #f8f9fa; margin-top: 80px">
            <div class="container mt-5" style="width: 1200px">
                <c:set var="articles" value="${requestScope.MANAGELIST}"/>
                <c:if test="${not empty articles}">
                    <table class=" table table-bordered">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Article Title</th>
                                <th>Image</th>
                                <th>Description</th>
                                <th>Author</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <jsp:useBean id="dao" class="longdh.utils.Util"/>
                            <c:forEach var="dto" items="${articles}" varStatus="counter">
                                <tr>
                                    <td style="width: 40px">${counter.count} </td>
                                    <td style="width: 160px">${dto.title}</td>
                                    <td style="width: 120px">
                                        <img class="border rounded" src="${dto.image}" width="120px" height="110px"/>
                                    </td>
                                    <td style="width: 270px">${dao.truncate(dto.description,140)}</td> 
                                    <td style="width: 130px">${dto.email}</td>
                                    <td style="width: 200px">
                                        <c:if test="${not empty sessionScope.USER}">
                                            <div class="form-row">
                                                <form action="rejectArticleAction" method="POST" style="margin-right: 5px">
                                                    <input type="hidden" name="txtPostID" value="${dto.postID}" />
                                                    <input type="submit" class="btn btn-danger" onclick="return confirm('Are you sure to reject this articles ?');" style="color: white" value="Reject" />
                                                </form>
                                                <form action="approveArticleAction" method="POST">
                                                    <input type="hidden" name="txtPostID" value="${dto.postID}" />
                                                    <input type="submit" class="btn btn-success" onclick="return confirm('Are you sure to approve this articles ?');" style="color: white" value="Approve" />
                                                </form>
                                            </div>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${not empty articles}">
                        <div class="form-row mb-4" style="float: right; margin-right: 40px">
                            <c:if test="${not empty param.pageNum}">
                                <p>   Page  [${param.pageNum}]: </p>
                            </c:if>
                            <c:if test="${empty param.pageNum}">
                                <p>   Page  [1]: </p>
                            </c:if>
                            <c:forEach begin="1" end="${requestScope.PAGENUMBER}" varStatus="counter" step="1">
                                <form action="manageArticleAction" method="POST">
                                    <input type="hidden" name="pageNum" value="${counter.count}" />
                                    <input id="page" class="btn btn-primary ml-3" type="submit" value="${counter.count}"/>
                                </form>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:if>
                <c:if test="${empty articles}">
                    <div style="height: 260px">
                        <h5 class="alert alert-danger text-center" style="width: 100%">Not Found!!!!!</h5>
                    </div>
                </c:if>
            </div>
        </div>
        <div id="tooplate_footer" style="background-color: #0c0c0c; width: 100%">
            <font style="color: white">Copyright © 2021</font> <a href="https://github.com/donglong-ops">Dong Long - Ops</a>
        </div> 
    </body>
</html>
