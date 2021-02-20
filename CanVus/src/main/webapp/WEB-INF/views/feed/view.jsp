<%--
  Created by IntelliJ IDEA.
  User: hklei
  Date: 2/14/2021
  Time: 10:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container">
    <div class="container height-100 d-flex justify-content-center align-items-center">
        <div class="card card-border center-block">
            <div class="row center-block">
                <!-- 컨텐츠 포지션 -->
                <div class="col-xs-9">
                    <!-- <iframe width="380" height="220" src="./testImage.png" frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen></iframe> -->
                    <img src="testImage.png" width="100%">
                    <div class="p-3 content">
                        <span>total 4pages</span>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
                            ut
                            labore
                            et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
                            laboris
                            nisi
                            ut
                            aliquip ex ea commodo consequat.
                        </p>
                    </div>
                </div>
                <!-- 사이드 포지션 -->
                <div class="col-xs-3 height-100 side-plate">
                    <!-- 참여유저 목록 -->
                    <div class="list-group">
                        <a href="#" class="list-group-item">유저1</a>
                        <a href="#" class="list-group-item">유저2</a>
                        <a href="#" class="list-group-item">유저3</a>
                        <a href="#" class="list-group-item">유저4</a>
                    </div>
                    <br>
                    <!-- like 관련 -->
                    <div>
                        <button class="btn btn-primary" type="button">
                            Like
                            <span class="badge">25</span>
                        </button>
                    </div>
                    <br>

                    <!-- 북마크 버튼 -->
                    <div>
                        <div class="dropdown">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1"
                                    data-toggle="dropdown" aria-expanded="true">
                                Dropdown
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">북마크1</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">북마크2</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">북마크3</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">북마크4</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row center-block">
                <br>
                <!-- 코멘트 컨테이너-->
                <div class="col-lg-6">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search for...">
                        <span class="input-group-btn">
                                <button class="btn btn-default" type="button">comment</button>
                            </span>
                    </div>
                    <div class="about">
                            <span>
                                <span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
                                <small>12</small></span>
                        <span class="ml-2">
                                <span class="glyphicon glyphicon-envelope"></span>
                                <small>12</small>
                            </span>
                    </div>
                </div>

                <br>
                <div class="col-lg-6">
                    <div class="media">
                        <div class="media-left media-middle">
                            <a href="#">
                                <img class="media-object" src="./testImage.png" style="height:32px; width:32px;">
                            </a>
                        </div>
                        <div class="media-body">
                            <h5 class="media-heading"><a href="/user/board/?user_id=1234">닉네임1</a></h5>
                            가나다라 마바사 아자차카타파
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-left media-middle">
                            <a href="#">
                                <img class="media-object" src="./testImage.png" style="height:32px; width:32px;">
                            </a>
                        </div>
                        <div class="media-body">
                            <h5 class="media-heading"><a href="/user/board/?user_id=1234">닉네임2</a></h5>
                            가나다라 마바사 아자차카타파
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
