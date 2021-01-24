package com.canvus.app.dao.mapper;

import java.util.List;

import com.canvus.app.vo.TagVO;
import com.canvus.app.vo.TagsInFeedVO;

public interface TagMapper {

	public List<TagVO> tagSearch(String search);

	public boolean addTags(TagsInFeedVO tif);

}
