package com.canvus.app.dao.mapper;

import java.util.List;

import com.canvus.app.vo.TagsInFeedVO;

public interface TagMapper {

	public List<TagsInFeedVO> tagSearch(String search);

	public boolean addTags(TagsInFeedVO tif);

}
