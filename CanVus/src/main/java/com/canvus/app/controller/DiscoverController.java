package com.canvus.app.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.canvus.app.service.DiscoverService;
import com.canvus.app.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.canvus.app.service.FeedService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Slf4j
@Controller
@RequestMapping(value="/discover")
public class DiscoverController {

    @Autowired
    private DiscoverService service;

    //메인
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String view(Model model, HttpSession session){

        log.info("DiscoverController view 진입");
        log.info("userId : {}", session.getAttribute("userId"));



        return service.view(model, session);
    }

    //피드 갖고오기, 페이징
    @RequestMapping(value = "/tag", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> getPage( HttpSession session,
                                            @RequestBody HashMap<String, Object> param){
        log.info("페이징 메소드 진입");

        log.info("controller param {}", param.toString());

        return service.getTagPage(param, session);
    }

    //기능1: Trending List
    //History의 최근 100개의 기록 내에서 모든 유저들로부터(나 포함) 좋아요를 많이 받은 순서와 날짜순으로 Feed List를 도출


    //기능2: Recommendation List
    //특정 유저가 열람한 Feed History 100개 내의 #Tag Ranking을 수집
    //각 태그의 1달 내의 팔로우 하지 않은 다른 유저 내에서 라이크, 날짜순으로 Feed List를 도출
    //모델은 페이지가 옮겨갈 때 사용할 수 있다.

    //tag로 트랜딩을 구분하면 안 된다


}