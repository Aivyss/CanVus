package com.canvus.app.dao.mapper;


import org.apache.ibatis.session.RowBounds;

import java.util.ArrayList;
import java.util.HashMap;

public interface BrowseMapper {
    public int getRoomCount(String title);
    public ArrayList<HashMap<String, Object>> getRoomsByTitle(RowBounds rb, String title);
}
