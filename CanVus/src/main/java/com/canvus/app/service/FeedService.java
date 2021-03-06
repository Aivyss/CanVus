package com.canvus.app.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.canvus.app.dao.*;
import com.canvus.app.drawing.vo.FeedVO;
import com.canvus.app.util.PageNavigator;
import com.canvus.app.vo.*;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.util.Helper;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;

@Service
@Slf4j
public class FeedService {
	@Autowired
	private FeedDAO feedDAO;
	@Autowired
	private TagDAO tagDAO;
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private BookmarkDAO bookmarkDAO;
	@Autowired
	private HistoryDAO historyDAO;
	
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

	/**
	 * 피드를 열람하는 메소드
	 * 작성일: 2021.02.20 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param feed_id
	 * @param session
	 * @param model
	 * @return
	 */
	public String readFeed(String feed_id, HttpSession session, Model model) {
		String url = "feed/view";
		String user_id = (String) session.getAttribute("userId");

		try {
			FeedVO feedAbstract = feedDAO.readFeedAbstract(feed_id);
			// TODO 유저 닉네임 추출
			feedAbstract.setNickname1(userDAO.getUserNickname(feedAbstract.getUser_id1()));
			if (feedAbstract.getUser_id2() != null) {
				feedAbstract.setNickname2(userDAO.getUserNickname(feedAbstract.getUser_id2()));
				if (feedAbstract.getUser_id3() != null) {
					feedAbstract.setNickname3(userDAO.getUserNickname(feedAbstract.getUser_id3()));
					if (feedAbstract.getUser_id4() != null) {
						feedAbstract.setNickname4(userDAO.getUserNickname(feedAbstract.getUser_id4()));
					}
				}
			}
			// TODO 피드 그림들 불러오기
			List<FeedDrawingsVO> feedPictures = feedDAO.readFeedPictures(feed_id);
			// TODO 피드에 달린 코멘트 불러오기
			List<FeedCommentVO> feedComments = feedDAO.readFeedComments(feed_id);
			List<BookmarkVO> bookmarks = null;
			boolean isLiked = false;
			if (user_id != null) {
				// TODO 유저의 북마크 리스트 불러오기
				bookmarks = bookmarkDAO.getBookmarkList(user_id);
				// TODO 히스토리에 열람 이력 추가 메소드
				HistoryVO hisVO = new HistoryVO();
				hisVO.setUser_id(user_id);
				hisVO.setFeed_id(feed_id);
				historyDAO.addHistory(hisVO);
				// TODO 라이크 판단 여부
				isLiked = feedDAO.getisLiked(feed_id, user_id);
			}
			int likeCount = feedDAO.getLikeCount(feed_id);



			// TODO 모델에 값넣기
			model.addAttribute("feedAbstract", feedAbstract);
			model.addAttribute("feedPictures", feedPictures);
			model.addAttribute("feedComments", feedComments);
			model.addAttribute("likeCount", likeCount);
			model.addAttribute("isLiked", isLiked);
			if (bookmarks != null) {
				model.addAttribute("bookmarks", bookmarks);
			}
		} catch (Exception e) {
			log.info("sql문중에 하나 이상의 오류");
			url = "redirect:/";
		}

		return url;
    }

	/**
	 * 특정 피드의 like를 증가시키는 메소드
	 * 작성일: 2021.02.22
	 * 작성자: 이한결
	 * @param params
	 */
	public void addLike(Map<String, Object> params) {
		log.info("피드의 like 증가 서비스 메소드 진입");
		LikeVO likeVO = new LikeVO();

		likeVO.setUser_id((String) params.get("user_id"));
		likeVO.setFeed_id((String) params.get("feed_id"));

		feedDAO.addLike(likeVO);
	}

	/**
	 * AJAX 통신
	 * 해당 피드에 like를 제거하는 메소드
	 * 작성일: 2021.02.22
	 * 작성자: 이한결
	 * @param params
	 */
	public void deleteLike(Map<String, Object> params) {
		log.info("피드의 like 삭제 서비스 메소드 진입");
		LikeVO likeVO = new LikeVO();

		likeVO.setUser_id((String) params.get("user_id"));
		likeVO.setFeed_id((String) params.get("feed_id"));

		feedDAO.deleteLike(likeVO);
	}

	/**
	 * 로그인 화면에서 보이는 프리뷰
	 * 작성일:2021.02.24
	 * 작성자: 이한결
	 * @return
	 * @param model
	 */
    public void homePreview(Model model) {
		List<FeedComponentVO> previews = feedDAO.homePreview();
		
		model.addAttribute("previews", previews);
		model.addAttribute("navi", null);
		log.info(previews.toString());
    }

	public void homePreview(Model model, UserVO userVO, int page) {

		int countPerPage = 4;
		int pagePerGroup = 5;

		String user_id = (String) userVO.getUser_id();

		int total = feedDAO.getFeedTotalCountLogin(user_id);
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());

		ArrayList<HashMap<String, Object>> previews = feedDAO.homePreviewLogin(rb, user_id);

		model.addAttribute("previews", previews);
		model.addAttribute("navi", navi);
	}

	/**
	 * 피드 삭제 메소드
	 * 20210305
	 * 이한결
	 * @param feedInfo
	 * @param session
	 */
    public String deleteFeed(FeedComponentVO feedInfo, HttpSession session) {
    	log.info("피드 삭제 서비스 메소드 진입");

    	String url = "redirect:/";
    	String userId = (String) session.getAttribute("userId");
    	String feedOwner = feedInfo.getUser_id1();

    	log.info("feed_id {}", feedInfo.getFeed_id());
    	
    	// TODO 유효성 이차검증
    	if (feedOwner.equals(userId)) {
    		feedDAO.deleteFeed(feedInfo);
		}

    	return url;
    }
}
