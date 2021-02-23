package com.canvus.app.drawing.mapper;

import com.canvus.app.drawing.vo.DrawingRoomVO;

public interface DrawingRoomMapper {

	public boolean createRoom(DrawingRoomVO roomInfo);
	
	public DrawingRoomVO getRoomById(String room_Id);

    void closeRoom(String room_id);
}
