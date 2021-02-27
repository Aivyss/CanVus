package com.canvus.app.dao.mapper;

import com.canvus.app.vo.BookmarkedFeedsVO;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

public interface BookmarkedFeedMapper {

    boolean addFeedIntoBookmark(BookmarkedFeedsVO bmfVO);

    int getTotalRecordsOnBookmark(int folder_id);

    List<BookmarkedFeedsVO> bookMarkDetail(RowBounds rb, int folder_id);
}
