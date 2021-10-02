<%-- 
    Document   : errorPage
    Created on : Sep 7, 2021, 22:45:00 PM
    Author     : Dong Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>404 pages</title>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:700,900" rel="stylesheet">
    </head>
    <style>
        * {
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }

        body {
            padding: 0;
            margin: 0;
        }

        #notfound {
            position: relative;
            height: 100vh;
            background: #030005;
        }

        #notfound .notfound {
            position: absolute;
            left: 50%;
            top: 50%;
            -webkit-transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
        }

        .notfound {
            max-width: 767px;
            width: 100%;
            line-height: 1.4;
            text-align: center;
        }

        .notfound .notfound-404 {
            position: relative;
            height: 180px;
            margin-bottom: 20px;
            z-index: -1;
        }

        .notfound .notfound-404 h1 {
            font-family: 'Montserrat', sans-serif;
            position: absolute;
            left: 50%;
            top: 50%;
            -webkit-transform: translate(-50% , -50%);
            -ms-transform: translate(-50% , -50%);
            transform: translate(-50% , -50%);
            font-size: 224px;
            font-weight: 900;
            margin-top: 0px;
            margin-bottom: 0px;
            margin-left: -12px;
            color: #030005;
            text-transform: uppercase;
            text-shadow: -1px -1px 0px #8400ff, 1px 1px 0px #ff005a;
            letter-spacing: -20px;
        }


        .notfound .notfound-404 h2 {
            font-family: 'Montserrat', sans-serif;
            position: absolute;
            left: 0;
            right: 0;
            top: 110px;
            font-size: 42px;
            font-weight: 700;
            color: #fff;
            text-transform: uppercase;
            text-shadow: 0px 2px 0px #8400ff;
            letter-spacing: 13px;
            margin: 0;
        }

        .notfound a {
            margin-top: 25px;
            font-family: 'Montserrat', sans-serif;
            display: inline-block;
            text-transform: uppercase;
            color: #ff005a;
            text-decoration: none;
            border: 2px solid;
            background: transparent;
            padding: 10px 40px;
            font-size: 14px;
            font-weight: 700;
            -webkit-transition: 0.2s all;
            transition: 0.2s all;
        }

        .notfound a:hover {
            color: #8400ff;
        }

        @media only screen and (max-width: 767px) {
            .notfound .notfound-404 h2 {
                font-size: 24px;
            }
        }

        @media only screen and (max-width: 480px) {
            .notfound .notfound-404 h1 {
                font-size: 182px;
            }
        }

    </style>
    <body>
        <div id="notfound">
            <div class="notfound">
                <div class="notfound-404">
                    <h1>404</h1></br>
                    <h2>Page not found</h2>
                </div>
                <a href="homeAction">Home page</a>
            </div>
        </div>
    </body>
</html>
