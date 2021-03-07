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
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class DiscoverService {

    @Autowired
    private DiscoverDAO dao;

    private final int countPerPage = 12;
    private final int pagePerGroup = 5;


    public String view(Model model, HttpSession session){

        log.info("Service 진입");

        String userId = (String) session.getAttribute("userId");
        if (userId != null) {
            ArrayList<String> tagList = dao.getRecommendationTag(userId);
            List<String> refinedList = new ArrayList<>();

            for (String tag : tagList) {
                // 프론트에서 id에 #을 쓸수가 없다...
                refinedList.add(tag.replace("#", ""));
            }

            model.addAttribute("tagList", refinedList);
        }

        return "discover/main";
    }

    public HashMap<String, Object> getTagPage(HashMap<String, Object> param, HttpSession session){

        String header = (String) param.get("header");
        String tag = (String) param.get("tag").toString();
        String userId = (String) session.getAttribute("userId");

        int total = dao.getFeedCount(header, tag, userId);

        PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, (Integer) param.get("page"), total);
        RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());

        log.info("total {}", total);
        log.info("header {}",header);
        log.info("tag {}", tag);
        log.info("userId {}", userId);
        log.info("rb {}", rb.toString());

        ArrayList<HashMap<String, Object>> feedList = dao.getFeedsByTag(header, tag, userId, rb);

        param.put("feedList", feedList);
        param.put("pNav", navi);

        return param;

    }

}
