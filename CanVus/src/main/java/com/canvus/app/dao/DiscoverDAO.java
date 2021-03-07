package com.canvus.app.dao;

import com.canvus.app.dao.mapper.DiscoverMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Repository
public class DiscoverDAO {

    @Autowired
    private SqlSession session;

    private int count;
    private ArrayList<HashMap<String, Object>> list;
    private RowBounds rb;
    private DiscoverMapper mapper;

    private final int countPerPage = 3;
    private final int pagePerGroup = 5;


    public ArrayList<String> getRecommendationTag(String userId){

        ArrayList<String> tagList = null;

        log.info("DAO 진입");

        try {
            DiscoverMapper mapper = session.getMapper(DiscoverMapper.class);
            tagList = mapper.getRecommendationTag(userId);
            //tagList.add(0,"#trending");
        }
        catch (Exception e){
            e.printStackTrace();
        }

        return tagList;

    }


    public int getFeedCount(String header, String tag, String userId){

        int count = 0;

        try {
            DiscoverMapper mapper = session.getMapper(DiscoverMapper.class);
            count = mapper.getFeedCount(header, tag, userId);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return count;

    }

    public ArrayList<HashMap<String, Object>> getFeedsByTag(String header, String tag, String userId, RowBounds rb){

        ArrayList<HashMap<String, Object>> list = null;

        try {
            DiscoverMapper mapper = session.getMapper(DiscoverMapper.class);
            list = mapper.getFeedsByTag(header, tag, userId, rb);

        }
        catch (Exception e){
            e.printStackTrace();
        }

        return list;

    }



}
