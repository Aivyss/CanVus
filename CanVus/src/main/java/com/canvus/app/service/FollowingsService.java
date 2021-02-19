package com.canvus.app.service;

import com.canvus.app.dao.FollowingsDAO;
import com.canvus.app.vo.FollowingsVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class FollowingsService {
    @Autowired
    FollowingsDAO followingsDAO;

    public  Map<String, Object> getFollowInfo(String user_id) {
        log.info("팔로우 정보 셀렉 서비스 메소드");

        List<FollowingsVO> followList = followingsDAO.getFollow(user_id);
        List<FollowingsVO> followerList = followingsDAO.getFollower(user_id);

        Map<String, Object> infoPack = new HashMap<>();

        infoPack.put("followList", followList);
        infoPack.put("followerList", followerList);

        return infoPack;
    }


}
