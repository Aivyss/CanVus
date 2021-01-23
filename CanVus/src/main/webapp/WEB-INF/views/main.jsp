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

    
    <!--Bootstrap Carousel-->
    <link type="text/css" rel="stylesheet" href="/resources/mainAsset/css/carousel.css" />

    <link rel="stylesheet" href="/resources/mainAsset/css/isotope/style.css">

    
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
    <jsp:include page="mainMenu.jsp"></jsp:include>

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


   
    <!-- Custom JavaScript-->
    <script src="/resources/mainAsset/js/main.js"></script>
</body>

</html>