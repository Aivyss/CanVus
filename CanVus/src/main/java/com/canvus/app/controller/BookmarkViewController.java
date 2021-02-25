package com.canvus.app.controller;

import com.canvus.app.service.BookmarkService;
import com.canvus.app.service.UserService;
import com.canvus.app.vo.BookmarkVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping(value="/bookmark")
public class BookmarkViewController {
    @Autowired
    private BookmarkService bookmarkService;
    @Autowired
    private UserService userService;

    /**
     * 북마크 메인 페이지로 이동
     * 20210225
     * 이한결
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value="", method=RequestMethod.GET)
    public String bookmarkMain(HttpSession session, Model model) {
        log.info("북마크 및 히스토리 폴더 페이지 컨트롤러 진입");
        
        return bookmarkService.bookmarkMain(session, model);
    }

    /**
     * 특정 폴더 아이디의 북마크 내역을 보는 페이지로 이동
     * 20210225
     * 이한결
     * @param folder_id
     * @return
     */
    @RequestMapping(value="/detail", method=RequestMethod.GET)
    public String bookMarkDetail(Model model, int folder_id, int pageNo) {
        log.info("특정 북마크 폴더 디테일 컨트롤러 진입");
        log.info(folder_id+"");
        log.info(pageNo+"");

        return bookmarkService.bookMarkDetail(model, folder_id, pageNo);
    }

    /**
     * 히스토리 디테일로 이동
     * 20210225
     * 이한결
     * @param session
     * @param model
     * @param pageNo
     * @return
     */
    @RequestMapping(value="/history", method = RequestMethod.GET)
    public String historyFolder(HttpSession session, Model model, int pageNo) {
        log.info("history 페이지 컨트롤러 메소드 진입");

        return bookmarkService.historyFolder(session, model, pageNo);
    }
}
