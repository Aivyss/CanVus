package com.canvus.app.controller;

import com.canvus.app.service.FeedService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Slf4j
@Controller
@RequestMapping(value="/feed")
public class FeedViewController {
    @Autowired
    private FeedService feedService;

    @RequestMapping(value="/view", method= RequestMethod.GET)
    public String readFeed(String feed_id, HttpSession session, Model model){
        log.info("피드 뷰 컨트롤러 메소드 진입");
        String url = "";

        url = feedService.readFeed(feed_id, session, model);

        return url;
    }
}
