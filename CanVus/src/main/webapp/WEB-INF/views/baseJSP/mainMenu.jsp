<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <style type="text/css">
        a {
            cursor: hand;
        }

        .navbar-default .navbar-nav > li > div > button {
            color: #777;
        }

        #searchbar {
            margin-top: 25px;
        }
    </style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- jQuery -->
    <script src="/resources/js/jQuery/jquery-3.5.1.min.js"></script>
    <!-- Bootstrap -->
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

    <!--Main Stylesheet-->
    <link href="/resources/css/baseJSP/style.css" rel="stylesheet">


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="/resources/js/baseJSP/mainMenu.js?reload"></script>
</head>
<body data-spy="scroll" data-target="#header" style="width: 100%; padding-bottom: 50px;">
<!--Start Hedaer Section-->
<section id="header" style="width: 100%;">
    <div class="header-area">
        <div class="top_header">
            <!--End of top header-->
            <div class="header_menu text-center affix-top" data-spy="affix" data-offset-top="50" id="nav">
                <div class="container-fluid" style="width: 100%;">
                    <nav class="navbar navbar-default zero_mp ">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="nav navbar-nav navbar-left" style="width:50%;">
                            <button type="button"
                                    class="navbar-toggle collapsed"
                                    data-toggle="collapse"
                                    data-target="#bs-example-navbar-collapse-1"
                                    aria-expanded="false"
                                    style="margin-top: 30px;">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <!-- 브랜드 로고 -->
                            <a class="navbar-brand" href="/">
                                <img width="120" height="60" src="/resources/images/baseJSP/CanVus.png?reload"
                                     class="Brand img-responsive">
                            </a>

                            <!-- 검색창 파트 -->
                            <div class="navbar-left" id="searchbar" style="width:60%;">
                                <input type="text" class="form-control input-lg" placeholder="検索..." id="searchText"
                                       autocomplete="off"
                                       style="margin-left:10%; width:100%;">
                                <div class="row">
                                    <div class="dropdown" id="image-search-box">
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton"
                                             style="width: 100%;">
                                            <form class="px-4 py-3 " style="width: 100%;">
                                                <h3>イメージでタグを検索できます。</h3>
                                                <input type="file" onchange="readURL(this);">
                                            </form>
                                        </div>
                                    </div>
                                </div><!-- 검색창 파트 끝 -->
                            </div>
                        </div>
                        <div class="navbar-collapse zero_mp collapse" id="bs-example-navbar-collapse-1"
                             aria-expanded="false" style="height: 1px;">
                            <ul class="nav navbar-nav navbar-right main_menu">
                                <li><a href="/discover/">Discover</a></li>
                                <li><a href="/browse/list">Browse</a></li>
                                <c:if test="${not empty sessionScope.userId}">
                                    <li>
                                        <div class="dropdown">
                                            <button class="btn btn-navv btn-secondary dropdown-toggle dropdown-toggle-nav"
                                                    type="button" id="dropdownMenuButton" data-toggle="dropdown"
                                                    aria-haspopup="true" aria-expanded="false">
                                                Drawing
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                <form class="px-4 py-3 " style="width: 350px;" action="/drawing/createRoom"
                                                      method="post" id="create-room-form">
                                                    <div class="form-group" style="padding: 10px 10px 0 10px;">
                                                        <label for="exampleDropdownFormTitle">ルームの名</label>
                                                        <input type="text" class="form-control"
                                                               id="exampleDropdownFormTitle" name="title"
                                                               placeholder="write the title">
                                                    </div>
                                                    <div class="form-group" style="padding: 10px 10px 0 10px;">
                                                        <label for="exampleDropdownFormPassword">パスワード</label>
                                                        <input type="password" class="form-control"
                                                               id="exampleDropdownFormPassword" name="password"
                                                               placeholder="Password">
                                                    </div>
                                                    <div class="form-group" style="padding: 10px 10px 0 10px;">
                                                        <label for="exampleDropdownFormNumberOfPpl">人数</label>
                                                        <input type="text" class="form-control"
                                                               id="exampleDropdownFormNumberOfPpl" name="user_no"
                                                               placeholder="write capacity of the room">
                                                    </div>
                                                    <div align="center">
                                                        <button type="button" class="btn btn-navv btn-primary"
                                                                style="width: 150px;" id="create-room-btn">
                                                            Create
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="dropdown">
                                            <button class="dropdown-toggle dropdown-toggle-nav" type="button"
                                                    id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
                                                Profile
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                                <li role="presentation" style="width: 100%;">
                                                    <a role="menuitem" tabindex="-1"
                                                       href="../../user/board?user_id=${sessionScope.userId}">
                                                        My board
                                                    </a>
                                                </li>
                                                <li role="presentation" style="width: 100%;">
                                                    <a role="menuitem" tabindex="-1" href="/bookmark">
                                                        BookMark
                                                    </a>
                                                </li>
                                                <li role="presentation" style="width: 100%;">
                                                    <a role="menuitem" tabindex="-1" href="../../user/management">
                                                        management
                                                    </a>
                                                </li>
                                                <li role="presentation" style="width: 100%;">
                                                    <a role="menuitem" tabindex="-1" href="../../user/logout">
                                                        Logout
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </li>
                                </c:if>
                            </ul>
                        </div><!-- 로고 및 검색창 -->
                    </nav>
                    <!--End of nav-->
                </div>
                <!--End of container-->
            </div>
            <!--End of header menu-->
        </div>
        <!--end of header area-->
    </div>
</section>

<!-- 이미지 서칭 파트 -->
<div style="display: none;">
    <canvas id="canvas" width="400px" height="400px"></canvas>
    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
    <script src="/resources/js/imageSearch/imageSearch.js"></script>
</div>
</body>
</html>