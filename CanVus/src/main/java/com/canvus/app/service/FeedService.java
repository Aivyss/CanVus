package com.canvus.app.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.dao.FeedDAO;
import com.canvus.app.dao.TagDAO;
import com.canvus.app.util.Helper;
import com.canvus.app.vo.CanVusVOFactory;
import com.canvus.app.vo.CanVusVOType;
import com.canvus.app.vo.FeedVO;
import com.canvus.app.vo.TagsInFeedVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class FeedService {
	@Autowired
	private FeedDAO feedDAO;
	@Autowired
	private TagDAO tagDAO;
	
	public Map<String, String> getContext(Map<String, String> params) {
		log.info("getContext 서비스 메소드 진입");

		// TODO 데이터베이스로부터 피드 정보를 가지고 온다.
		log.info(params.get("feed_id"));
		FeedVO feed = feedDAO.selectFeed(params.get("feed_id"));
		
		params.put("feed_id", feed.getFeed_id());
		params.put("context", feed.getContext());
		
		return params;
	}
	
	/**
	 * 피드 내용을 수정하고 그 결과를 반출하는 서비스 메소드
	 * 작성일: 2021.01.24 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param params
	 * @return
	 */
	public Map<String, String> updateFeed(Map<String, String> params) {
		FeedVO feed = CanVusVOFactory.newInstance(CanVusVOType.FeedVO);
		feed.setFeed_id(params.get("feed_id"));
		feed.setContext(params.get("context"));
		params.remove("feed_id");
		params.remove("context");
		
		// TODO 피드 내용업데이트.
		boolean check = feedDAO.updateFeed(feed);
		
		// TODO 피드 내용 업데이트에 따른 태그 변경
		if (check) {
			TagsInFeedVO tif = Helper.tagParse(feed.getFeed_id(), feed.getContext());
			check = tagDAO.updateTags(tif);
		}
		
		if (check) {
			params.put("result", "success");
		} else {
			params.put("result", "fail");
		}

		return params;
	}

}
