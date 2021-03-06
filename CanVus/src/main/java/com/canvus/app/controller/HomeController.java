package com.canvus.app.controller;

import com.canvus.app.service.FeedService;
import com.canvus.app.vo.UserVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Slf4j
@Controller
public class HomeController {
	@Autowired
	private FeedService feedService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session, @RequestParam(defaultValue = "1")int page) {
		log.info("call home page");
		UserVO userVO = (UserVO) session.getAttribute("userVO");

		if (userVO == null) {
			feedService.homePreview(model);
		}
		else{
			feedService.homePreview(model, userVO, page);
		}


		return "home";
	}
}