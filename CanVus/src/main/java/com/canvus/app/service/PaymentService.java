package com.canvus.app.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.canvus.app.dao.PaymentDAO;
import com.canvus.app.vo.BillVO;
import com.canvus.app.vo.CanVusVOFactory;
import com.canvus.app.vo.CanVusVOType;

@Service
public class PaymentService {
	@Autowired
	private BCryptPasswordEncoder encoder;
	@Autowired
	private PaymentDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(PaymentService.class);
	
	/**
	 * 머천트 uid 암호화작업
	 * 
	 * @param request
	 * @return ccryptonized merchant uid
	 */
	public String merchantUidParse(Map<String, String> params) {
		logger.info("서비스파트 머천트 uid 파싱");
		// 원본데이터: 유저아이디+상품명+2020-01-10 hh:mm
		return encoder.encode(params.get("merchant_uid"));
	}
	
	/**
	 * 결제 완료 정보를 받아서 DAO -> DB로 전달한 뒤 성공 여부를 반환
	 * 
	 * @param request
	 * @return 결제가 DB에 저장되었는지 여부
	 */
	public boolean paymentSubmit(Map<String, String> params) {
		logger.info("서비스파트 결제결과 전송");
		
		BillVO vo = CanVusVOFactory.newInstance(CanVusVOType.BillVO);
		
		vo.setImp_uid(params.get("imp_uid"));
		vo.setMerchant_uid(params.get("merchant_uid"));
		vo.setApply_num(params.get("apply_num"));
		vo.setPaid_amount(Integer.parseInt(params.get("paid_amount")));
		vo.setPixel(Integer.parseInt(params.get("pixel")));
		vo.setUser_id(params.get("user_id"));
		vo.setBillDate(params.get("date")); // 유닉스 타임스탬프
		
		// 값 테스트
		logger.info(vo.getImp_uid());
		logger.info(vo.getMerchant_uid());
		logger.info(vo.getApply_num());
		logger.info(String.valueOf(vo.getPaid_amount()));
		logger.info(String.valueOf(vo.getPixel()));
		logger.info(vo.getUser_id());
		logger.info(vo.getBillDate());
		
		return dao.paymentSubmit(vo);
	}
}
