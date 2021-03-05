package com.canvus.app.dao.mapper;

import com.canvus.app.vo.BookmarkVO;
import com.canvus.app.vo.BookmarkedFeedsVO;

import java.util.List;

public interface BookmarkMapper {

	public boolean makeFolder(BookmarkVO inputInfo);

	public BookmarkVO checkDoubleNameOfBookmark(BookmarkVO inputInfo);

	public boolean deleteFolder(int folder_id);

	List<BookmarkVO> getBookmarkList(String user_id);

	List<BookmarkVO> getBookmarkFolderAbstractList(String user_id);

    int checkDuplicateAndCreate(BookmarkVO bmVO);

    void deleteFeedFromBookmark(BookmarkedFeedsVO bmfVO);
}
