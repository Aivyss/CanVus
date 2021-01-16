package com.canvus.app.dao.mapper;

import java.util.List;

import com.canvus.app.vo.TagVO;

public interface TagMapper {

	List<TagVO> tagSearch(String search);

}
