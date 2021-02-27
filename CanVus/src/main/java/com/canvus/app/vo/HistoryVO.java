package com.canvus.app.vo;

import lombok.Data;

@Data
public class HistoryVO {
    private int history_id;
    private String user_id;
    private String feed_id;
    private String history_indate;

    // 편의성을 위해 추가한 변수
    private String preview;
}
