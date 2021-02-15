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
   <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
   <%-- <jsp:include page="/WEB-INF/views/header.jsp"></jsp:include> --%>
   <script src="/resources/js/Classic/Color.Picker.Classic.js" type="text/javascript"></script> 
   <script src="/resources/js/Classic/Color.Space.js" type="text/javascript"></script> 
   <script src="/resources/js/Classic/viewpalette.js"></script>
   <script src="/resources/js/fabric/dist/fabric.js"></script>
   <!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->
   <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>   <!-- <script src="node_modules/fabric-history/src/index.js"></script> -->

	<script type="text/javascript">
   $(document).ready(function(){


	   
      // 캔버스 페이지 기능
      
      $('ul.tabs li').click(function(){
         var tab_id = $(this).attr('data-tab');

         $('ul.tabs li').removeClass('current');
         $('.tab-content').removeClass('current');

         $(this).addClass('current');
         $("#"+tab_id).addClass('current');
      });

<<<<<<< HEAD
       $(".brush").click(function(){
         $(".tool_brush").css({
            "display": "block"
            
         });
         
      });

       
    // 오른쪽 사이드바 페이지기능
    
       $(function(){
           $(".tab ul li").click(function(){ 
               $(".tab ul li").removeClass('on');
               $(".tab .conBox").removeClass('on');
               $(this).addClass('on');
               $("#"+$(this).data('id')).addClass('on');
           });
       });

       
      // 레이어 추가,숨김,삭제기능
      // 되긴하는데 지금 엄청 대충만든상태고 하드코딩한거
=======
      $(".brush").click(function(){
         $(".tool_brush").css({
            "display": "block"
         }); 
      });
>>>>>>> main
      
       var currlayers=1;
       var layerstotal=1;
       
         $("#makebtn").click(function(){
             if(layerstotal==5){
                alert("레이어는 최대 5개까지 생성 가능합니다");
                 return false;
             }else{
                currlayers+=1;
                layerstotal+=1;
             }
             
             var dynamicTag = $('<div style="float:left;"><button class="layers'+currlayers+'">layer'+currlayers+'</button></div>').addClass('new');
             var dynamicTag2 = $('<div style="float:left;"><button class="hidelayers'+currlayers+'">hidelayer'+currlayers+'</button></div>').addClass('new');
             var dynamicTag3 = $('<div><button class="deletelayers'+currlayers+'">deletelayer'+currlayers+'</button></div>').addClass('new');
             $('.tool').append(dynamicTag);
             $('.tool').append(dynamicTag2);
             $('.tool').append(dynamicTag3);
            
             if(currlayers==2){
                 
             $(document).on("click",".layers"+currlayers,function(){
                $(".layers2").click(function(){
                         $(".layer2").css({"z-index": current,"opacity": "1"});
                         $(".layers2").css({
                             "color": "red",
                             "border": "2px solid red",
                          });
                         $(".hidelayers2").css({
                             "color": "black",
                             "border": "2px solid black",
                          });
                      });
               })
               
            $(document).on("click",".hidelayers"+currlayers,function(){
                $(".hidelayers2").click(function(){
                         $(".layer2").css({"z-index": "1","opacity": "0"});
                         $(".layers2").css({
                             "color": "black",
                             "border": "2px solid black",
                          });
                        $(".hidelayers2").css({
                             "color": "red",
                             "border": "2px solid red",
                          });
                      });
               })
               
               $(document).on("click",".deletelayers"+currlayers,function(){
                $(".deletelayers2").click(function(){
                      $(".layer2").css({"z-index": "1","opacity": "0"});
                         $(".layers2").remove();
                         $(".hidelayers2").remove();
                         $(".deletelayers2").remove();
                         layerstotal-=1;
                      });
               })
            }

             if(currlayers==3){
                 $(document).on("click",".layers"+currlayers,function(){
                    $(".layers3").click(function(){
                             $(".layer3").css({"z-index": current,"opacity": "1"});
                             $(".layers3").css({
                                 "color": "red",
                                 "border": "2px solid red",
                              });
                             $(".hidelayers3").css({
                                 "color": "black",
                                 "border": "2px solid black",
                              });
                          });
                        
                   })
                   $(document).on("click",".hidelayers"+currlayers,function(){
                $(".hidelayers3").click(function(){
                         $(".layer3").css({"z-index": "1","opacity": "0"});
                         $(".layers3").css({
                             "color": "black",
                             "border": "2px solid black",
                          });
                        $(".hidelayers3").css({
                             "color": "red",
                             "border": "2px solid red",
                          });
                      });
               })
               $(document).on("click",".deletelayers"+currlayers,function(){
                $(".deletelayers3").click(function(){
                      $(".layer3").css({"z-index": "1","opacity": "0"});
                         $(".layers3").remove();
                         $(".hidelayers3").remove();
                         $(".deletelayers3").remove();
                         layerstotal-=1;
                      });
               })
             }
             
             if(currlayers==4){
                 $(document).on("click",".layers"+currlayers,function(){
                    $(".layers4").click(function(){
                             $(".layer4").css({"z-index": current,"opacity": "1"});
                             $(".layers4").css({
                                 "color": "red",
                                 "border": "2px solid red",
                              });
                             $(".hidelayers4").css({
                                 "color": "black",
                                 "border": "2px solid black",
                              });
                          });
                        
                   })
                   $(document).on("click",".hidelayers"+currlayers,function(){
                $(".hidelayers4").click(function(){
                         $(".layer4").css({"z-index": "1","opacity": "0"});
                         $(".layers4").css({
                             "color": "black",
                             "border": "2px solid black",
                          });
                        $(".hidelayers4").css({
                             "color": "red",
                             "border": "2px solid red",
                          });
                      });
               })
               $(document).on("click",".deletelayers"+currlayers,function(){
                $(".deletelayers4").click(function(){
                      $(".layer4").css({"z-index": "1","opacity": "0"});
                       $(".layers4").remove();
                         $(".hidelayers4").remove();
                         $(".deletelayers4").remove();
                         layerstotal-=1;
                      });
               })
                }
              
             if(currlayers==5){
                 $(document).on("click",".layers"+currlayers,function(){
                    $(".layers5").click(function(){
                             $(".layer5").css({"z-index": current,"opacity": "1"});
                             $(".layers5").css({
                                 "color": "red",
                                 "border": "2px solid red",
                              });
                             $(".hidelayers5").css({
                                 "color": "black",
                                 "border": "2px solid black",
                              });
                          });
                        
                   })
                   $(document).on("click",".hidelayers"+currlayers,function(){
                $(".hidelayers5").click(function(){
                         $(".layer5").css({"z-index": "1","opacity": "0"});
                         $(".layers5").css({
                             "color": "black",
                             "border": "2px solid black",
                          });
                     	$(".hidelayers5").css({
                             "color": "red",
                             "border": "2px solid red",
                          });
                      });
               })
               $(document).on("click",".deletelayers"+currlayers,function(){
                $(".deletelayers5").click(function(){
                      $(".layer5").css({"z-index": "1","opacity": "0"});
                         $(".layers5").remove();
                         $(".hidelayers5").remove();
                         $(".deletelayers5").remove();
                         layerstotal-=1;
                      });
               })
                }

          }); 

        var current=1;
   
        $(".layers1").click(function(){
        current+=1;
        $(".layers1").css({
            "color": "red",
            "border": "2px solid red",
         });
        $(".hidelayers1").css({
            "color": "black",
            "border": "2px solid black",
         });
           $(".layer1").css({
              "z-index": current,
              "opacity": "1"
           });
   
        });
   
        $(".hidelayers1").click(function(){
           $(".layers1").css({
                "color": "black",
                "border": "2px solid black",
             });
           $(".hidelayers1").css({
                "color": "red",
                "border": "2px solid red",
             });
            $(".layer1").css({"z-index": "1","opacity": "0"});
         });
        
        $(".deletelayers1").click(function(){
          $(".layer1").css({"z-index": "1","opacity": "0"});
             $(".layers1_1").remove();
             $(".hidelayers1_1").remove();
             $(".deletelayers1_1").remove();
             layerstotal-=1;
          });
        
        $("#moveLayer").click(function(){
            $('.layers').draggable();
            
        });

        $('.layers').mouseup(function(){
            $('.layers').draggable("destroy"); 
		});

		$('#addItem').click(function(){
			$('.layers').append('<div><canvas class="canvas" id="canvas" width="1000" height="600"></canvas></div>');
		});

      // 휠 확대 기능
      // alt+클릭으로 캔버스 이동가능
      
         canvas.on('mouse:wheel', function(opt) {
      	   var delta = opt.e.deltaY;
      	   var zoom = canvas.getZoom();
      	   zoom *= 0.999 ** delta;
      	   if (zoom > 20) zoom = 20;
      	   if (zoom < 0.01) zoom = 0.01;
      	   canvas.setZoom(zoom);
      	   opt.e.preventDefault();
      	   opt.e.stopPropagation();
      	 })

      	canvas.on('mouse:down', function(opt) {
      	  var evt = opt.e;
      	  if (evt.altKey === true) {
      	    this.isDragging = true;
      	    this.selection = false;
      	    this.lastPosX = evt.clientX;
      	    this.lastPosY = evt.clientY;
      	  }
      	});
      	canvas.on('mouse:move', function(opt) {
      	  if (this.isDragging) {
      	    var e = opt.e;
      	    var vpt = this.viewportTransform;
      	    vpt[4] += e.clientX - this.lastPosX;
      	    vpt[5] += e.clientY - this.lastPosY;
      	    this.requestRenderAll();
      	    this.lastPosX = e.clientX;
      	    this.lastPosY = e.clientY;
      	  }
      	});
     
      	canvas.on('mouse:up', function(opt) {
      	  // on mouse up we want to recalculate new interaction
      	  // for all objects, so we call setViewportTransform
      	  this.setViewportTransform(this.viewportTransform);
      	  this.isDragging = false;
      	  this.selection = true;
      	});

     
		// 오른쪽 사이드바 접었다폈다 해주는애

      	$(".button-div").click(function(){
      	  
      	  $(this).toggleClass("div-close");
      	  
      	  if ($(this).hasClass("div-close")) {
      	    $(".slide-div").animate({ left: "-200px"}, 800);  
      	    $(".button-div").animate({ left: "-10px"}, 800);
      	    $(this).find(".button-open").attr("class", "button-close");
      	  } else {
      	    $(".slide-div").animate({ left: "0px"}, 800);  
      	    $(".button-div").animate({ left: "200px"}, 800);
      	    $(this).find(".button-close").attr("class", "button-open");
      	  }
      	});

      	
		// 캔버스 배경색 변경하는 기능

      	// canvas.backgroundColor = 'white'; <-이거는 처음배경색지정
        // canvas.renderAll();
        $('#bg_color').on('input', function() { 
        	canvas.backgroundColor = $('#bg_color').val();
        	canvas.renderAll();
        });

    	// 입력한대로 텍스트박스 추가해주는 기능
    	
		$('#btn_add_new').click(function(e) {
	        e.preventDefault();
	        if($('#new_text').val() !== '')
	        {
		        var newText = new fabric.IText($('#new_text').val(), { 
		            fontFamily: "Arial", 
		            left: 50,
		            top: 50,
		            fontSize: 30,
		            textAlign: "left",
		            fill: 'black',
		        });
		        canvas.add(newText);
		        
	        }
	    });
	    

	    // 텍스트박스 꾸미기 기능들 (색깔, 크기 글자배경색 etc)
	    // 불안정함. 뭔 이윤지 모르겠는데 바로 안 바뀌고 글자 크기를 바꾸면 그제서야 적용되고 그럼
		    
		function setStyle(object, styleName, value) {
		    if (object.setSelectionStyles && object.isEditing) {
		        var style = { };
		        style[styleName] = value;
		        object.setSelectionStyles(style).setCoords();
		    }
		    else {
		        object[styleName] = value;
		    }
		    canvas.renderAll();
		};
		
		function  getStyle(object, styleName) {
		    return (object.getSelectionStyles && object.isEditing)
		    ? object.getSelectionStyles()[styleName]
		    : object[styleName];
		}
		
		function addHandler(id, fn, eventName) {
		    document.getElementById(id)[eventName || 'onclick'] = function() {
		        var el = this;
		        if (obj = canvas.getActiveObject()) {
		            fn.call(el, obj);
		            canvas.renderAll();
		        }
		    };
		}


		addHandler('color', function(obj) {
		      setStyle(obj, 'fill', this.value);
		    }, 'onchange');

		addHandler('opacity', function(obj) {
		      setStyle(obj, 'opacity', this.value);
		    }, 'onchange');
		    
		addHandler('font-family', function(obj) {
		      setStyle(obj, 'fontFamily', this.value);
		    }, 'onchange');
		    
		addHandler('text-align', function(obj) {
		      setStyle(obj, 'textAlign', this.value);
		    }, 'onchange');
		    
		addHandler('text-bg-color', function(obj) {
		      setStyle(obj, 'textBackgroundColor', this.value);
		    }, 'onchange');
		    
		addHandler('text-lines-bg-color', function(obj) {
		      setStyle(obj, 'backgroundColor', this.value);
		    }, 'onchange');
		    
		addHandler('text-stroke-color', function(obj) {
		      setStyle(obj, 'stroke', this.value);
		    }, 'onchange');
		    
		addHandler('text-stroke-width', function(obj) {
		      setStyle(obj, 'strokeWidth', this.value);
		    }, 'onchange');
		    
		addHandler('text-font-size', function(obj) {
		      setStyle(obj, 'fontSize', this.value);
		    }, 'onchange');
		    
		addHandler('text-line-height', function(obj) {
		      setStyle(obj, 'lineHeight', this.value);
		    }, 'onchange');
		    
		addHandler('text-cmd-bold', function(obj) {
		      setStyle(obj, 'fontWeight', this.value);
		    }, 'onchange');
		    
		addHandler('text-cmd-italic', function(obj) {
		      setStyle(obj, 'italic', this.value);
		    }, 'onchange');
		    
		addHandler('text-cmd-underline"', function(obj) {
		      setStyle(obj, 'underline', this.value);
		    }, 'onchange');
		    
		addHandler('text-cmd-linethrough', function(obj) {
		      setStyle(obj, 'line-through', this.value);
		    }, 'onchange');
		    
		addHandler('text-cmd-overline', function(obj) {
		      setStyle(obj, 'overline', this.value);
		    }, 'onchange');




	    
		// 텍스트 굵게,기울게,밑줄 함수 - 뭔 이유인지 모르겠는데 작동안함
		
		var underline = document.getElementById('btn-underline');
		var bold = document.getElementById('btn-bold');
		var italic = document.getElementById('btn-italic');

		underline.addEventListener('click', function() {
		  dtEditText('underline');
		});

		bold.addEventListener('click', function() {
		  dtEditText('bold');
		}); 

		italic.addEventListener('click', function() {
		  dtEditText('italic');
		}); 

		function dtEditText(action) {
		    var a = action;
		    var o = canvas.getActiveObject();
		    var t;

		    // If object selected, what type?
		    if (o) {
		        t = o.get('type');
		    }

		    if (o && t === 'i-text') {
		        switch(a) {
		            case 'bold':				
		                var isBold = dtGetStyle(o, 'fontWeight') === 'bold';
		                dtSetStyle(o, 'fontWeight', isBold ? '' : 'bold');
		            break;

		            case 'italic':
		                var isItalic = dtGetStyle(o, 'fontStyle') === 'italic';
		                dtSetStyle(o, 'fontStyle', isItalic ? '' : 'italic');
		            break;

		            case 'underline':
		                var isUnderline = dtGetStyle(o, 'textDecoration') === 'underline';
		                dtSetStyle(o, 'textDecoration', isUnderline ? '' : 'underline');
		            break;
		            canvas.renderAll();
		        }
		    }
		}

		// Get the style
		function dtGetStyle(object, styleName) {
		    return object[styleName];
		}

		// Set the style
		function dtSetStyle(object, styleName, value) {
		    object[styleName] = value;
		    object.set({dirty: true});
		    canvas.renderAll();
		}

   });

