package com.canvus.app.dao.mapper;

import com.canvus.app.vo.LikeVO;

public interface LikeMapper {

    int getLikeCount(String feed_id);

    LikeVO getisLiked(LikeVO like);

    void addLike(LikeVO likeVO);

    void deleteLike(LikeVO likeVO);
}
