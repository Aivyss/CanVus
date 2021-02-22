package com.canvus.app.controller;

import com.canvus.app.service.CommentService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping(value="/comment")
public class CommentController {
    @Autowired
    private CommentService commnentService;

    /**
     * 코멘트 작성 ajax 통신 메소드
     * 작성일: 2021.02.22 / 완성일: / 버그검증일:
     * 작성자: 이한결
     * @param params
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/sendComment", method= RequestMethod.POST)
    public Map<String, Object> sendComment(@RequestBody Map<String, Object> params, HttpSession session) {
        log.info("코멘트 작성 컨트롤러 메소드 진입");

        return commnentService.sendComment(params, session);
    }
}
