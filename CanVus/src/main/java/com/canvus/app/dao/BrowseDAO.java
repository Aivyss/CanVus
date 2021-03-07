package com.canvus.app.dao;


import com.canvus.app.dao.mapper.BrowseMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Repository
public class BrowseDAO {
    @Autowired
    private SqlSession session;

    public int getRoomCount(String title){
        int count = 0;

        try {
            BrowseMapper mapper = session.getMapper(BrowseMapper.class);
            count = mapper.getRoomCount(title);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return count;
    }

    public ArrayList<HashMap<String, Object>> getRoomsByTitle(String title, int startRecord, int countPerPage){
        ArrayList<HashMap<String, Object>> list = null;

        RowBounds rb = new RowBounds(startRecord, countPerPage);

        try {
            BrowseMapper mapper = session.getMapper(BrowseMapper.class);
            list = mapper.getRoomsByTitle(rb, title);
        }
        catch (Exception e){
            e.printStackTrace();
        }

        return list;
    }



}
