package com.canvus.app.dao.mapper;

import com.canvus.app.vo.TagsInFeedVO;

public interface TagsInFeedMapper {

	public boolean inputTags(TagsInFeedVO tif);

	public boolean deleteTags(String feed_id);

}
