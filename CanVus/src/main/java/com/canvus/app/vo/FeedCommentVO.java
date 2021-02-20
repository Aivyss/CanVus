package com.canvus.app.vo;

import lombok.Data;

@Data
public class FeedCommentVO {
    private int comment_id;
    private String user_id;
    private String nickname;
    private String feed_id;
    private String feed_comment;
    private String inputdate;
}
