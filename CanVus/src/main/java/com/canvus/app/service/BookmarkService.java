package com.canvus.app.service;

import com.canvus.app.dao.BookmarkDAO;
import com.canvus.app.util.PageNavigator;
import com.canvus.app.vo.BookmarkVO;
import com.canvus.app.vo.BookmarkedFeedsVO;
import com.canvus.app.vo.HistoryVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class BookmarkService {
    // 페이징 처리
    private final int COUNT_PER_PAGE = 6;
    private final int PAGE_PER_GROUP = 5;

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

    /**
     * 히스토리 폴더 내부로 이동하는 서비스 메소드
     * 작성일: 2021.02.25
     * 작성자: 이한결
     * @param session
     * @param model
     * @return
     */
    public String historyFolder(HttpSession session, Model model, int pageNo) {
        String user_id = (String) session.getAttribute("userId");
        int totalRecords = bookmarkDAO.getTotalRecordsOnHistories(user_id);
        String url = "user/history";

        PageNavigator nav = new PageNavigator(COUNT_PER_PAGE, PAGE_PER_GROUP, pageNo, totalRecords);

        bookmarkDAO.getPageOfHistory(user_id, nav.getStartRecord(), nav.getCountPerPage());

        return url;
    }

    /**
     * 북마크 메인으로 이동하는 서비스 메소드
     * 2021.02.25
     * 이한결
     * @param session
     * @param model
     * @return
     */
    public String bookmarkMain(HttpSession session, Model model) {
        String user_id = (String) session.getAttribute("userId");
        String url = "bookmark/main";

        int historyRecordCount = bookmarkDAO.getTotalRecordsOnHistories(user_id);
        List<BookmarkVO> bookmarkFolderAbstractList = bookmarkDAO.getBookmarkFolderAbstractList(user_id);
        log.info(historyRecordCount+"");
        log.info(bookmarkFolderAbstractList.toString());

        model.addAttribute("historyRecordCount", historyRecordCount);
        model.addAttribute("bookmarkFolderAbstractList", bookmarkFolderAbstractList);

        return url;
    }

    /**
     * 폴더를 생성하기 위한 서비스 메소드
     * 작성일: 2021.01.22 / 완성일: / 버그검증일:
     * 작성자: 이한결
     * @param session
     * @param inputInfo
     * @return
     */
    public BookmarkVO makeFolder(HttpSession session, BookmarkVO inputInfo) {
        log.info("북마크 생성 service 메소드 진입");

        // TODO 아이디를 inputInfo에 추가.
        String user_id = (String) session.getAttribute("userId");
        inputInfo.setUser_id(user_id);
        inputInfo.setFolder_name(inputInfo.getFolder_name().trim()); // 문자열 좌우공백 제거

        // TODO 값이 제대로 들어갔는지 체크. 나중에 지워도 됨
        log.info(inputInfo.getFolder_name());
        log.info(inputInfo.getUser_id());

        // TODO 북마크 이름 중복체크
        BookmarkVO dbData = bookmarkDAO.checkDoubleNameOfBookmark(inputInfo);

        if (dbData != null) { // 중복된 이름이 있는 경우
            dbData = null;
        } else {
            boolean check = bookmarkDAO.makeFolder(inputInfo);

            if (check) { // 생성이 완료됐으면 다시 더블첵 메소드를 활용해서 해당 북마크 정보를 불러옴.
                dbData = bookmarkDAO.checkDoubleNameOfBookmark(inputInfo);
            }
        }

        return dbData;
    }

    /**
     * 북마크 폴더를 제거하는 서비스 메소드
     * 작성일: 2021.01.22 / 완료일: / 버그검증일:
     * 작성자: 이한결
     * @param inputInfo
     * @param session
     * @return
     */
    public boolean deleteFolder(Map<String, Object> params) {
        log.info("북마크 제거 서비스 메소드 진입");

        // TODO 세션의 아이디 정보를 inputInfo에 넣는 과정

        return bookmarkDAO.deleteFolder((Integer) params.get("folder_id"));
    }

    /**
     * 특정 폴더 아이디의 북마크 내역을 보는 페이지로 이동
     * 20210225
     * 이한결
     * @param folder_id
     * @return
     */
    public String bookMarkDetail(Model model, int folder_id, int pageNo) {
        String url = "bookmark/detail";
        int totalRecords = bookmarkDAO.getTotalRecordsOnBookmark(folder_id);
        PageNavigator nav = new PageNavigator(COUNT_PER_PAGE, PAGE_PER_GROUP, pageNo, totalRecords);

        List<BookmarkedFeedsVO> bookmarkedFeedList = bookmarkDAO.bookMarkDetail(folder_id, nav.getStartRecord(), nav.getCountPerPage());
        log.info(bookmarkedFeedList.toString());
        model.addAttribute("bookmarkedFeedList", bookmarkedFeedList);
        model.addAttribute("pageNav", nav);

        return url;
    }
}
