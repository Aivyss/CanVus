package com.canvus.app.dao.mapper;

import com.canvus.app.vo.FeedCommentVO;

import java.util.List;
import java.util.Map;

public interface FeedCommentMapper {
    List<FeedCommentVO> readFeedComments(String feed_id);

    boolean sendComment(FeedCommentVO commentVO);

    FeedCommentVO selectAdditionalCommentInfo(FeedCommentVO commentVO);
}
