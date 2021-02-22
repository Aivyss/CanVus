package com.canvus.app.service;

import com.canvus.app.dao.BookmarkDAO;
import com.canvus.app.vo.BookmarkVO;
import com.canvus.app.vo.BookmarkedFeedsVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Slf4j
@Service
public class BookmarkService {
    @Autowired
    private BookmarkDAO bookmarkDAO;

    /**
     * AJAX 통신
     * 북마크에 해당 피드를 추가하는 메소드
     * 작성일: 2021.02.22
     * 작성자: 이한결
     */
    public Map<String, Object> addFeedIntoBookmark(Map<String, Object> params) {
        BookmarkedFeedsVO bmfVO = new BookmarkedFeedsVO();

        bmfVO.setFolder_id((Integer) params.get("folder_id"));
        bmfVO.setFeed_id((String) params.get("feed_id"));

        boolean isSuccess = bookmarkDAO.addFeedIntoBookmark(bmfVO);

        params.put("isSuccess", isSuccess);

        return params;
    }
}
