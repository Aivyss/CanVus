<%--
  Created by IntelliJ IDEA.
  User: hklei
  Date: 2/16/2021
  Time: 1:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>

<body>
<style>
    .navbar .container-fluid {
        height: 70px;
        display: flex;
        align-items: center;
    }
</style>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Brand</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li>
                <!-- Edit 드랍다운 메뉴바 시작 -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-expanded="false">Edit<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li id="addItem" onclick="createLayer();"><a href="#">create layer</a></li>
                        <li class="divider"></li>
                        <li id="makeAFeed"><a href="#">save</a></li>
                        <li id="roomExit"><a href="#">exit</a></li>
                    </ul>
                </li>
                <!-- Edit 드랍다운 메뉴바 끝 -->
                <!-- 브러시 드랍다운 메뉴바 시작 -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-expanded="false"> Brush <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu" id="brushTap">
                        <!-- 브러시 선택 시작 -->
                        <li><a href="#" class="brushElement" id="PencilBrush">Pencil</a></li>
                        <li><a href="#" class="brushElement" id="SprayBrush">Spray</a></li>
                        <li><a href="#" class="brushElement"id="EraserBrush">Eraser</a></li>
                        <li class="divider"></li>
                        <li><a href="#" class="brushElement" id="CircleBrush">Circle</a></li>
                        <li><a href="#" class="brushElement" id="SquareBrush">Square</a></li>

                        <!-- 브러시 선택 끝 -->

                        <li class="divider"></li>

                        <!-- 셀렉터 시작-->
                        <li><a href="#" class="brushElement" id="selector">Selector</a></li>
                        <!-- 셀렉터 끝-->

                        <li class="divider"></li>

                        <!-- 색상선택 시작-->
                        <li><a href="#"><input type="color" value="#005E7A" id="drawing-color"></a></li>
                        <!-- 색상선택 끝-->

                        <!-- 레인지 바 시작 -->
                        <li>
                            <link rel="stylesheet" href="/resources/css/drawing/range.css">
                            <div class="range-container">
                                <div class="range-slider">
                                    <input type="range" orient="vertical" min="0" max="100"/>
                                    <div class="range-slider__bar theme1"></div>
                                    <div class="range-slider__thumb" id="thicknessBar"></div>
                                </div>

                                <div class="range-slider">
                                    <input type="range" orient="vertical" min="0" max="100"/>
                                    <div class="range-slider__bar theme2"></div>
                                    <div class="range-slider__thumb" id="opacityBar"></div>
                                </div>
                            </div>
                        </li>
                        <li class="divider"></li>
                        <!-- 레인지바 끝 -->
                    </ul>
                </li>
                <!-- 브러시 드랍다운 메뉴바 끝 -->

            </ul>
            <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search">
                </div>
                <button type="submit" class="btn btn-default">Submit</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">Link</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-expanded="false">Dropdown <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Separated link</a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
</body>
</html>
