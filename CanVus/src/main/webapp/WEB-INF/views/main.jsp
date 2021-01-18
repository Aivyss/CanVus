<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<style type="text/css">
.navbar-default .navbar-nav>li>div>button {
    color: #777;
}

</style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>CanVus</title>

    <!--    Google Fonts-->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!--Fontawesom-->
    <link rel="stylesheet" href="/resources/mainAsset/css/font-awesome.min.css">

    <!--Animated CSS-->
    <link rel="stylesheet" type="text/css" href="/resources/mainAsset/css/animate.min.css">

    <!-- Bootstrap -->
    <link href="/resources/mainAsset/css/bootstrap.min.css" rel="stylesheet">
    <!--Bootstrap Carousel-->
    <link type="text/css" rel="stylesheet" href="/resources/mainAsset/css/carousel.css" />

    <link rel="stylesheet" href="/resources/mainAsset/css/isotope/style.css">

    <!--Main Stylesheet-->
    <link href="/resources/mainAsset/css/style.css" rel="stylesheet">
    <!--Responsive Framework-->
    <link href="/resources/mainAsset/css/responsive.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    <script type="text/javascript">
		function searchResult(){
			var searchText = document.getElementById("searchText").value;
			location.href = "/searchResult";
			return searchText;
		}
	
    </script>
</head>

