package com.canvus.app.dao.mapper;

import com.canvus.app.vo.BookmarkVO;

public interface BookmarkMapper {

	public boolean makeFolder(BookmarkVO inputInfo);

	public BookmarkVO checkDoubleNameOfBookmark(BookmarkVO inputInfo);

	public boolean deleteFolder(int folder_id);


}
