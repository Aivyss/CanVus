package com.canvus.app.dao;

import java.util.ArrayList;
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
	
	/**
	 * 틀 제작일: 2021.01.13 / 완성일: 2021.01.14 / 버그 검증완료:
	 * 작성자: 이한결
	 * @param search
	 * @return
	 */
	public List<TagsInFeedVO> tagSearch(String search) {
		log.info("태그 서치 DAO");
		List<TagsInFeedVO> searchResultList = null;
		
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

	/**
	 * 페이징 처리를 위해서 해당 태그의 피드의 갯수를 산출하는 메소드
	 * @param keyword
	 * @return
	 */
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

	/**
	 * 페이징을 고려하여 해당 태그 키워드로 피드 아이디를 한묶음 셀렉하는 메소드
	 *
	 * @param keyword
	 * @param startRecord
	 * @param count_per_page
	 * @return
	 */
	public List<FeedComponentVO> getFeedIdBundleByTag(String keyword, int startRecord, int count_per_page) {
		List<FeedComponentVO> idBundle = null;
		RowBounds rb = new RowBounds(startRecord, count_per_page);

		try {
			TagsInFeedMapper mapper = session.getMapper(TagsInFeedMapper.class);
			idBundle = mapper.getFeedIdBundleByTag(keyword);
			log.info(idBundle.toString());
		} catch (Exception e) {
			e.printStackTrace();
			log.info("태그로 피드 아이디 한세트 얻어내기 sql 오류");
		}

		return idBundle;
	}

	/**
	 * 한 묶음의 셀렉된 피드 아이디를 이용해 각각의 전체 정보를 가져오는 메소드
	 * @param idBundle
	 * @return
	 */
	public List<FeedComponentVO> getFeedsBundleByIdList(List<FeedComponentVO> idBundle) {
		List<FeedComponentVO> feedBundle = null;
		
		try {
			FeedsMapper mapper = session.getMapper(FeedsMapper.class);
			feedBundle = mapper.getFeedsBundleByIdList(idBundle);

			log.info(feedBundle.toString());

			FeedDrawingsMapper mapper2 = session.getMapper(FeedDrawingsMapper.class); // 차후 진행
			for (FeedComponentVO one : feedBundle) {
				List<String> pictureURLs = new ArrayList<>();
				List<FeedDrawingsVO> pictures = mapper2.selectFeedBundle(one.getFeed_id());

				for (FeedDrawingsVO picture : pictures) {
					pictureURLs.add(picture.getPage_file_output());
				}

				log.info(pictureURLs.toString());
				one.setPictures(pictureURLs);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.info("아이디 리스트로 피드를 묶음으로 검색 sql 오류");
		}

		return feedBundle;
	}
}
