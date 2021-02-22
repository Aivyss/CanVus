package com.canvus.app.drawing.mapper;

import java.util.List;
import java.util.Map;

import com.canvus.app.drawing.vo.DrawingRoomVO;
import com.canvus.app.drawing.vo.DrawingUserVO;

public interface DrawingRoomMapper {

	public boolean createRoom(DrawingRoomVO roomInfo);
	
	public DrawingRoomVO getRoomById(String room_Id);

    void closeRoom(String room_id);
}
