package com.canvus.app.service;

import java.util.List;

import com.canvus.app.dao.FeedDAO;
import com.canvus.app.util.PageNavigator;
import com.canvus.app.vo.FeedComponentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.dao.SearchDAO;
import com.canvus.app.vo.UserVO;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;

@Service
@Slf4j
public class SearchService {
	@Autowired
	private SearchDAO searchDAO;
	@Autowired
	private FeedDAO feedDAO;

	// 페이징 처리
	private final int COUNT_PER_PAGE = 6;
	private final int PAGE_PER_GROUP = 5;
	
	/**
	 * 틀 제작일: 2021.01.13 / 작성완료일: 2021.01.14 / 버그검증완료:
	 * 작성자: 이한결
	 * @param
	 * @param model
     * @return
	 */
	public String tagSearch(String keyword, Model model) {
		log.info("s-service 태그검색 진입");
		String url = "redirect:/search/noResult";

		// 페이징 처리 어차피 첫검색 화면이라 1이다..
		int feedCount = searchDAO.feedCountReferToTag(keyword);

		if (feedCount > 0) {
			PageNavigator pNav = new PageNavigator(COUNT_PER_PAGE, PAGE_PER_GROUP, 1, feedCount);
			List<FeedComponentVO> idBundle = searchDAO.getFeedIdBundleByTag(keyword, pNav.getStartRecord(), COUNT_PER_PAGE);

			if(!idBundle.isEmpty()) {
				List<FeedComponentVO> feedBundle = searchDAO.getFeedsBundleByIdList(idBundle);
				model.addAttribute("feedBundle", feedBundle);
				url = "search/result";
			}
		}

		return url;
	}
	/**
	 * 틀 제작일: 2021.01.13 / 완성일: 2021.01.14 / 버그 검증완료:
	 * 작성자: 이한결
	 * @param search
	 * @param model
	 * @return
	 */
	public String userSearch(String search, Model model) {
		log.info("s-service 유저검색 진입");
		String url = "redirect:/search/noResult";

		List<UserVO> searchResult = searchDAO.userSearch(search);
		model.addAttribute("searchUserList", searchResult);
		
		return url;
	}

}
