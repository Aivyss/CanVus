package com.canvus.app.dao.mapper;

import com.canvus.app.vo.TagsInFeedVO;

import java.util.List;

public interface TagMapper {

	public List<TagsInFeedVO> tagSearch(String search);

	public boolean addTags(TagsInFeedVO tif);

}