<<<<<<< HEAD
	// undo, redo 펑션 / 근데 뺀다고함 ㅋㅋ
	
   var canvas = new fabric.Canvas('canvas');
 	canvas.isDrawingMode = true;
 	canvas.on('object:added',function(){
 	  if(!isRedoing){
 	    h = [];
 	  }
 	  isRedoing = false;
 	});

 	var isRedoing = false;
 	var h = [];
 	function undo(){
 	  if(canvas._objects.length>0){
 	   h.push(canvas._objects.pop());
 	   canvas.renderAll();
 	  }
 	}
 	function redo(){
 	  
 	  if(h.length>0){
 	    isRedoing = true;
 	   canvas.add(h.pop());
 	  }
 	}

 
 	// 'Tap and Type'라는 텍스트박스 추가해주는 버튼 함수

 	function Addtext() { 
 	canvas.add(new fabric.IText('Tap and Type', { 
 	      left: 50,
 	      top: 100,
 	      fontFamily: 'arial black',
 	      fill: '#333',
 		    fontSize: 50
 	}));
 	}

	// 페이지 클리어 (근데 이거 새로고침이랑 똑같음ㅋㅋ)
	
 	function refresh() {
 	   setTimeout(function() {
 	      location.reload()
 	   }, 100);
 	}

	
