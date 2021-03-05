package com.canvus.app.dao;

import com.canvus.app.dao.mapper.FeedCommentMapper;
import com.canvus.app.vo.FeedCommentVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Slf4j
@Repository
public class CommentDAO {
    @Autowired
    SqlSession session;

    public FeedCommentVO sendComment(FeedCommentVO commentVO) {
        FeedCommentVO returnValue = null;

        try {
            FeedCommentMapper mapper = session.getMapper(FeedCommentMapper.class);
            boolean check  = mapper.sendComment(commentVO);
            if (check) {
                returnValue = mapper.selectAdditionalCommentInfo(commentVO);
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.info("코멘트 insert sql 오류");
        }

        return returnValue ;
    }

    /**
     * 코멘트 삭제 ajax 메소드
     * 20210305
     * 이한결
     * @param comment_id
     */
    public void deleteComment(int comment_id) {
        try {
            FeedCommentMapper mapper = session.getMapper(FeedCommentMapper.class);
            mapper.deleteComment(comment_id);
        } catch (Exception e) {
            e.printStackTrace();
            log.info("코멘트 삭제 sql 오류");
        }
    }
}
