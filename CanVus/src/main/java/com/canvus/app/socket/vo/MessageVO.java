package com.canvus.app.socket.vo;

import java.util.Map;

import lombok.Data;

@Data
public class MessageVO {
	private String type;
    private String room_Id;
    private String message; // json에 해당
}
