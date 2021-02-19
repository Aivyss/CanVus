<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Discovery</title>
<style type="text/css">
   .mainLogo{
   font-size: 35px;
   padding-left: 20px;
   padding-right: 150px;
   padding-top: 30px;
   text-decoration: none;
   
}

.search{
   width: 500px;
   height: 20px; 
   background-color: #efefef; 
    border-radius: 6px; 
    border: 1px solid #dedede; 
    padding: 10px; 
    margin-top: 3px; 
    font-size: 0.9em; 
    color: #3a3a3a; 
}

input:focus, textarea:focus{ 
    border: 1px solid #97d6eb; 
} 

.tab{
   font-size: 25px;
   float: right;
   padding-left: 50px;
   padding-right: 20px;
   padding-top: 15px;
   text-decoration: none;
}

.title{
   font-size: 40px;
   font-weight: bolder;
}

table{
   margin-left: 150px;
}

.userBestImg{
   width: 160px;
   height: 160px;
}

.userImg{
   width: 160px;
   height: 160px;
   padding-left: 40px;
}

.profileText{
   padding-left: 10px;
   padding-right: 10px;
}

.blank{
   padding: 20px;
}

.seeMore{
   font-size: 30px;
   text-align: center;
}

.rankPicture{
   width: 320px;
   height: 170px;
}

p{
   padding-left: 150px;
   
}

.like{
   width: 20px;
   height: 20px;
   float: right;
}

.user{
   text-align: center;
}

.rankTable{
   margin-left: 200px;
}

rank{
   font-size: 20px;
   font-weight: bolder;
}

</style>
</head>
<body>
	<jsp:include page="baseJSP/mainMenu.jsp"></jsp:include>
	
   <!-- 메인로고 >> 클릭시 홈으로 -->
   <a href="/" class="mainLogo">CanVus</a>
   
   <!-- 전체 검색 텍스트 창 -->
   <input type="text" class="search">
   
   <!-- 오른쪽 상단 메뉴 탭들 -->
   <a href="" class="tab">Profile</a>
   <a href="" class="tab">Drawing</a>
   <a href="" class="tab">Share</a>
   <a href="" class="tab">Notification</a>
   <a href="" class="tab">Discovery</a>
   <br> <br><br>
   
   
   
   <!-- あなたにお勧め 테이블 -->
   <table class="recommendTable">
      <tr>
         <td class="title" colspan="8">あなたにお勧め</td>
      </tr>
      
      <!-- 첫번째 추천 유저 -->
      <tr>
         <td rowspan="3">
            <!-- 추천 유저의 대표 이미지 -->
            <img class="userBestImg" alt="대표 이미지" src="/resources/images/순두부.png">
         </td>
         <!-- 유저의 아이디 -->
         <td id="id" class="profileText">팬티벗고소리질러</td>
         
         <!-- 유저의 대표이미지를 제외한 나머지 추천 이미지들 -->
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
      </tr>
      
      <tr>
         <!-- 유저의 간단한 소개글 -->
         <td id="profileIntro" class="profileText">Brief Introduction</td>
      </tr>
      
      <tr>
         <!-- 팔로우하기 -->
         <td id="follow" class="profileText"><a href="">팔로우</a></td>
      </tr>
      
      <tr>
         <!-- 밑에 여백을위한 빈 공간임 -->
         <td class="blank" colspan="8"></td>
      </tr>
      
      
      <!-- 두번째 추천 유저 -->
      <tr>
         <td rowspan="3">
            <!-- 추천 유저의 대표 이미지 -->
            <img class="userBestImg" alt="대표 이미지" src="/resources/images/순두부.png">
         </td>
         <!-- 유저의 아이디 -->
         <td id="id" class="profileText">팬티벗고소리질러</td>
         
         <!-- 유저의 대표이미지를 제외한 나머지 추천 이미지들 -->
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
      </tr>
      
      <tr>
         <!-- 유저의 간단한 소개글 -->
         <td id="profileIntro" class="profileText">Brief Introduction</td>
      </tr>
      
      <tr>
         <!-- 팔로우하기 -->
         <td id="follow" class="profileText"><a href="">팔로우</a></td>
      </tr>
      
      <tr>
         <!-- 밑에 여백을위한 빈 공간임 -->
         <td class="blank" colspan="8"></td>
      </tr>
      
      
      <!-- 세번째 추천 유저 -->
      <tr>
         <td rowspan="3">
            <!-- 추천 유저의 대표 이미지 -->
            <img class="userBestImg" alt="대표 이미지" src="/resources/images/순두부.png">
         </td>
         <!-- 유저의 아이디 -->
         <td id="id" class="profileText">팬티벗고소리질러</td>
         
         <!-- 유저의 대표이미지를 제외한 나머지 추천 이미지들 -->
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
         <td rowspan="3">
            <img class="userImg" alt="userImg" src="/resources/images/순두부.png">
         </td>
      </tr>
      
      <tr>
         <!-- 유저의 간단한 소개글 -->
         <td id="profileIntro" class="profileText">Brief Introduction</td>
      </tr>
      
      <tr>
         <!-- 팔로우하기 -->
         <td id="follow" class="profileText"><a href="">팔로우</a></td>
      </tr>
      
      <tr>
         <!-- 추천유저 더보기 -->
         <td class="seeMore" colspan="8"><a href="">See more</a></td>
      </tr>
      
      <tr>
         <!-- 밑에 여백을위한 빈 공간임 -->
         <td class="blank" colspan="8"></td>
      </tr>
      
      
   <!-- 주간랭킹 테이블 -->   
   </table>
   <p class="title">週間のランキング（総合）</p>
   
   <table class="rankTable" border="1">
      <tr>   
         <td class="rank">1위</td>
      </tr>
      
      <tr>
         <td>
            <!-- 순위권유저의 작품보여주기 -->
            <img class="rankPicture" alt="rankPicture" src="/resources/images/순두부.png">
         </td>
      </tr>
      
      <tr>
         <td>
            <!-- 좋아요 누르기 -->
            <img class="like" alt="좋아요" src="/resources/images/빈하트.png">
         </td>
      </tr>
      
      <tr>
         <td class="user">user1</td>
      </tr>
      
      <tr>
         <td class="user">user2</td>
      </tr>
      
      <tr>
         <td class="user">user3</td>
      </tr>
      
      <tr>
         <td class="user">user4</td>
      </tr>
      
      
   
   </table>












</body>
</html>