package com.canvus.app.drawing.vo;

import com.canvus.app.vo.CanVusVOs;

import lombok.Data;

@Data
public class DrawingUserVO implements CanVusVOs {
	private int joinList_id;
	private String user_id;
	private String room_Id;
	private String user_type;
}
