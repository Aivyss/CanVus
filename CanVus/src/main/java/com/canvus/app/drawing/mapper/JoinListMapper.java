package com.canvus.app.drawing.mapper;

import com.canvus.app.drawing.vo.DrawingUserVO;

import java.util.List;

public interface JoinListMapper {

	public boolean addUser(DrawingUserVO admin);
	
	public List<DrawingUserVO> getUserList(String roomId);

	public int getUserCount(String room_Id);

	public List<DrawingUserVO> getRoomUserList(String room_Id);
	
	public boolean enterRoom(DrawingUserVO newRoomUser);

	public void quitRoom(DrawingUserVO quitedUser);

    public void addAuthority(DrawingUserVO targetUser);

    void closeRoom(String room_id);
}
