package com.canvus.app.service;

import com.canvus.app.dao.CommentDAO;
import com.canvus.app.vo.FeedCommentVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Slf4j
@Service
public class CommentService {
    @Autowired
    CommentDAO commentDAO;

    public Map<String, Object> sendComment(Map<String, Object> params, HttpSession session) {
        log.info("코멘트 작성 서비스 메소드 진입");
        FeedCommentVO commentVO = new FeedCommentVO();
        String feed_id = (String) params.get("feed_id");
        String user_id = (String) params.get("user_id");
        String comment = (String) params.get("comment");

        commentVO.setFeed_id(feed_id);
        commentVO.setUser_id(user_id);
        commentVO.setFeed_comment(comment);
        log.info(commentVO.toString());

        FeedCommentVO returnValue = commentDAO.sendComment(commentVO);
        log.info(returnValue.toString());
        params.put("inputdate", returnValue.getInputdate());
        params.put("comment_id", returnValue.getComment_id());
        params.put("nickname", returnValue.getNickname());
        params.put("profile_photo", returnValue.getProfile_photo());

        return params;
    }

    /**
     * 코멘트 삭제 ajax 메소드
     * 20210305
     * 이한결
     * @param params
     */
    public void deleteComment(Map<String, Object> params) {
        int comment_id = (Integer) params.get("comment_id");

        commentDAO.deleteComment(comment_id);
    }
}
