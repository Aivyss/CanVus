package com.canvus.app.dao;

import java.util.ArrayList;
import java.util.List;

import com.canvus.app.dao.mapper.FeedCommentMapper;
import com.canvus.app.dao.mapper.LikeMapper;
import com.canvus.app.drawing.vo.FeedVO;
import com.canvus.app.vo.FeedCommentVO;
import com.canvus.app.vo.FeedComponentVO;
import com.canvus.app.vo.LikeVO;
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

			for (FeedComponentVO one : bundle) {
				List<String> pictureURLs = new ArrayList<>();
				List<FeedDrawingsVO> pictures = mapper2.selectFeedBundle(one.getFeed_id());

				for (FeedDrawingsVO picture : pictures) {
					pictureURLs.add(picture.getPage_file_output());
				}

				one.setPictures(pictureURLs);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.info("피드 번들 가져오기 sql오류");
		}

		return bundle;
	}

	/**
	 * 피드의 개요정보를 가져오는 메소드
	 * 작성일: 2021.02.21 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param feed_id
	 * @return
	 */
    public FeedVO readFeedAbstract(String feed_id) {
    	FeedVO abs = null;

    	try {
    		FeedsMapper mapper = session.getMapper(FeedsMapper.class);
    		abs = mapper.readFeedAbstract(feed_id);
		} catch (Exception e) {
    		e.printStackTrace();
    		log.info("피드 개요정보 가져오기 sql오류");
		}

    	return abs;
    }

	/**
	 * 특정 피드의 그림정보를 전부 가져오는 메소드
	 * @param feed_id
	 * @return
	 */
	public List<FeedDrawingsVO> readFeedPictures(String feed_id) {
		List<FeedDrawingsVO> pictures = null;

		try {
			FeedDrawingsMapper mapper = session.getMapper(FeedDrawingsMapper.class);
			pictures = mapper.readFeedPictures(feed_id);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("피드 열람 그림 가져오기 sql 오류");
		}

		return pictures;
	}

	/**
	 * 읽는 피드의 댓글을 가져오는 메소드
	 * 작성일: 2021.02.21 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param feed_id
	 * @return
	 */
	public List<FeedCommentVO> readFeedComments(String feed_id) {
		List<FeedCommentVO> comments = null;

		try {
			FeedCommentMapper mapper = session.getMapper(FeedCommentMapper.class);
			comments = mapper.readFeedComments(feed_id);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("읽는 피드의 코멘트 가져오기 sql오류");
		}

		return comments;
	}

	/**
	 * 피드가 받은 like의 수를 셀렉하는 메소드
	 * 작성일: 2021.02.21 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param feed_id
	 * @return
	 */
	public int getLikeCount(String feed_id) {
		int count = 0;

		try {
			LikeMapper mapper = session.getMapper(LikeMapper.class);
			count = mapper.getLikeCount(feed_id);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("피드의 좋아요 총수를 산출하는 sql 오류");
		}

		return count;
	}

	public boolean getisLiked(String feed_id, String user_id) {
		LikeVO like = new LikeVO();
		like.setFeed_id(feed_id);
		like.setUser_id(user_id);
		boolean isLiked = false;

		try {
			LikeMapper mapper = session.getMapper(LikeMapper.class);
			like = mapper.getisLiked(like);

			if(like != null) {
				isLiked = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.info("보는 사람이 라이크를 눌렀는지 판단하는 sql오류");

		}

		return isLiked;
	}
	/**
	 * 특정 피드의 like를 증가시키는 메소드
	 * 작성일: 2021.02.22
	 * 작성자: 이한결
	 * @param params
	 */
    public void addLike(LikeVO likeVO) {
    	log.info("피드의 like를 증가시키는 dao 메소드 진입");

    	try {
			LikeMapper mapper = session.getMapper(LikeMapper.class);
			mapper.addLike(likeVO);
		} catch (Exception e) {
    		e.printStackTrace();
    		log.info("라이크 증가 sql오류");
		}
    }

	/**
	 * AJAX 통신
	 * 해당 피드에 like를 제거하는 메소드
	 * 작성일: 2021.02.22
	 * 작성자: 이한결
	 * @param params
	 */
	public void deleteLike(LikeVO likeVO) {
		log.info("피드의 like를 제거시키는 dao 메소드 진입");

		try {
			LikeMapper mapper = session.getMapper(LikeMapper.class);
			mapper.deleteLike(likeVO);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("라이크 제거 sql오류");
		}
	}
}