</script>
   
=======
   /** UI 설정 및 드래그로 순서 변경 기능 */
   $(function() {
       $("#itemBoxWrap").sortable({
           placeholder:"itemBoxHighlight",
           start: function(event, ui) {
               ui.item.data('start_pos', ui.item.index());
           },
           stop: function(event, ui) {
               var spos = ui.item.data('start_pos');
               var epos = ui.item.index();
   			      reorder();
           }
       });
       //$("#itemBoxWrap").disableSelection();
       
       //$( "#sortable" ).sortable();
       //$( "#sortable" ).disableSelection();
   });

   /** 레이어 번호 조정 */
   function reorder() {
       $(".itemBox").each(function(i, box) {
           $(box).find(".itemNum").html(i + 1);
       });
   }

   /** 레이어 추가 */
   function createItem() {
       $(createBox())
       .appendTo("#itemBoxWrap")
       
       .hover(
           function() {
               $(this).css('backgroundColor', '#f9f9f5');
               $(this).find('.deleteBox').show();
           },
           function() {
               $(this).css('background', 'none');
               $(this).find('.deleteBox').hide();
           }
       )
   		.append("<div class='deleteBox'>[삭제]</div>")
   		.find(".deleteBox").click(function() {
           var valueCheck = false;
           $(this).parent().find('input').each(function() {
               if($(this).attr("name") != "type" && $(this).val() != '') {
                   valueCheck = true;
               }
           });

           if(valueCheck) {
               var delCheck = confirm('입력하신 내용이 있습니다.\n삭제하시겠습니까?');
           }
           if(!valueCheck || delCheck == true) {
               $(this).parent().remove();
               reorder();
           }
       });
       // 레이어 번호를 다시 정렬한다.
       reorder();
   }

   /** 레이어 이름 작성 */
   function createBox() {
       var contents = "<div class='itemBox'>"
                    + "<div style='float:left;'>"
                    + "<span class='itemNum'></span> "
                    + "<input type='text' name='item' style='width:150px;'/>"
                    + "</div>"
                    + "</div>";
       return contents;
   }
   </script>
