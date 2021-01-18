package com.canvus.app.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.canvus.app.dao.mapper.TagMapper;
import com.canvus.app.dao.mapper.UserMapper;
import com.canvus.app.vo.TagVO;
import com.canvus.app.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class SearchDAO {
	@Autowired
	SqlSession session;
	
	/**
	 * 틀 제작일: 2021.01.13 / 완성일: 2021.01.14 / 버그 검증완료:
	 * 작성자: 이한결
	 * @param search
	 * @return
	 */
	public List<TagVO> tagSearch(String search) {
		log.info("태그 서치 DAO");
		List<TagVO> searchResultList = null;
		
		try {
			// tif_id, 피드아이디, 태그 이름 셀렉
			TagMapper mapper = session.getMapper(TagMapper.class);
			searchResultList = mapper.tagSearch(search);
			
		} catch (Exception e) {
			log.info("태그 서치 sql 실패");
		}
		
		return searchResultList;
	}
	
	/**
	 * 틀 제작일: 2021.01.13 / 완성일: 2021.01.14 / 버그 검증완료:
	 * 작성자: 이한결
	 * @param search
	 * @return
	 */
	public List<UserVO> userSearch(String search) {
		log.info("user Search DAO");
		List<UserVO> userList = null;
		
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			userList = mapper.userSearch(search);
		} catch (Exception e) {
			log.info("유저 서치 sql 오류");
		}
		
		return userList;
	}
}