<body data-spy="scroll" data-target="#header">
    <!--Start Hedaer Section-->
    <section id="header">
        <div class="header-area">
            <div class="top_header">
                <div class="container">
                    <div class="row">
                        <!--Start of col-lg-6-->
                        <div class="col-lg-6">
                            <div class="input-group">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" onclick="searchResult();">Go!</button>
                                </span>
                                <input type="text" class="form-control" placeholder="Search for..." id="searchText">
                            </div><!-- /input-group -->
                            <!--End of col-lg-6-->
                        </div>
                        <!--End of row-->
                    </div>
                    <!--End of container-->
                </div>
                <!--End of top header-->
                <div class="header_menu text-center" data-spy="affix" data-offset-top="50" id="nav">
                    <div class="container">
                        <nav class="navbar navbar-default zero_mp ">
                            <!-- Brand and toggle get grouped for better mobile display -->
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand custom_navbar-brand" href="#"><img src="/resources/mainAsset/img/CanVus.png"
                                        alt=""></a>
                            </div>
                            <!--End of navbar-header-->

                            <!-- Collect the nav links, forms, and other content for toggling -->
                            <div class="collapse navbar-collapse zero_mp" id="bs-example-navbar-collapse-1">
                                <ul class="nav navbar-nav navbar-right main_menu">
                                    <li class="active"><a href="#header">Home <span class="sr-only">(current)</span></a>
                                    </li>
                                    <li><a href="/discovery">Discovery</a></li>                     
                                    <li><a href="/share">Share</a></li>
                                    <li>
                                    	<div class="dropdown">
  										<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" 
  										data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    	Drawing
                                    	</button>
                                    	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
										  <form class="px-4 py-3 " style ="width: 350px;" action="/drawingRoom" method="post">
										    <div class="form-group" style ="padding: 10px 10px 0 10px;">
										      <label for="exampleDropdownFormTitle">Title</label>
										      <input type="text" class="form-control" id="exampleDropdownFormTitle" placeholder="write the title">
										    </div>
										    <div class="form-group" style ="padding: 10px 10px 0 10px;">
										      <label for="exampleDropdownFormPassword1">Password</label>
										      <input type="password" class="form-control" id="exampleDropdownFormPassword" placeholder="Password">
										    </div>
										   <div class="form-group" style ="padding: 10px 10px 0 10px;">
										      <label for="exampleDropdownFormPassword1">No.Ppl</label>
										      <input type="text" class="form-control" id="exampleDropdownFormNumberOfPpl" placeholder="write capacity of the room">
										    </div>
										    <div align = "center">   
										    <button type="submit" class="btn btn-primary" style="width: 150px;">Create</button>
										   	</div> 
										   </form>
										</div>
                                    </div>	
                                    </li>
                                    <li>
                                        <div class="dropdown">
                                            <button class="btn btn-default dropdown-toggle" type="button"
                                                id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
                                                Profile
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                                <li role="presentation"><a role="menuitem" tabindex="-1"
                                                        href="/board">My board</a></li>
                                                <li role="presentation"><a role="menuitem" tabindex="-1"
                                                        href="/user/bookmarks">BookMarks</a></li>
                                                <li role="presentation"><a role="menuitem" tabindex="-1"
                                                        href="/user/pixelManagement">pixelManagement</a></li>
                                                <li role="presentation"><a role="menuitem" tabindex="-1"
                                                        href="/user/settings">Settings</a></li>
                                                <li role="presentation"><a role="menuitem" tabindex="-1"
                                                        href="/logout">Logout</a></li>
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <!-- /.navbar-collapse -->
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
    <!--End of Hedaer Section-->

    <!-- Start of Main contents -->
    <section id="blog">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="latest_blog text-center">
                        <h2>好みの絵</h2>
                        <p>あなたが見たい絵を分析して提供しております。</p>
                    </div>
                </div>
            </div>
            <!--End of row-->

            <!-- Feed set-->
            <div class="row">
                <!-- One Feed -->
                <div class="col-md-4">
                    <div class="blog_news">
                        <div class="single_blog_item">
                            <div class="blog_img">
                                <img src="/resources/mainAsset/img/keion.jpg" alt="">
                            </div>
                            <div class="blog_content">
                                <a href="">
                                    <h3>けいおん！テスト！</h3>
                                </a>
                                <div class="expert">
                                    <div class="left-side text-left">
                                        <p class="left_side">
                                            <span class="clock"><i class="fa fa-clock-o"></i></span>
                                            <span class="time">2021.01.08</span>
                                            <a href=""><span class="admin"><i class="fa fa-user"></i> Aivyss</span></a>
                                        </p>
                                        <p class="right_side text-right">
                                            <a href=""><span class="right_msg text-right"><i
                                                        class="fa fa-comments-o"></i></span>
                                                <span class="count">+9999</span></a>
                                        </p>
                                        <button type="button" class="btn btn-default btn-sm">
                                            <span class="glyphicon glyphicon-heart" aria-hidden="true"></span> Like!
                                        </button>
                                    </div>
                                </div>

                                <p class="blog_news_content">Lorem ipsum dolor sit amet, consectetur adipscing elit.
                                    Lorem ipsum dolor sit amet, conse ctetur adipiscing elit. consectetur Lorem ipsum
                                    dolor sitamet, conse ctetur adipiscing elit. </p>
                                <a href="" class="blog_link">read more</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- One Feed -->
                <div class="col-md-4">
                    <div class="blog_news">
                        <div class="single_blog_item">
                            <div class="blog_img">
                                <img src="/resources/mainAsset/img/keion.jpg" alt="">
                            </div>
                            <div class="blog_content">
                                <a href="">
                                    <h3>けいおん！テスト！</h3>
                                </a>
                                <div class="expert">
                                    <div class="left-side text-left">
                                        <p class="left_side">
                                            <span class="clock"><i class="fa fa-clock-o"></i></span>
                                            <span class="time">2021.01.08</span>
                                            <a href=""><span class="admin"><i class="fa fa-user"></i> Aivyss</span></a>
                                        </p>
                                        <p class="right_side text-right">
                                            <a href=""><span class="right_msg text-right"><i
                                                        class="fa fa-comments-o"></i></span>
                                                <span class="count">+9999</span></a>
                                        </p>
                                        <button type="button" class="btn btn-default btn-sm">
                                            <span class="glyphicon glyphicon-heart" aria-hidden="true"></span> Like!
                                        </button>
                                    </div>
                                </div>

                                <p class="blog_news_content">Lorem ipsum dolor sit amet, consectetur adipscing elit.
                                    Lorem ipsum dolor sit amet, conse ctetur adipiscing elit. consectetur Lorem ipsum
                                    dolor sitamet, conse ctetur adipiscing elit. </p>
                                <a href="" class="blog_link">read more</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- One Feed -->
                <div class="col-md-4">
                    <div class="blog_news">
                        <div class="single_blog_item">
                            <div class="blog_img">
                                <img src="/resources/mainAsset/img/keion.jpg" alt="">
                            </div>
                            <div class="blog_content">
                                <a href="">
                                    <h3>けいおん！テスト！</h3>
                                </a>
                                <div class="expert">
                                    <div class="left-side text-left">
                                        <p class="left_side">
                                            <span class="clock"><i class="fa fa-clock-o"></i></span>
                                            <span class="time">2021.01.08</span>
                                            <a href=""><span class="admin"><i class="fa fa-user"></i> Aivyss</span></a>
                                        </p>
                                        <p class="right_side text-right">
                                            <a href=""><span class="right_msg text-right"><i
                                                        class="fa fa-comments-o"></i></span>
                                                <span class="count">+9999</span></a>
                                        </p>
                                        <button type="button" class="btn btn-default btn-sm">
                                            <span class="glyphicon glyphicon-heart" aria-hidden="true"></span> Like!
                                        </button>
                                    </div>
                                </div>

                                <p class="blog_news_content">Lorem ipsum dolor sit amet, consectetur adipscing elit.
                                    Lorem ipsum dolor sit amet, conse ctetur adipiscing elit. consectetur Lorem ipsum
                                    dolor sitamet, conse ctetur adipiscing elit. </p>
                                <a href="" class="blog_link">read more</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Feed set End -->
        </div>
        <!-- Intro 好みの絵 End -->


        <br><br><br>


        <!-- Intro Intro フォロワーの最近のフィード Start -->
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="latest_blog text-center">
                        <h2>フォロワーの最近のフィード</h2>
                        <p>あなたがフォローした人の作品です。</p>
                    </div>
                </div>
            </div>
            <!--End of row-->

            <!-- Feed set-->
            <div class="row">
                <!-- One Feed -->
                <div class="col-md-4">
                    <div class="blog_news">
                        <div class="single_blog_item">
                            <div class="blog_img">
                                <img src="/resources/mainAsset/img/keion.jpg" alt="">
                            </div>
                            <div class="blog_content">
                                <a href="">
                                    <h3>けいおん！テスト！</h3>
                                </a>
                                <div class="expert">
                                    <div class="left-side text-left">
                                        <p class="left_side">
                                            <span class="clock"><i class="fa fa-clock-o"></i></span>
                                            <span class="time">2021.01.08</span>
                                            <a href=""><span class="admin"><i class="fa fa-user"></i>
                                                    Aivyss</span></a>
                                        </p>
                                        <p class="right_side text-right">
                                            <a href=""><span class="right_msg text-right"><i
                                                        class="fa fa-comments-o"></i></span>
                                                <span class="count">+9999</span></a>
                                        </p>
                                        <button type="button" class="btn btn-default btn-sm">
                                            <span class="glyphicon glyphicon-heart" aria-hidden="true"></span> Like!
                                        </button>
                                    </div>
                                </div>

                                <p class="blog_news_content">Lorem ipsum dolor sit amet, consectetur adipscing elit.
                                    Lorem ipsum dolor sit amet, conse ctetur adipiscing elit. consectetur Lorem
                                    ipsum dolor sitamet, conse ctetur adipiscing elit. </p>
                                <a href="" class="blog_link">read more</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- One Feed -->
                <div class="col-md-4">
                    <div class="blog_news">
                        <div class="single_blog_item">
                            <div class="blog_img">
                                <img src="/resources/mainAsset/img/keion.jpg" alt="">
                            </div>
                            <div class="blog_content">
                                <a href="">
                                    <h3>けいおん！テスト！</h3>
                                </a>
                                <div class="expert">
                                    <div class="left-side text-left">
                                        <p class="left_side">
                                            <span class="clock"><i class="fa fa-clock-o"></i></span>
                                            <span class="time">2021.01.08</span>
                                            <a href=""><span class="admin"><i class="fa fa-user"></i>
                                                    Aivyss</span></a>
                                        </p>
                                        <p class="right_side text-right">
                                            <a href=""><span class="right_msg text-right"><i
                                                        class="fa fa-comments-o"></i></span>
                                                <span class="count">+9999</span></a>
                                        </p>
                                        <button type="button" class="btn btn-default btn-sm">
                                            <span class="glyphicon glyphicon-heart" aria-hidden="true"></span> Like!
                                        </button>
                                    </div>
                                </div>

                                <p class="blog_news_content">Lorem ipsum dolor sit amet, consectetur adipscing elit.
                                    Lorem ipsum dolor sit amet, conse ctetur adipiscing elit. consectetur Lorem
                                    ipsum dolor sitamet, conse ctetur adipiscing elit. </p>
                                <a href="" class="blog_link">read more</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- One Feed -->
                <div class="col-md-4">
                    <div class="blog_news">
                        <div class="single_blog_item">
                            <div class="blog_img">
                                <img src="/resources/mainAsset/img/keion.jpg" alt="">
                            </div>
                            <div class="blog_content">
                                <a href="">
                                    <h3>けいおん！テスト！</h3>
                                </a>
                                <div class="expert">
                                    <div class="left-side text-left">
                                        <p class="left_side">
                                            <span class="clock"><i class="fa fa-clock-o"></i></span>
                                            <span class="time">2021.01.08</span>
                                            <a href=""><span class="admin"><i class="fa fa-user"></i>
                                                    Aivyss</span></a>
                                        </p>
                                        <p class="right_side text-right">
                                            <a href=""><span class="right_msg text-right"><i
                                                        class="fa fa-comments-o"></i></span>
                                                <span class="count">+9999</span></a>
                                        </p>
                                        <button type="button" class="btn btn-default btn-sm">
                                            <span class="glyphicon glyphicon-heart" aria-hidden="true"></span> Like!
                                        </button>
                                    </div>
                                </div>

                                <p class="blog_news_content">Lorem ipsum dolor sit amet, consectetur adipscing elit.
                                    Lorem ipsum dolor sit amet, conse ctetur adipiscing elit. consectetur Lorem
                                    ipsum dolor sitamet, conse ctetur adipiscing elit. </p>
                                <a href="" class="blog_link">read more</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Feed set End -->
        </div>
        <!-- End of フォロワーの最近のフィード -->
    </section>

    <button id="message" title="Back to Top" class="show">message</button>













    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.min.js'></script>-->
    <script src="/resources/mainAsset/js/jquery-1.12.3.min.js"></script>

    <!--Counter UP Waypoint-->
    <script src="/resources/mainAsset/js/waypoints.min.js"></script>
    <!--Counter UP-->
    <script src="/resources/mainAsset/js/jquery.counterup.min.js"></script>

    <script>
        //for counter up
        $('.counter').counterUp({
            delay: 10,
            time: 1000
        });
    </script>

    <!--Isotope-->
    <script src="/resources/mainAsset/js/isotope/min/scripts-min.js"></script>
    <script src="/resources/mainAsset/js/isotope/cells-by-row.js"></script>
    <script src="/resources/mainAsset/js/isotope/isotope.pkgd.min.js"></script>
    <script src="/resources/mainAsset/js/isotope/packery-mode.pkgd.min.js"></script>
    <script src="/resources/mainAsset/js/isotope/scripts.js"></script>


    <!--Back To Top-->
    <script src="/resources/mainAsset/js/backtotop.js"></script>


    <!--JQuery Click to Scroll down with Menu-->
    <script src="/resources/mainAsset/js/jquery.localScroll.min.js"></script>
    <script src="/resources/mainAsset/js/jquery.scrollTo.min.js"></script>
    <!--WOW With Animation-->
    <script src="/resources/mainAsset/js/wow.min.js"></script>
    <!--WOW Activated-->
    <script>
        new WOW().init();
    </script>


    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="/resources/mainAsset/js/bootstrap.min.js"></script>
    <!-- Custom JavaScript-->
    <script src="/resources/mainAsset/js/main.js"></script>
</body>

</html>