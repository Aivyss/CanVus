package com.canvus.app.service;

import java.util.Map;

import com.canvus.app.util.Helper;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.dao.PaymentDAO;
import com.canvus.app.vo.BillVO;
import com.canvus.app.vo.CanVusVOFactory;
import com.canvus.app.vo.CanVusVOType;

import javax.servlet.http.HttpSession;
@Slf4j
@Service
public class PaymentService {
	@Autowired
	private PaymentDAO paymentDAO;
	
	/**
	 * 머천트 uid 생성 서비스 메소드
	 * 20210228
	 * 이한결
	 * @return ccryptonized merchant uid
	 */
	public Map<String, Object> merchantUidParse(Map<String, Object> params, HttpSession session) {
		log.info("서비스파트 머천트 uid 생성 서비스 메소드");

		int pixel = (Integer) params.get("pixel");
		String userId = (String) session.getAttribute("userId");

		String merchantId = Helper.merchantIdGenerator(userId, pixel);
		params.put("merchant_uid", merchantId);

		return params;
	}
	
	/**
	 * 결제 완료 정보를 받아서 DAO -> DB로 전달한 뒤 성공 여부를 반환
	 * 
	 * @return 결제가 DB에 저장되었는지 여부
	 */
	public boolean paymentSubmit(Map<String, Object> params) {
		log.info("결제 승인 서비스 메소드 진입");
		BillVO vo = new BillVO();

		vo.setImp_uid((String) params.get("imp_uid"));
		vo.setMerchant_uid((String) params.get("merchant_uid"));
		vo.setPaid_amount((Integer)params.get("paid_amount"));
		vo.setApply_num((String) params.get("apply_num"));
		vo.setUser_id((String) params.get("user_id"));
		vo.setPixel((Integer) params.get("pixel"));
		vo.setInputdate((Integer) params.get("inputdate"));

		return paymentDAO.paymentSubmit(vo);
	}
}
