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

    /**
     * 팔로잉을 업데이트하는 메소드 지우는 것, 추가하는 것 모두 이 메소드로 처리한다
     * 20210228
     * 이한결
     * @param params
     * @return
     */
    public Map<String, Object> updateFollowing(Map<String, Object> params) {
        boolean isFollowing = (Boolean) params.get("isFollowing");
        String myId = (String) params.get("my_id");
        String userId = (String) params.get("user_id");
        boolean isSuccess = false;

        FollowingsVO fVO = new FollowingsVO();
        fVO.setUser_id(myId);
        fVO.setFollowing_id(userId);

        if (isFollowing) {
            isSuccess = followingsDAO.deleteFollowing(fVO);
        } else {
            isSuccess = followingsDAO.addFollowing(fVO);
        }

        params.put("isSuccess", isSuccess);

        return params;
    }
}
