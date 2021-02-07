<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.navbar-default .navbar-nav>li>div>button {
    color: #777;
}

#searchbar{
	position: absolute;
	margin-top :25px;
	width:30%;
	left: 200px;
}
</style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Menu</title>

    <!-- Bootstrap -->
    <link href="/resources/mainAsset/css/bootstrap.min.css" rel="stylesheet">
   
    <!--Main Stylesheet-->
    <link href="/resources/mainAsset/css/style.css" rel="stylesheet">
 

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
                                <a class="navbar-brand custom_navbar-brand" href="#">
                                	<img src="/resources/mainAsset/img/CanVus.png" alt="">
                                </a>                                                		                            		                       
		                            <div class="input-group navbar-collapse" id="searchbar">
		                                <span class="input-group-btn">
		                                    <button class="btn btn-default" type="button" onclick="searchResult();">Go!</button>
		                                </span>
		                                <input type="text" class="form-control" placeholder="Search for..." id="searchText">
		                            </div><!-- /input-group -->
		                   </div>
		                       
		                   

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
										  <form class="px-4 py-3 " style ="width: 350px;" action="/drawing/createRoom" method="post">
										    <div class="form-group" style ="padding: 10px 10px 0 10px;">
										      <label for="exampleDropdownFormTitle">Title</label>
										      <input type="text" class="form-control" id="exampleDropdownFormTitle" name="title" placeholder="write the title">
										    </div>
										    <div class="form-group" style ="padding: 10px 10px 0 10px;">
										      <label for="exampleDropdownFormPassword1">Password</label>
										      <input type="password" class="form-control" id="exampleDropdownFormPassword" name="password" placeholder="Password">
										    </div>
										   <div class="form-group" style ="padding: 10px 10px 0 10px;">
										      <label for="exampleDropdownFormPassword1">No.Ppl</label>
										      <input type="text" class="form-control" id="exampleDropdownFormNumberOfPpl" name="user_no" placeholder="write capacity of the room">
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
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.min.js'></script>-->
    <!-- <script src="/resources/mainAsset/js/jquery-1.12.3.min.js"></script> -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="/resources/mainAsset/js/bootstrap.min.js"></script>
    
</body>
</html>