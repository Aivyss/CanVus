package com.canvus.app.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.canvus.app.dao.FeedDAO;
import com.canvus.app.util.PageNavigator;
import com.canvus.app.vo.FeedComponentVO;
import org.apache.ibatis.session.RowBounds;
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

	public void search(int type, String keyword, Model model, int page){

		switch (type){
			case 0:
				//Hash Case
				//#tag라고 검색하면 피드 검색
				//라이크, 날짜
				//태그 검색: 피드 프리뷰

				keyword = "#" + keyword;

				PageNavigator navi = new PageNavigator(COUNT_PER_PAGE, PAGE_PER_GROUP, page, searchDAO.feedCountReferToTag(keyword));
				RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());

				model.addAttribute("tag", (String) keyword);
				model.addAttribute("feedBundle", searchDAO.getFeedIdBundleByTag(keyword, rb));

				break;

			case 1:
				//User Case
				//Tag라고 검색하면 tag라는 닉네임의
				//라이크, 날짜
				//유저 검색: 프로필, 닉네임, 피드 5개

				keyword = keyword.split("keyword=")[1];

				model.addAttribute("nickname", (String) keyword);
				model.addAttribute("profile", (String) searchDAO.getUserProfile(keyword));
				model.addAttribute("feedBundle", searchDAO.getFeedBundleByNickname(keyword));

				break;
		}
	}




}
