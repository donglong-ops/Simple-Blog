<%-- 
    Document   : postArticle
    Created on : Sep 20, 2021, 3:16:52 PM
    Author     : Dong Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/createPost.css" rel="stylesheet" type="text/css" />
        <link href="css/tooplate_style.css" rel="stylesheet" type="text/css" />
        <title>Create Page</title>
    </head>
    <div id="tooplate_menu">
        <ul>
            <li><a style="width: 40%"> </a></li>
            <li><a href="homeAction">Home</a></li>
                <c:if test="${not empty sessionScope.USER}">
                <li><a href="newPost" style="width: 150px"> Create Your Article</a></li> 
                </c:if>
                <c:if test="${not empty sessionScope.USER}"> 
                <li><a style="width: 200px" >Welcome <font color="red" >${sessionScope.USER.fullname}</font></a></li>
                    </c:if>
                    <c:if test="${not empty sessionScope.USER}"> 
                <li><a href="logoutAction">LogOut</a></li>
                </c:if>
                <c:if test="${empty sessionScope.USER}"> <li><a href="try">Login Here</a></li> </c:if>
            </ul>    	
        </div>
        <body style="background-color: #381d00">
        <h2 class="text-center" style="color: white">Create new Article</h2>
        <c:set var="dto" value="${requestScope.DTO}"/>
        <div class="container border p-4" style="width: 850px; height: 580px; background-color: #f0f0f0" >
            <div class="form-group" style="width: 800px">
                <form action="postArticleAction" method="POST" enctype="multipart/form-data">
                    <c:set var="errors" value="${requestScope.CREATEERROR}"/>
                    <!--<label></label>-->
                    <h4>Title</h4>
                    <div style="width: 800px">
                        <input type="text" class="form-control" name="txtTitle" value="${dto.title}"/>
                        <c:if test="${not empty errors.titleError}">
                            <font color="red">${errors.titleError}</font></br>     
                        </c:if>
                    </div>
                    <!--<label>Content</label>-->
                     <h4>Content</h4>
                    <div style="width: 810px;">
                        <div class="form-row" >
                            <div class="col-md-7 mb-2">
                                <textarea rows="14" class="form-control" name="txtDiscription" placeholder="What's in your mind?">${dto.description}</textarea>
                                <c:if test="${not empty errors.descriptionError}">
                                    <font color="red">${errors.descriptionError}</font></br>     
                                </c:if>
                            </div>
                            <div class="col-md-5">
                                <div class="form-row">
                                    <img id="blah" src="#" alt="Article Image" style="width: 330px; margin-bottom: 10px;" />
                                    <input accept="image/*" type='file' id="imgInp" name="fileImage"/>
                                </div>
                                <c:if test="${not empty errors.imageError}">
                                    <font color="red">${errors.imageError}</font></br>     
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <!--class="modal-footer"-->
                    <div  style="float: right; margin-right: 5px" > 
                        <button class="btn btn-outline-danger" id="submit">Submit</button>
                    </div>
                </form>
            </div> 
        </div>
    </body>

    <script>

        imgInp.onchange = evt => {
            const [file] = imgInp.files
            if (file) {
                blah.src = URL.createObjectURL(file)
            }
        }
    </script>
</html>
