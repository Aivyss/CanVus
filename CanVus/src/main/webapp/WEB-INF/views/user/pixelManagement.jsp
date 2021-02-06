<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>픽셀관리창</title>
<meta charset="UTF-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
 
	<link rel="stylesheet" href="/resources/js/style.css">
	<%-- <jsp:include page="/WEB-INF/views/header.jsp"></jsp:include> --%>
	<script src="/resources/js/Classic/Color.Picker.Classic.js" type="text/javascript"></script> 
	<script src="/resources/js/Classic/Color.Space.js" type="text/javascript"></script> 
	<script src="/resources/js/Classic/viewpalette.js"></script>
	<script src="/resources/js/fabric/dist/fabric.js"></script>
	<!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>	<!-- <script src="node_modules/fabric-history/src/index.js"></script> -->
	
	<script type="text/javascript">
	$(document).ready(function(){
		
		$('ul.tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');

			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');

			$(this).addClass('current');
			$("#"+tab_id).addClass('current');
		});

		/* $(".brush").click(function(){
			$(".spray").css({
				"display": "block"
				
			});
			
		}); */
		
		 var currlayers=1;
		 
         $("#makebtn").click(function(){
             if(currlayers==5){
                alert("레이어는 최대 5개까지 생성 가능합니다");
                 return false;
             }else{
                currlayers+=1;
             }
             var dynamicTag = $('<div style="float:left;"><button class="layers'+currlayers+'">layer'+currlayers+'</button></div>').addClass('new');
             var dynamicTag2 = $('<div><button class="hidelayers'+currlayers+'">hidelayer'+currlayers+'</button></div>').addClass('new');
             $('.tool').append(dynamicTag);
             $('.tool').append(dynamicTag2);
            
             if(currlayers==2){
                 
             $(document).on("click",".layers"+currlayers,function(){
                $(".layers2").click(function(){
                         $(".layer2").css({"z-index": current,"opacity": "1"});
                      });
               })
               
            $(document).on("click",".hidelayers"+currlayers,function(){
                $(".hidelayers2").click(function(){
                         $(".layer2").css({"z-index": "1","opacity": "0"});
                      });
               })
            }

             if(currlayers==3){
                 $(document).on("click",".layers"+currlayers,function(){
                    $(".layers3").click(function(){
                             $(".layer3").css({"z-index": current,"opacity": "1"});
                          });
                        
                   })
                   $(document).on("click",".hidelayers"+currlayers,function(){
                $(".hidelayers3").click(function(){
                         $(".layer3").css({"z-index": "1","opacity": "0"});
                      });
               })
             }
             
             if(currlayers==4){
                 $(document).on("click",".layers"+currlayers,function(){
                    $(".layers4").click(function(){
                             $(".layer4").css({"z-index": current,"opacity": "1"});
                          });
                        
                   })
                   $(document).on("click",".hidelayers"+currlayers,function(){
                $(".hidelayers4").click(function(){
                         $(".layer4").css({"z-index": "1","opacity": "0"});
                      });
               })
                }
              
             if(currlayers==5){
                 $(document).on("click",".layers"+currlayers,function(){
                    $(".layers5").click(function(){
                             $(".layer5").css({"z-index": current,"opacity": "1"});
                          });
                        
                   })
                   $(document).on("click",".hidelayers"+currlayers,function(){
                $(".hidelayers5").click(function(){
                         $(".layer5").css({"z-index": "1","opacity": "0"});
                      });
               })
                }

          }); 

	     var current=1;
	
	     $(".layers1").click(function(){
	     current+=1;
	        $(".layer1").css({
	           "z-index": current,
	           "opacity": "1"
	        });
	
	     });
	
	     $(".hidelayers1").click(function(){
	         $(".layer1").css({"z-index": "1","opacity": "0"});
	      });

	     $("#moveLayer").click(function(){
	    	 $('.layer1').draggable(); 
		 });

	     $('.layer1').mouseup(function(){
	    
	    	 $('.layer1').draggable("destroy"); 
		 });
		
		

	});
	</script>
<style type="text/css">
/* body{
margin-top: 100px;
font-family: 'Trebuchet MS', serif;
line-height: 1.6
} */

.toolBar{
	display: inline-block;
	margin: 10px;
	top: 0;
	left: 0;
}

.tool{
	
}

.brush{
	display: inline-block;
}

.tool_brush{
	display: none;
}


.rangeBar{
	display: inline-block;
	
}

.range{
	/* -webkit-appearance: slider-vertical; */
	/* transform: rotate(270deg); */
	margin: 0px;
}

.layer1{
   position: absolute;
   z-index: 1;
}

.layer2{
   position: absolute;
   z-index: 0;
   opacity: 0;
}

.layer3{
   position: absolute;
   z-index: 0;
   opacity: 0;
}

.layer4{
   position: absolute;
   z-index: 0;
   opacity: 0;
}

