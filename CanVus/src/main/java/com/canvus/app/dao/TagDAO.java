package com.canvus.app.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.canvus.app.dao.mapper.TagMapper;
import com.canvus.app.dao.mapper.TagsInFeedMapper;
import com.canvus.app.vo.TagsInFeedVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class TagDAO {
	@Autowired
	SqlSession session;
	
	/**
	 * 파싱한 태그를 해당 테이블들에 삽입하는 메소드.
	 * 작성일: 2021.01.24 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param tif
	 * @return
	 */
	public boolean inputTags(TagsInFeedVO tif) {
		boolean check = false;
		
		try {
			TagMapper mapper1 = session.getMapper(TagMapper.class);
			check = mapper1.addTags(tif);

			if (check) {
				TagsInFeedMapper mapper2 = session.getMapper(TagsInFeedMapper.class);
				check = mapper2.inputTags(tif);
			}
		} catch (Exception e) {
			log.info("태그넣기 sql오류");
		}
		return check;
	}
	
	
}
