package com.canvus.app.dao;

import java.util.ArrayList;
import java.util.List;

import com.canvus.app.drawing.vo.FeedVO;
import com.canvus.app.vo.FeedComponentVO;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.canvus.app.dao.mapper.FeedDrawingsMapper;
import com.canvus.app.dao.mapper.FeedsMapper;
import com.canvus.app.vo.FeedDrawingsVO;

import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;

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
			e.printStackTrace();
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
	
	/**
	 * 아이디와 일치하는 피드의 정보를 가져오는 메소드
	 * 작성일: 2021.01.24 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param feed_id
	 * @return
	 */
	public FeedVO selectFeed(String feed_id) {
		FeedVO dbData = null;
		
		try {
			FeedsMapper mapper = session.getMapper(FeedsMapper.class);
			dbData = mapper.selectFeed(feed_id);
		} catch (Exception e) {
			log.info("아이디로 피드 셀렉트 sql오류");
		}
		
		return dbData;
	}

	public boolean updateFeed(FeedVO feed) {
		boolean check = false;
		
		try {
			FeedsMapper mapper = session.getMapper(FeedsMapper.class);
			check = mapper.updateFeed(feed);
		} catch (Exception e) {
			log.info("피드 수정 sql오류");
		}
		
		return check;
	}

	/**
	 * 해당 유저가 그린 피드의 갯수를 산출하는 메소드
	 * 작성일: 2021.02.18 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param user_id
	 * @return
	 */
    public int getFeedTotalCount(String user_id) {
    	int count = 0;

    	try {
			FeedsMapper mapper = session.getMapper(FeedsMapper.class);
			count = mapper.getFeedTotalCount(user_id);
		} catch (Exception e) {
    		e.printStackTrace();
    		log.info("피드 갯수 산출 sql오류");
		}

    	return count;
    }

	/**
	 * 해당유저의 보드의 n번째 페이지에 해당하는 피드를 가져오는 메소드
	 * 작성일: 2021.02.18 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param user_id
	 * @param startRecord
	 * @param countPerPage
	 */
	@Transactional(rollbackFor = {Exception.class})
	public List<FeedComponentVO> selectFeedBundle(String user_id, int startRecord, int countPerPage) {
		List<FeedComponentVO> bundle = null;
		RowBounds rb = new RowBounds(startRecord, countPerPage);

		try {
			FeedsMapper mapper1 = session.getMapper(FeedsMapper.class);
			FeedDrawingsMapper mapper2 = session.getMapper(FeedDrawingsMapper.class); // 차후 진행
			bundle = mapper1.selectFeedBundle(rb, user_id);

			// 이해할 수 없는 잡버그로 주석처리
			for (FeedComponentVO one : bundle) {
				List<String> pictureURLs = new ArrayList<>();
				log.info(one.getFeed_id());
				List<FeedDrawingsVO> pictures = mapper2.selectFeedBundle(one.getFeed_id());

				for (FeedDrawingsVO picture : pictures) {
					pictureURLs.add(picture.getPage_file_output());
				}
				log.info(pictureURLs.toString());

				one.setPictures(pictureURLs);
				pictureURLs = null;
				pictures = null;
			}

//			for (int i=0; i<bundle.size(); i++) {
//				List<String> pictureURLs = new ArrayList<>();
//				List<FeedDrawingsVO> pictures = mapper2.selectFeedBundle(bundle.get(i).getFeed_id());
//
//				for (int j=0; j<pictures.size(); j++) {
//
//					pictureURLs.add(pictures.get(j).getPage_file_output());
//				}
//
//				bundle.get(i).setPictures(pictureURLs);
//			}
		} catch (Exception e) {
			e.printStackTrace();
			log.info("피드 번들 가져오기 sql오류");
		}

		return bundle;
	}
}