>>>>>>> main
<style type="text/css">
/* body{
margin-top: 100px;
font-family: 'Trebuchet MS', serif;
line-height: 1.6
} */

.toolBar{
	position: relative;
   display: inline-block;
   margin: 10px;
   top: 0;
   left: 0;
   height:1000px;
   width:250px;
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

.itemBox {
    border:solid 1px black;
    width:250px;
    height:40px;
    padding:5px;
    margin-bottom:5px;
}
.itemBoxHighlight {
    border:solid 1px black;
    width:250px;
    height:40px;
    padding:10px;
    margin-bottom:10px;
    background-color:gray;
}
.deleteBox {
    float:right;
    display:none;
    cursor:pointer;
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

.tab{
    width:200px;
    height:auto;
    overflow:hidden;
}
 
.tab ul{
    padding:0;
    margin:0;
    list-style:none;
    width:100%:
    height:auto;
    overflow:hidden;
}
 
.tab ul li{
    display:inline-block;
    width:33.3333%;
    float:left;
    line-height:40px;
    text-align:center;
    cursor:pointer;
}
 
.tab ul li:hover,
.tab ul li.on{
    background:#50bcdf;
}
 
.tab .conBox{
    width:100%;
    height:auto;
    overflow:hidden;
    width: 270px;
    min-height:200px;
    background:#50bcdf;
    display:none;
    text-align:center;
    border:2px solid black;
}
 
.tab .conBox.on{
    display:block;
}

.slide-div {
  position: absolute;
  left: 0px;
  top: 10px;
  width: 270px;
  height: 300px;
  background: grey;
}

.button-div {
  position: absolute;
  left: 200px;
  top: 30px;
  width: 70px;
  height: 50px;
  background: #17b0af;
}

.button-open {
  width: 0px;
  height: 0px;
  border-top: 10px solid transparent;
  border-right: 20px solid #0f304e;
  border-bottom: 10px solid transparent;
  margin: 15px 40px;
}

.button-close {
  width: 0px;
  height: 0px;
  border-top: 10px solid transparent;
  border-left: 20px solid #0f304e;
  border-bottom: 10px solid transparent;
  margin: 15px 40px;
}

.box {
  float: left;
  margin: 1em;
}
.after-box {
  clear: left;
}

</style>
  
</head>
<body>
   <jsp:include page="/WEB-INF/views/mainMenu.jsp"></jsp:include>
   
   <!-- 툴 텝 시작 -->
   
   
   <div class="toolBar" id="test">
   
   <div class="slide-div">
	
	
    <div class="tab">
    <ul>
        <li data-id="con1" class="on">그리기 툴</li>
        <li data-id="con2">채팅</li>
        <li data-id="con3">멤버</li>
    </ul>
    <div id="con1" class="conBox on">

      <br>
      <div>Drawing Page</div>
      <span>CanVus</span>
      <hr width = "100%">
      <a>올리기</a><br>
      <a>저장</a><br>
      <button onclick="refresh()">Clear All</button>
      <hr width = "100%">
      <div class="tool">
         <input type="button" value="undo" onclick="javascript:undo();">
         <input type="button" value="redo" onclick="javascript:redo();">
         <br><br>
         
         

         
         <button onclick="Addtext()">Add Text</button><br><br>
         
      		
      		
      	

    <div class="container" style="padding: 0px;width: 100%;">

      <div class="starter-template">
	      <div>
	      	<div>
	      		<div>
		      		<div>
		      		<div>
						<button id="btn-underline">Underline Toggle</button>
						<button id="btn-bold">Bold Toggle</button>
						<button id="btn-italic">Italic Toggle</button> 
					</div>
		      			Background Color
		      		</div>
		      		<div>
		      			<input type="color" id="bg_color">
		      		</div>
		      		<div>
	      				<input type="text" id="new_text" class="form-control" placeholder="Add new text here">
		      		</div>
		      		<div>
	      				<input type="button" id="btn_add_new" class="btn btn-primary" value="Add New Text">
		      		</div>
		      	</div>
		      
	      	</div>
	      </div>
      </div>
    </div>
      
      
      <div id="text-controls">
    	 <label for="opacity">Opacity: </label>
    <input value="100" type="range" bind-value-to="opacity" id="opacity">
	  <input type="color" value="" id="color" size="10">
      <label for="font-family" style="display:inline-block">Font family:</label>
      <select id="font-family">
        <option value="arial">Arial</option>
        <option value="helvetica" selected>Helvetica</option>
        <option value="myriad pro">Myriad Pro</option>
        <option value="delicious">Delicious</option>
        <option value="verdana">Verdana</option>
        <option value="georgia">Georgia</option>
        <option value="courier">Courier</option>
        <option value="comic sans ms">Comic Sans MS</option>
        <option value="impact">Impact</option>
        <option value="monaco">Monaco</option>
        <option value="optima">Optima</option>
        <option value="hoefler text">Hoefler Text</option>
        <option value="plaster">Plaster</option>
        <option value="engagement">Engagement</option>
      </select>
      <br>
      <label for="text-align" style="display:inline-block">Text align:</label>
      <select id="text-align">
        <option value="left">Left</option>
        <option value="center">Center</option>
        <option value="right">Right</option>
        <option value="justify">Justify</option>
      </select>
      <div>
        <label for="text-bg-color">Background color:</label>
        <input type="color" value="" id="text-bg-color" size="10">
      </div>
      <div>
        <label for="text-lines-bg-color">Background text color:</label>
        <input type="color" value="" id="text-lines-bg-color" size="10">
      </div>
      <div>
        <label for="text-stroke-color">Stroke color:</label>
        <input type="color" value="" id="text-stroke-color">
      </div>
      <div>
	  

        <label for="text-stroke-width">Stroke width:</label>
        <input type="range" value="1" min="1" max="5" id="text-stroke-width">
      </div>
      <div>
        <label for="text-font-size">Font size:</label>
        <input type="range" value="" min="1" max="120" step="1" id="text-font-size">
      </div>
      <div>
        <label for="text-line-height">Line height:</label>
        <input type="range" value="" min="0" max="10" step="0.1" id="text-line-height">
      </div>
    </div>
    <div id="text-controls-additional">
      <input type='checkbox' name='fonttype' id="text-cmd-bold">
        Bold
    
      <input type='checkbox' name='fonttype' id="text-cmd-italic">
        Italic
     
      <input type='checkbox' name='fonttype' id="text-cmd-underline" >
        Underline
      
      <input type='checkbox' name='fonttype'  id="text-cmd-linethrough">
        Linethrough
     
      <input type='checkbox' name='fonttype'  id="text-cmd-overline" >
        Overline
       </div>
       
       
         
         <div>
         <button class="brush">브러쉬</button>
         </div>
         <div>
            <button id="selection">selection</button>
         </div>
         <div>
            <button id="moveLayer">moveLayer</button>
         </div>
<<<<<<< HEAD
         
        <div class="layers1_1">
         <button style="float:left; border:solid red 2px; color:red;" class="layers1">layer1</button>
         </div>
         <div class="hidelayers1_1">
         <button style="float:left; border:solid black 2px; color:black;" class="hidelayers1">hidelayer1</button>
         </div>
         <div class="deletelayers1_1">
         <button class="deletelayers1">deletelayer1</button>
         </div>
         
=======
         <div class="layers">
       		<div class="layers1">
        		<button style="float:left; border:solid red 2px; color:red;" class="layers1">layer1</button>
       		</div>
        	<div class="hidelayers1">
        		<button style="float:left; border:solid black 2px; color:black;" class="hidelayers1">hidelayer1</button>
        	</div>
        	<div class="deletelayers1">
        		<button class="deletelayers1">deletelayer1</button>
       		</div>
         </div>
        <div class="layers1">
        	<button style="float:left; border:solid red 2px; color:red;" class="layers1">layer1</button>
        </div>
        	<div class="hidelayers1">
        		<button style="float:left; border:solid black 2px; color:black;" class="hidelayers1">hidelayer1</button>
        	</div>
        	<div class="deletelayers1">
        		<button class="deletelayers1">deletelayer1</button>
        	</div>
        <div>
		    <div style="float:left;width:100px;">레이어 추가 : </div>
		    <div style="clar:both;">
		        <input type="button" id="addItem" value="추가" onclick="createItem();">
		    </div>
		</div>
		<br />
		<div id="itemBoxWrap"></div>     
>>>>>>> main
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
<<<<<<< HEAD
         </div>
         <button id="red">펜</button>
         <button id="eraser">eraser</button>
         <button id="drawer">drawer</button>
=======
         </div>   
         <div>
         	<input type="button" value="펜" onclick="baseBrush();">
         </div>   
>>>>>>> main
      </div>
      
      
     
      <div class="rangeBar">
         <input type="range" max="1" min="0.1" step="0.05" value="1" id="opacity" class="range">
       </div>
       <div class="rangeBar">
         <input type="range" max="30" min="1" step="1" value="5" id="thickness" class="range">
       </div>
       
       </div>
    <div id="con2" class="conBox">
        Chatting
    </div>
    <div id="con3" class="conBox">
        Member
    </div>
	</div>
	</div>
	
	<div class="button-div div-close">
	  <div class="button-open"></div>
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
<<<<<<< HEAD
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
                 

=======
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
>>>>>>> main
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