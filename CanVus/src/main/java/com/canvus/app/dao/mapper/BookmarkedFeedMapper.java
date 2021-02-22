package com.canvus.app.dao.mapper;

import com.canvus.app.vo.BookmarkedFeedsVO;

public interface BookmarkedFeedMapper {
    boolean addFeedIntoBookmark(BookmarkedFeedsVO bmfVO);
}
