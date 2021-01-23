package com.canvus.app.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.canvus.app.dao.mapper.FeedDrawingsMapper;
import com.canvus.app.dao.mapper.FeedsMapper;
import com.canvus.app.vo.FeedDrawingsVO;
import com.canvus.app.vo.FeedVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class FeedDAO {
	@Autowired
	SqlSession session;
	
	/**
	 * 각종 페이지에서 피드의 한묶음씩 가져오는 메소드 (미완).
	 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param user_id
	 * @param startRecord
	 * @param countPerPage
	 * @return
	 */
	public List<FeedVO> getFeedBundle(String user_id, int startRecord, int countPerPage) {
		List<FeedVO> feedBundle = null;
		
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		
		try {
			FeedsMapper mapper = session.getMapper(FeedsMapper.class);
			feedBundle = mapper.getFeedBundle(rb, user_id);
		} catch (Exception e) {
			log.info("피드 번들 sql 오류");
		}
		
		return feedBundle;
	}

	/**
	 * FEEDS 테이블의 한줄을 추가하는 메소드
	 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param feedVO
	 * @return
	 */
	public boolean createFeedTableRow(FeedVO feedVO) {
		boolean check = false;
		
		try {
			FeedsMapper mapper= session.getMapper(FeedsMapper.class);
			check =mapper.createFeedTableRow(feedVO);
		} catch (Exception e) {
			log.info("FEEDS 테이블 로우추가 SQL 오류");
		}
		
		return check;
	}
	
	/**
	 * 해당피드에 넣어야 하는 그림들을 feed_drawings 테이블에 삽입하는 메소드
	 * 작성일: 2021.01.23 / 완료일: / 버그검증일:
	 * 작성자: 이한결
	 * @param feedDrawings
	 * @return
	 */
	public boolean createFeedDrawingsRows(FeedDrawingsVO feedDrawings) {
		boolean check = false;
		
		try {
			FeedDrawingsMapper mapper = session.getMapper(FeedDrawingsMapper.class);
			check = mapper.createFeedDrawingsRows(feedDrawings);
		} catch (Exception e) {
			log.info("Feed_Drawings 삽입실패");
		}
		return check;
	}
	
	
}
