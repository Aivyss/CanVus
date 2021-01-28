package com.canvus.app.drawing.vo;

import com.canvus.app.vo.CanVusVOs;

import lombok.Data;

@Data
public class DrawingRoomVO implements CanVusVOs {
	private String room_Id;
	private String admin;
	private String title;
	private String password;
	private int user_no;
}
