package com.canvus.app.service;
import com.canvus.app.dao.DiscoverDAO;
import com.canvus.app.util.PageNavigator;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class DiscoverService {

    @Autowired
    private DiscoverDAO dao;

    private final int countPerPage = 3;
    private final int pagePerGroup = 5;


    public String view(Model model, HttpSession session){

        ArrayList<String> tagList = dao.getRecommendationTag((String) session.getAttribute("userId"));

        model.addAttribute("tagList", tagList);

        return "discover/main";
    }

    public HashMap<String, Object> getTagPage(HashMap<String, Object> param, HttpSession session){

        String header = param.get("header").toString();
        String tag = param.get("tag").toString();
        String userId = session.getAttribute("userId").toString();

        int total = dao.getFeedCount(header, tag, userId);
        PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, (Integer) param.get("page"), total);
        RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());

        ArrayList<HashMap<String, Object>> feedList = dao.getFeedsByTag(header, tag, userId, rb);

        param.put("feedList", feedList);

        return param;

    }
}
