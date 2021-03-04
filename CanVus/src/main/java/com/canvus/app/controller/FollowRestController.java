package com.canvus.app.controller;

import com.canvus.app.service.FollowingsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@Slf4j
@RequestMapping(value="/follow")
@RestController
public class FollowRestController {
    @Autowired
    private FollowingsService followingsService;

    /**
     * 팔로잉을 업데이트하는 메소드 지우는 것, 추가하는 것 모두 이 메소드로 처리한다
     * 20210228
     * 이한결
     * @param params
     * @return
     */
    @RequestMapping(value="updateFollowing", method= RequestMethod.POST)
    public void updateFollowing(@RequestBody Map<String, Object> params) {

        followingsService.updateFollowing(params);
    }
}
