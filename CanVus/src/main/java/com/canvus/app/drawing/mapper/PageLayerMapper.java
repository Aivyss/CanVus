package com.canvus.app.drawing.mapper;

import com.canvus.app.drawing.vo.PageVO;

import java.util.List;

public interface PageLayerMapper {

	public void createPage(PageVO page);

	public void updatePage(PageVO page);

	public List<PageVO> selectAllPages(String room_Id);

    public void deletePageLayer(PageVO page);

    public List<PageVO> getAllLayers(PageVO roomInfo);

    void closeRoom(String room_id);
}
