package com.canvus.app.vo;

import lombok.Data;

@Data
public class TagVO implements CanVusVOs {
	private int tif_id;
	private String tag_name;
	private int feed_id;
}
