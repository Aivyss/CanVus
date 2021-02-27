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

    @RequestMapping(value="", method=RequestMethod.GET)
    public String bookmarkMain(HttpSession session, Model model) {
        log.info("북마크 및 히스토리 폴더 페이지 컨트롤러 진입");
        return bookmarkService.bookmarkMain(session, model);
    }

    @RequestMapping(value="/history", method = RequestMethod.GET)
    public String historyFolder(HttpSession session, Model model, int pageNo) {
        log.info("history 페이지 컨트롤러 메소드 진입");

        return bookmarkService.historyFolder(session, model, pageNo);
    }
}
