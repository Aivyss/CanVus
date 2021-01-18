package com.canvus.app.drawing.mapper;

import java.util.List;
import java.util.Map;

import com.canvus.app.drawing.vo.DrawingUserVO;

public interface JoinListMapper {

	public boolean addUser(DrawingUserVO admin);
	
	public List<DrawingUserVO> getUserList(String roomId);


}
