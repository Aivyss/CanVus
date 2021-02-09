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
        $(".layers1").remove();
        $(".hidelayers1").remove();
        $(".deletelayers1").remove();
        layerstotal-=1;
    });


    $("#moveLayer").click(function(){
        $('.layer1').draggable();
    });

    $('.layer1').mouseup(function(){

        $('.layer1').draggable("destroy");
    });


});