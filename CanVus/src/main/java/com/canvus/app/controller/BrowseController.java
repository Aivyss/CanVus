package com.canvus.app.controller;

import com.canvus.app.service.BrowseService;
import com.canvus.app.util.PageNavigator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Controller
@RequestMapping(value="/browse")
public class BrowseController {

    @Autowired
    private BrowseService service;

    private final int countPerPage = 3;
    private final int pagePerGroup = 5;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model, @RequestParam(defaultValue = "") String title,
                       @RequestParam(defaultValue = "1")int page){

        log.info("BrowseController 진입");

        log.info("keyword : {}", title);
        //인원, 사진, 호스트, 방제목, Room ID, 인수 제한

        int total = service.getRoomCount(title);
        log.info("total : {}", total);

        PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
        log.info("navi = {}", navi);

        ArrayList<HashMap<String, Object>> list
                = service.getRoomsByTitle(title, navi.getStartRecord(), navi.getCountPerPage());

        log.info("list size : {}", list.size());
        log.info("list info : {}", list);

        model.addAttribute("list", list);
        model.addAttribute("title", title);
        model.addAttribute("navi", navi);
        return "browse/list";
    }

    //방 입장은 DrawingController.java의 room 메소드를 통해 수행

}
