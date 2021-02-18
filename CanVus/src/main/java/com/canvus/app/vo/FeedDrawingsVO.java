package com.canvus.app.vo;

import lombok.Data;

@Data
public class FeedDrawingsVO implements CanVusVOs {
	private int drawing_id;
	private String feed_id;
	private String[] page_file;
	private String page_file_output;
}
