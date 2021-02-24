package com.canvus.app.dao.mapper;


import com.canvus.app.drawing.vo.DrawingRoomVO;
import org.apache.ibatis.session.RowBounds;

import java.util.ArrayList;
import java.util.HashMap;

public interface BrowseMapper {
    public ArrayList<HashMap<String, Object>> getRoomsByTitle(RowBounds rb, String title);
    public int getRoomCount(String title);
}
