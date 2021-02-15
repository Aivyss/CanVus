package com.canvus.app.drawing.mapper;

import java.util.List;

import com.canvus.app.drawing.vo.PageVO;

public interface PageLayerMapper {

	public boolean createPage(PageVO page);

	public boolean updatePage(PageVO page);

	public List<PageVO> selectAllPages(String room_Id);

    public boolean deletePageLayer(PageVO page);

    public List<PageVO> getAllLayers(PageVO roomInfo);
}
