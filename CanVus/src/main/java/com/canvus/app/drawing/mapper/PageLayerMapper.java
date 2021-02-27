package com.canvus.app.drawing.mapper;

import java.util.List;

import com.canvus.app.drawing.vo.PageVO;

public interface PageLayerMapper {

	public void createPage(PageVO page);

	public void updatePage(PageVO page);

	public List<PageVO> selectAllPages(String room_Id);

    public void deletePageLayer(PageVO page);

    public List<PageVO> getAllLayers(PageVO roomInfo);

    void closeRoom(String room_id);
}
