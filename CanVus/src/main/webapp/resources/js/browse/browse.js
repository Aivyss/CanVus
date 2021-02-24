$(() => {

    /******************************** 호이스팅 함수부 ************************************/
    function doSearchRoom(searchTitle){
        location.href = '/browse/list/?title='+searchTitle;
    }


    /******************************* 이벤트 등록부 *************************************/
    // 검색창의 내용이 바뀔때 이벤트.
    $('#searchTitle').change(function (){

    });

    $('#searchTitle').keydown(function (key){
        if(key.keyCode == 13){
            const keyword = $('#searchTitle').val();

            if(keyword.length != 0){
                doSearchRoom(keyword);
                $('#searchTitle').val("");
            }
        }
    });



    $('#previousPage').click(function (){
        location.href = '/browse/list/?page='+$('#previousPage').val();
    });

    $('#nextPage').click(function (){
        location.href = '/browse/list/?page='+$('#nextPage').val();
    });


});

