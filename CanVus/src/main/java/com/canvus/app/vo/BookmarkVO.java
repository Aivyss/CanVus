package com.canvus.app.vo;

import java.util.List;

import com.canvus.app.drawing.vo.FeedVO;
import lombok.Data;

@Data
public class BookmarkVO implements CanVusVOs {
	private int folder_id;
	private String user_id;
	private String folder_name;
	private String feed_id;
}
