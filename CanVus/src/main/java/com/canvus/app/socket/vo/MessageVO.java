package com.canvus.app.socket.vo;

import lombok.Data;

@Data
public class MessageVO {
    private String nickname;
    private String message;
    private String timestamp;
}
