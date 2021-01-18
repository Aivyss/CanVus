package com.canvus.app.drawing.mapper;

import java.util.List;
import java.util.Map;

import com.canvus.app.drawing.vo.DrawingRoomVO;

public interface DrawingRoomMapper {
	/**
	 * 작성일: 2021.01.16
	 * @param roomId
	 * @return
	 */
	DrawingRoomVO enterRoom(String roomId);

	boolean createRoom(DrawingRoomVO roomInfo);

	List<Map<String, String>> getUserList(String roomId);
}
