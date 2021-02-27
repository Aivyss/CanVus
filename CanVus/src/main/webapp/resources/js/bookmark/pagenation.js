function pagenation(pageNo, totalPage) {
   pageNo = parseInt(pageNo);
   totalPage = parseInt(totalPage);

   if (pageNo == 0) {
      alert("最初のページです。");
   } else if (pageNo > totalPage) {
      alert("最後のページです。");
   } else {
      if(folder_id == undefined || folder_id == null || folder_id.length == 0) {
         // TODO 히스토리 상세 페이지에서 불러온 경우
         location.href=`/bookmark/historyDetail/?pageNo=${pageNo}`;
      } else {
         // TODO 북마크 상세 페이지에서 불러온 경우
         location.href=`/bookmark/detail/?folder_id=${folder_id}&pageNo=${pageNo}`;
      }
   }
}