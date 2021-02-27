package com.canvus.app.service;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.canvus.app.dao.*;
import com.canvus.app.util.PageNavigator;
import com.canvus.app.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.canvus.app.util.FileService;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

@Slf4j
@Service
public class UserService {
	// 구글 로그인 API키
	private final String CLIENT_ID = "1073968802049-evh62jql0f6gblp8din0t6rqv0sobg17.apps.googleusercontent.com";

	// 페이징 처리 (board 페이지용)
	private final int COUNT_PER_PAGE = 8;
	private final int PAGE_PER_GROUP = 5;

	//프로필 업로드 경로
	private String uploadPath = "/userProfile";

	
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private FeedDAO feedDAO;
	@Autowired
	private BookmarkDAO bookmarkDAO;
	@Autowired
	private FollowingsService followingsService;
	@Autowired
	private PixelDAO pixelDAO;

	/**
	 * login business logic
	 * 최초작성일: 2021.01.01 (?) / 수정일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param idToken
	 * @return user id in DB
	 */
	public UserVO login(String idToken) {
		log.info("로그인 서비스 진입");
		
		Payload payload = loginSignuplogic(idToken);
		
		return userDAO.getUserInfo(payload.getSubject());
	}
	
	public UserVO signup(UserVO vo, MultipartFile photo_upload) {
		log.info("회원가입 서비스 진입");
		
		UserVO output = null;
		Payload payload = loginSignuplogic(vo.getIdToken());
		
		// 정보를 payload로부터 추가, 닉네임은 프론트로부터 받아왔다.
		vo.setEmail(payload.getEmail());
		vo.setFamily_name((String) payload.get("family_name"));
		vo.setGiven_name((String) payload.get("given_name"));
		if (photo_upload.isEmpty()) {
			vo.setProfile_photo("");
		} else {
			String saved_file = FileService.saveFile(photo_upload, uploadPath, (String) payload.getSubject());
			vo.setProfile_photo(saved_file);
		}
		vo.setUser_id((String) payload.getSubject());
		
		log.info(vo.toString());
		
		boolean check = userDAO.signup(vo);
		
		if (check) {
			output = vo;
		}
		
		return output;
	}
	
	/**
	 * 구글 Oath 를 이용해 받은 토큰을 파싱하는 메소드
	 * 작성일: 2021.01 / 수정일: 2021.01.23 /완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param idToken
	 * @return
	 */
	public Payload loginSignuplogic(String idToken) {
		JacksonFactory jsonFactory = JacksonFactory.getDefaultInstance();
		HttpTransport transport = null;
		GoogleIdToken token = null;
		
		try {
			transport = GoogleNetHttpTransport.newTrustedTransport();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
				.setAudience(Collections.singletonList(CLIENT_ID)).build();
		
		try {
			token = verifier.verify(idToken);
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return token.getPayload();
	}

	/**
	 * 픽셀을 선물하는 메소드
	 * 작성일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param params (key: sender, receiver, pixel)
	 * @return
	 */
	public Map<String, Object> presentPixel(Map<String, Object> params) {
		TransactionPixelVO transPx = CanVusVOFactory.newInstance(CanVusVOType.TransactionPixelVO);
		
		transPx.setSender((String) params.get("sender"));
		transPx.setReceiver((String) params.get("receiver"));
		transPx.setPixels_amount((Integer) params.get("pixel"));
		
		boolean success = pixelDAO.presentPixel(transPx);
		
		if (success) {
			params.put("result", true);
		} else {
			params.put("result", false);
		}
		
		return params; 
	}

	/**
	 * 특정 회원의 보드로 이동하는 메소드
	 * 작성일: 2021.02.18 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 *
	 * @param page
	 * @param user_id
	 * @param model
	 * @return
	 */
    public String board(String user_id, Model model) {
    	String url = null;

    	int totalRecordsCount = feedDAO.getFeedTotalCount(user_id);
		PageNavigator pNav = new PageNavigator(COUNT_PER_PAGE, PAGE_PER_GROUP, 1, totalRecordsCount);

		// TODO 보드의 주인의 정보를 가져오는 파트
		UserVO userInfo = userDAO.getUserInfo(user_id);

		// TODO 피드 정보를 받아오는 파트
		List<FeedComponentVO> bundle =  feedDAO.selectFeedBundle(user_id, pNav.getStartRecord(), COUNT_PER_PAGE);

		// TODO 팔로우 정보를 받아오는 파트
		Map<String, Object> followInfoPack = followingsService.getFollowInfo(user_id);

		// TODO 북마크 정보를 받아오는 파트
		List<BookmarkVO> bookmarks = bookmarkDAO.getBookmarkList(user_id);

		// TODO 받아온 정보를 모델에 넣는다.
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("bundle", bundle);
		model.addAttribute("followInfoPack", followInfoPack);
		model.addAttribute("bookmarks", bookmarks);
		model.addAttribute("totalPageCount", pNav.getTotalPageCount());

		if (bundle != null) {
			url = "user/board";
		} else {
			url = "redirect:/";
		}

    	return url;
    }

	/**
	 * 더보기 버튼을 누를 시 피드 번들을 하나 더 가지고 오는 메소드
	 * 20210225
	 * 이한결
	 * @param params
	 * @return
	 */
	public Map<String, Object> restSeeMore(Map<String, Object> params) {
		log.info("더불러오기 서비스 메소드 진입");
		String user_id = (String) params.get("user_id");
		int currentPage = (Integer) params.get("currentPage");

		// TODO 피드번들을 하나 더 셀렉하는 과정
		int totalRecordsCount = feedDAO.getFeedTotalCount(user_id);
		PageNavigator pNav = new PageNavigator(COUNT_PER_PAGE, PAGE_PER_GROUP, currentPage, totalRecordsCount);
		List<FeedComponentVO> bundle =  feedDAO.selectFeedBundle(user_id, pNav.getStartRecord(), COUNT_PER_PAGE);

		// TODO 북마크 정보를 받아오는 파트
		List<BookmarkVO> bookmarks = bookmarkDAO.getBookmarkList(user_id);

		params.put("bundle", bundle);
		params.put("bookmarks", bookmarks);
		log.info(bundle.toString());
		log.info(bookmarks.toString());

		return params;
	}

	/**
	 * 닉네임 중복검사 서비스 메소드
	 * 20210227
	 * 이한결
	 * @param params
	 * @return
	 */
	public boolean checkDuplicateNickname(Map<String, Object> params) {
		String nickname = (String) params.get("nickname");
		return userDAO.checkDuplicateNickname(nickname);
	}
}