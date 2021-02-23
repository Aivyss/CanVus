package com.canvus.app.vo;

import lombok.Data;

import java.util.List;

@Data
public class FeedComponentVO {
    private String feed_id;
    private String user_id1;
    private String user_id2;
    private String user_id3;
    private String user_id4;
    private String context;
    private String inputdate;
    
    // Feeds table 이외의 컬럼
    private int like;
    private List<String> pictures;
    private String preview;
    private List<String> tags;
}
