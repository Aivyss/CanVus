package com.canvus.app.drawing.mapper;

import java.util.List;

import com.canvus.app.drawing.vo.PageVO;

public interface PageLayerMapper {

	public List<PageVO> getPgs(String room_Id);

	public boolean createPage(PageVO page);

	public boolean updatePage(PageVO page);

}
