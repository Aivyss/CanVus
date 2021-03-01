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
            <a class="navbar-brand" href="#">Drawing Toolbar</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <!-- Edit 드랍다운 메뉴바 시작 -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-expanded="false">Edit<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu" id="Edit">
                        <li id="Edit-feed"><a href="#">write a feed</a></li>
                        <li id="Edit-exit"><a href="#">exit</a></li>
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
                                    <div class="range-slider__thumb" id="thicknessBar" style="bottom: 10%">10%</div>
                                </div>

                                <div class="range-slider">
                                    <input type="range" orient="vertical" min="0" max="100"/>
                                    <div class="range-slider__bar theme2"></div>
                                    <div class="range-slider__thumb" id="opacityBar" style="bottom: 10%">10%</div>
                                </div>
                            </div>
                        </li>
                        <li class="divider"></li>
                        <!-- 레인지바 끝 -->
                    </ul>
                </li>
                <!-- 브러시 드랍다운 메뉴바 끝 -->
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <!-- 방 멤버리스트 -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-expanded="false">members <span class="caret"></span></a>
                    <ul class="dropdown-menu " id="canvus-list" role="menu">
                        <!-- li 태그로 유저 리스트가 동적으로 기입되는 부분 -->
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
</body>
</html>
