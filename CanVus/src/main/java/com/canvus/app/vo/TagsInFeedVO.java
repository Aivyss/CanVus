package com.canvus.app.vo;

import lombok.Data;

@Data
public class TagsInFeedVO implements CanVusVOs {
	// Tags_in_feed 테이블 컬럼
	private int tif_id;
	private String feed_id;
	private String[] tag_name;
}
