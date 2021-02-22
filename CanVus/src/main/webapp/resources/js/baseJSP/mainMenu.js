$(() => {
    /******************************** 호이스팅 함수부 ************************************/
    // 전송 함수
    function doSearch (searchText) {
        let url ='/search/result/?keyword=';

        if (searchText.substring(0,1) == '#'){
            // 태그서치
            url += `${searchText.split('#')[1]}&type=0`;
        } else {
            // 유저서치
            url += `/search/result/?keyword=${searchText}&type=1`;
        }

        location.href = url;
    }

    /******************************* 이벤트 등록부 *************************************/
    // 검색창의 내용이 바뀔때 이벤트.
    $('#searchText').change(function () {

    });

    $('#searchText').keydown(function (key) {
        if (key.keyCode == 13) {
            const keyword = $('#searchText').val();

            if (keyword.length != 0) {
                doSearch(keyword);
                $('#searchText').val("");
            }
        }
    });
});