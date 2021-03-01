package com.canvus.app.dao.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;

public interface DiscoverMapper {
    public ArrayList<String> getRecommendationTag(@Param("userId") String userId);
    public int getFeedCount(@Param("header") String header, @Param("tag") String tag, @Param("userId") String userId);
    public ArrayList<HashMap<String, Object>> getFeedsByTag(
            @Param("header") String header, @Param("tag") String tag, @Param("userId") String userId, @Param("rb") RowBounds rb);
    //기능1: Trending List
    //[최근 1달 내에 작성된] 모든 유저들로부터(나 포함) [좋아요를 1개 이상] 받은 게시물 내에서
    //[좋아요] 순으로 Feed List를 도출

    //기능2: Recommendation List
    //[특정 유저]가 열람한 [1달] 내에 열람한 [Tag]를 [빈도순]으로 수집
    //[각 태그]의 [1달 내에 작성된] [팔로우 하지 않은] [좋아요 1개 이상의] [다른 유저의 게시물] 내에서
    //[좋아요], [날짜순]으로 Feed List를 도출
}
