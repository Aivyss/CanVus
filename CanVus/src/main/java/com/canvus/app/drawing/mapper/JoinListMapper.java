package com.canvus.app.drawing.mapper;

import java.util.List;

import com.canvus.app.drawing.vo.DrawingUserVO;

public interface JoinListMapper {

	public boolean addUser(DrawingUserVO admin);
	
	public List<DrawingUserVO> getUserList(String roomId);

	public int getUserCount(String room_Id);

	public List<DrawingUserVO> getRoomUserList(String room_Id);
	
	public boolean enterRoom(DrawingUserVO newRoomUser);

	public boolean quitRoom(DrawingUserVO quitedUser);

    public void addAuthority(DrawingUserVO targetUser);

    void closeRoom(String room_id);
}
