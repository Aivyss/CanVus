package com.canvus.app.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
사용자 로그인 확인 인터셉터
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	//콘트롤러의 메서드 실행 전에 처리
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//세션의 로그인 정보 읽기
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("userId");
		
		//로그인되지 않은 경우 메인 페이지로 이동
		if (loginId == null) {
			//request.getContextPath()
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		//로그인 된 경우 요청한 경로로 진행
		return super.preHandle(request, response, handler);
	}

}
