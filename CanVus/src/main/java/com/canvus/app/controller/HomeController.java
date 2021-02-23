package com.canvus.app.controller;

import com.canvus.app.service.FeedService;
import com.canvus.app.vo.UserVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@Controller
public class HomeController {
	@Autowired
	private FeedService feedService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		log.info("call home page");
		UserVO userVO = (UserVO) session.getAttribute("userVO");

		if (userVO == null) {
			feedService.homePreview(model);
		}

		return "home";
	}
}