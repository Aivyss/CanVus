package com.canvus.app.vo;

import lombok.Data;

@Data
public class FeedCommentVO {
    private int comment_id;
    private String user_id;
    private String feed_id;
    private String feed_comment;
    private String inputdate;

    // 편의성을 위해 추가한 변수
    private String profile_photo;
    private String nickname;
}
