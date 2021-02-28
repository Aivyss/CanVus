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
}
