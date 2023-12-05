<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/26/2023
  Time: 4:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error 404 - Page Not Found</title>
<style>
    .page_404{
        padding:40px 0;
        background:#fff;
        font-family: 'Arvo', serif;
        min-height: 80vh;
    }

    .page_404  img{ width:100%;}

    .page_404 .four_zero_four_bg{
        background-image: url(/assets/images/dribbble_1.gif);
        height: 500px;
        background-position: center;
        background-repeat: no-repeat;
    }


    .page_404 .four_zero_four_bg h1{
        font-size:80px;
    }

    .page_404 .four_zero_four_bg h3{
        font-size:80px;
    }

    .page_404 .link_404{
        color: #fff!important;
        padding: 10px 20px;
        background: #39ac31;
        margin: 20px 0;
        display: inline-block;
    }
    .page_404 .contant_box_404{
        margin-top:-50px;
    }
</style>

</head>
<body>
<section class="page_404">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 ">
                <div class="col-sm-offset-1 text-center">
                    <div class="four_zero_four_bg">
                        <h1 style="text-align: center;">404</h1>


                    </div>

                    <div class="contant_box_404" style="text-align: center;">
                        <h3 class="h2">
                            Look like you're lost
                        </h3>

                        <p>the page you are looking for not available!</p>

                        <a href="/" class="link_404" style="text-decoration: none; font-weight: bold;">Go to Home</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
