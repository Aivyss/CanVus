package com.canvus.app.drawing.vo;

import lombok.Data;

@Data
public class FeedVO {
    private String feed_id; // 피드 아이디로 재사용한다.
    private String user_id1; // 피드의 작성자
    private String user_id2; // 피드의 작성자
    private String user_id3; // 피드의 작성자
    private String user_id4; // 피드의 작성자
    private String context;
    private String[] pages;

    // 편의상 추가한 멤버변수
    private String nickname1;
    private String nickname2;
    private String nickname3;
    private String nickname4;
}
