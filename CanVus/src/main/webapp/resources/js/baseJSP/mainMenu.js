let send = document.querySelector('#searchBtn');


$(() => {
    // 검색창의 내용이 바뀔때 이벤트.
    $('#searchText').change(function () {

    });

    // 서치 컨트롤러
    const searchController = {
        doSearch : function(searchText) {
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
    }

    // 검색 버튼을 클릭하거나 엔터를 누를시 이벤트
    const init = (function (messageController) {
        ['click', 'keyup'].forEach(event => document.addEventListener(event, handler));

        function handler(e) {
            if (e.target == send || e.keyCode == 13) {
                searchController.doSearch($('#searchText').val());
            }
        }
    })(searchController);


});