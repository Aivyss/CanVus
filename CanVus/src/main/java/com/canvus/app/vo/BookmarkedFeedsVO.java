package com.canvus.app.vo;

import lombok.Data;

@Data
public class BookmarkedFeedsVO {
    private int bkfs_id;
    private int folder_id;
    private String feed_id;
    private String bookmark_indate;
}
