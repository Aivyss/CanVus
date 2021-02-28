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

			TagsInFeedMapper mapper2 = session.getMapper(TagsInFeedMapper.class);
			check = mapper2.inputTags(tif);
		} catch (Exception e) {
			log.info("태그넣기 sql오류");
		}
		return check;
	}
	
	/**
	 * 피드 내용 업데이트에 따른 태그 변경 메소드
	 * 작성일: 2021.01.24 / 완성일: / 버그검증일
	 * 작성자: 이한결
	 * @param tif
	 * @return
	 */
	public boolean updateTags(TagsInFeedVO tif) {
		boolean check = false;
		
		try {
			TagMapper mapper1 = session.getMapper(TagMapper.class);
			TagsInFeedMapper mapper2 = session.getMapper(TagsInFeedMapper.class);

			check = mapper1.addTags(tif);
			if (check) {
				check = mapper2.deleteTags(tif.getFeed_id());
				
				if (check) {
					check = mapper2.inputTags(tif);
				}
			}
		} catch (Exception e) {
			log.info("피드 수정에 의한 태그수정 sql 오류");
		}
		
		return check;
	}
}
