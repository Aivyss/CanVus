package com.canvus.app.controller;

import com.canvus.app.service.CommentService;
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
@RequestMapping(value="/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    /**
     * 코멘트 작성 ajax 통신 메소드
     * 작성일: 2021.02.22 / 완성일: / 버그검증일:
     * 작성자: 이한결
     * @param params
     * @param session
     * @return
     */
    @RequestMapping(value="/sendComment", method= RequestMethod.POST)
    public Map<String, Object> sendComment(@RequestBody Map<String, Object> params, HttpSession session) {
        log.info("코멘트 작성 컨트롤러 메소드 진입");

        return commentService.sendComment(params, session);
    }

    /**
     * 코멘트 삭제 ajax 메소드
     * 20210305
     * 이한결
     * @param params
     */
    @RequestMapping(value="/deleteComment", method= RequestMethod.POST)
    public void deleteComment(@RequestBody Map<String, Object> params) {
        log.info("코멘트 삭제 컨트롤러 메소드 진입");

        commentService.deleteComment(params);
    }

}
