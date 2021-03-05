package com.canvus.app.vo;

import lombok.Data;

@Data
public class BookmarkedFeedsVO {
    private int bkfs_id;
    private int folder_id;
    private String feed_id;
    private String bookmark_indate;

    // 편의성을 위해 추가한 메소드
    private String preview;
    private String nickname;
}
