package com.canvus.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.dao.SearchDAO;
import com.canvus.app.vo.TagVO;
import com.canvus.app.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SearchService {
	@Autowired
	private SearchDAO searchDAO;
	
	/**
	 * 틀 제작일: 2021.01.13 / 작성완료일: 2021.01.14 / 버그검증완료:
	 * 작성자: 이한결
	 * @param search
	 * @return
	 */
	public List<TagVO> tagSearch(String search) {
		log.info("s-service 태그검색 진입");
		
		return searchDAO.tagSearch(search);
	}
	
	/**
	 * 틀 제작일: 2021.01.13 / 완성일: 2021.01.14 / 버그 검증완료:
	 * 작성자: 이한결
	 * @param search
	 * @return
	 */
	public List<UserVO> userSearch(String search) {
		log.info("s-service 유저검색 진입");
		
		return searchDAO.userSearch(search);
	}

}
