<%-- 
    Document   : verify
    Created on : Sep 13, 2021, 10:06:57 AM
    Author     : Dong Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Page</title>
    </head>
    <body>
        <div class="jumbotron text-center" style="height: 660px">
            <h1 class="display-3">Thank You!</h1>
            <p class="lead"><strong>Please check your email</strong> for get code to complete your account setup.</p>
            <form action="activeAccount" method="POST">
                <div class="form-row" style="margin-left: 35%">
                    Input code:  <input style="width: 180px; margin-left: 5px" class="form-control" type="number" required name="txtCode" value="" />
                    <input class="btn btn-success ml-2 px-4"  type="submit" value="Verify" />
                </div>
            </form>
            <hr>
            <p>
                Having trouble? <a href="">Contact us</a>
            </p>
        </div>
    </body>
</html>
