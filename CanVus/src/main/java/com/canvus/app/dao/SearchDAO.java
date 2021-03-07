package com.canvus.app.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.canvus.app.dao.mapper.*;
import com.canvus.app.vo.*;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class SearchDAO {
	@Autowired
	SqlSession session;

	public int feedCountReferToTag(String keyword) {
		int count = 0;

		try {
			TagsInFeedMapper mapper = session.getMapper(TagsInFeedMapper.class);
			count = mapper.feedCountReferToTag(keyword);
			log.info(count+"");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("해당 태그로 피드갯수 검색 sql 오류");
		}

		return count;
	}

	public ArrayList<HashMap<String, Object>> getFeedIdBundleByTag(String keyword, RowBounds rb) {
		ArrayList<HashMap<String, Object>> feedBundle = null;

		try {
			TagsInFeedMapper mapper = session.getMapper(TagsInFeedMapper.class);
			feedBundle = mapper.getFeedIdBundleByTag(keyword, rb);
			log.info(feedBundle.toString());
		} catch (Exception e) {
			e.printStackTrace();
			log.info("태그로 피드 아이디 한세트 얻어내기 sql 오류");
		}

		return feedBundle;
	}

	public UserVO getUserProfile(String keyword){

		UserVO userVO = null;

		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			userVO = mapper.getUserProfileByNickname(keyword);
		}
		catch (Exception e){
			e.printStackTrace();
			log.info("닉네임으로 유저찾기 sql오류");
		}

		return userVO;

	}

	public ArrayList<HashMap<String, Object>> getFeedBundleByNickname(String keyword){

		ArrayList<HashMap<String, Object>> feedBundle = null;

		try {
			TagsInFeedMapper mapper = session.getMapper(TagsInFeedMapper.class);
			feedBundle = mapper.getFeedBundleByNickname(keyword);
			log.info(feedBundle.toString());
		}
		catch (Exception e){
			e.printStackTrace();
		}

		return feedBundle;
	}



}