.layer5{
   position: absolute;
   z-index: 0;
   opacity: 0;
}

#container{
	
	margin: 0 auto;
	display: inline-block;
	position: absolute;
}

ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	background: #ededed;
	color: #222;
}

.tab-content{
	display: none;
	background: #ededed;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}
</style>
  
</head>
<body>
	<jsp:include page="/WEB-INF/views/mainMenu.jsp"></jsp:include>
	
	<!-- 툴 텝 시작 -->
	<div class="toolBar" id="test">
		<div>Drawing Page</div>
		<span>CanVus</span>
		<a>올리기</a>
		<a>저장</a>
		<a>뒤로</a>
		<a>앞으로</a>
		<div class="tool">
			<div>
			<button class="brush">브러쉬</button>
			</div>
			<div>
				<button id="selection">selection</button>
			</div>
			<div>
				<button id="moveLayer">moveLayer</button>
			</div>
			<div>
         <button style="float:left;" class="layers1">layer1</button>
         </div>
         <div>
         <button class="hidelayers1">hidelayer1</button>
         </div>
			
		</div>
		
		<div class="tool_brush">
			<div>
				<input type="button" value="스프레이" onclick="sprayBrush();">
			</div>	
			<div>
				<input type="button" value="써클" onclick="circleBrush();">
			</div>
			<div>
				<input type="button" value="패턴" onclick="patternBrush();">
			</div>
			<div>
				<input type="button" value="연필" onclick="pencilBrush();">
			</div>	
		</div>
		<div class="rangeBar">
	      <input type="range" max="1" min="0.1" step="0.05" value="1" id="opacity" class="range">
	    </div>
	    <div class="rangeBar">
	      <input type="range" max="30" min="1" step="1" value="5" id="thickness" class="range">
	    </div>  
	</div>
	<!-- 툴 텝 끝 -->
	
	<!-- page 텝 시작-->
	<div class="container" id="container">
		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1">page1</li>
			<li class="tab-link" data-tab="tab-2">page2</li>
			<li class="tab-link" data-tab="tab-3">page3</li>
		</ul>
		
		<div id="tab-1" class="tab-content current">
			<div class="set">
			    <div class="layers">
			    	<input type="button" id="makebtn" value="레이어추가"/>
			    	<div class="layer1">
                   <canvas class="canvas" id="canvas" width="1000" height="600"></canvas>
              	</div>
				<div class="layer2">
                   <canvas class="canvas" id="canvas2" width="1000" height="600"></canvas>
              	</div>
              	<div class="layer3">
                   <canvas class="canvas" id="canvas3" width="1000" height="600"></canvas>
              	</div>
              	<div class="layer4">
                   <canvas class="canvas" id="canvas4" width="1000" height="600"></canvas>
              	</div>
              	<div class="layer5">
                   <canvas class="canvas" id="canvas5" width="1000" height="600"></canvas>
              	</div>
              	

			    </div>
			    <div class="buttons">
			      <button id="eraser">eraser</button>
			      <button id="drawer">drawer</button>
			      <button id="red">펜</button>
			      <!-- <input type="button" value="펜" onclick="baseBrush();"> -->
			      <input type="button" value="스프레이" onclick="sprayBrush();">
			      <input type="button" value="써클" onclick="circleBrush();">
			      <input type="button" value="패턴" onclick="patternBrush();">
			      <input type="button" value="연필" onclick="PencilBrush();">
			      <!-- <input type="button" value="히스토리" onclick="getHistory();"> -->
			      <button id="selection">selection</button>
			      <!-- <button id="stringify">stringify</button>
			      <button id="removal">removal</button>
			      <button id="recover">recover</button> -->  
			    </div>

			</div>

			  </div>

		</div>
		<div id="tab-2" class="tab-content">		
		</div>
		<div id="tab-3" class="tab-content">
		</div>
	
  	<script src="/resources/js/drawingApp.js"></script>
	<!-- page 텝 끝-->
	
	<!-- <div class="set">
    <div class="layers">
    <canvas class="background" width="400" height="400"></canvas>
    <canvas class="canvas" id="canvas" width="400" height="400"></canvas>
    </div>
    <div class="buttons">
      <button id="eraser">eraser</button>
      <button id="drawer">drawer</button>
      <button id="red">red</button>
      <input type="button" value="패턴변화" onclick="changeBrush();">
      <input type="button" value="히스토리" onclick="getHistory();">
      <button id="selection">selection</button>
      <button id="stringify">stringify</button>
      <button id="removal">removal</button>
      <button id="recover">recover</button>
    </div>
    <div class="rangeBar">
      <input type="range" max="1" min="0.1" step="0.05" value="1" id="opacity">
      <input type="range" max="30" min="1" step="1" value="5" id="thickness">
    </div>  
  </div>
  <script src="/resources/js/drawingApp.js"></script> -->
</body>
</html>