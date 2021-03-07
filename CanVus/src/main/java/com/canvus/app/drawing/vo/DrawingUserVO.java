package com.canvus.app.drawing.vo;

import com.canvus.app.vo.CanVusVOs;
import lombok.Data;

@Data
public class DrawingUserVO implements CanVusVOs {
	// 테이블상 컬럼
	private int joinList_id;
	private String user_id;
	private String room_Id;
	private String user_type;
	
	// 편의를 위해 추가한 멤버변수
	private String nickname;
}
