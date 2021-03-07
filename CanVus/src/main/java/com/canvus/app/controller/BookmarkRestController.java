package com.canvus.app.controller;

import com.canvus.app.service.BookmarkService;
import com.canvus.app.vo.BookmarkVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping(value="/bookmarkRest")
public class BookmarkRestController {
    @Autowired
    private BookmarkService bookmarkService;

    /**
     * AJAX 통신
     * 북마크에 해당 피드를 추가하는 메소드
     * 작성일: 2021.02.22
     * 작성자: 이한결
     */
    @RequestMapping(value="/addFeedIntoBookmark", method= RequestMethod.POST)
    public Map<String, Object> addFeedIntoBookmark (@RequestBody Map<String, Object> params) {
        log.info("북마크 추가 메소드 진입");

        Map<String, Object> result = bookmarkService.addFeedIntoBookmark(params);

        return result;
    }

    /**
     * 북마크를 생성하는 프로세스로 진입. ajax 통신방식으로 생성
     * 작성일: 2021.01.22 / 완성일: / 버그검증일:
     * 작성자: 이한결
     *
     * @param session
     * @return
     */
    @RequestMapping(value="/makeFolder", method=RequestMethod.POST)
    public BookmarkVO makeFolder(BookmarkVO inputInfo, HttpSession session) {
        log.info("북마크 생성 프로세스 진입 controller");

        // TODO 북마크 생성 (중복체크 실시 후 중복이 없을 시 생성)
        BookmarkVO bookmark = bookmarkService.makeFolder(session, inputInfo);

        return bookmark;
    }

    /**
     * 폴더 이름 중복체크
     * 20210226
     * 이한결
     * @param params
     * @return
     */
    @RequestMapping(value="/checkDuplicateAndCreate", method=RequestMethod.POST)
    public Map<String, Object> checkDuplicateAndCreate(@RequestBody Map<String, Object> params) {
        return bookmarkService.checkDuplicateAndCreate(params);
    }

    /**
     * 지정한 북마크로부터 저장된 피드를 삭제하는 메소드
     * 20210305
     * 이한결
     * @param params
     */
    @RequestMapping(value="/deleteFeedFromBookmark", method=RequestMethod.POST)
    public void deleteFeedFromBookmark(@RequestBody Map<String, Object> params) {
        log.info("북마크로부터 피드삭제 컨트롤러 메소드 진입");
        bookmarkService.deleteFeedFromBookmark(params);
    }

    /**
     * 북마크를 제거하는 메소드
     * 20210305
     * 이한결
     * @param params
     */
    @RequestMapping(value="deleteFolder", method=RequestMethod.POST)
    public void deleteFolder(@RequestBody Map<String, Object> params) {
        log.info("북마크를 제거하는 컨트롤러");
        
        bookmarkService.deleteFolder(params);
    }
}
