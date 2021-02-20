package com.canvus.app.vo;

import lombok.Data;

@Data
public class LikeVO {
    private int like_id;
    private String user_id;
    private String feed_id;
    private String inputdate;
}
