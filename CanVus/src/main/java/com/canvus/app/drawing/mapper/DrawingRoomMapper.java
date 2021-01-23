package com.canvus.app.drawing.mapper;

import java.util.List;
import java.util.Map;

import com.canvus.app.drawing.vo.DrawingRoomVO;

public interface DrawingRoomMapper {

	public boolean createRoom(DrawingRoomVO roomInfo);
	
	public DrawingRoomVO enterRoom(String roomId);

	public DrawingRoomVO getRoomById(String room_Id);

}
