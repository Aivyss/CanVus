package com.canvus.app.controller;

import com.canvus.app.service.BookmarkService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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

}
