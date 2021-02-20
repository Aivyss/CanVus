package com.canvus.app.vo;

import lombok.Data;

@Data
public class FeedLikeVO {
    private int like_id;
    private String feed_id;
    private String user_id;
    private String nickname;
    private String inputdate;
}
