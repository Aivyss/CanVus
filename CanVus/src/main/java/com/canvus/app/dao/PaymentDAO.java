package com.canvus.app.dao;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.canvus.app.dao.mapper.PaymentMapper;
import com.canvus.app.vo.BillVO;

@Repository
public class PaymentDAO {
	@Autowired
	SqlSession session;
	
	private static final Logger logger = LoggerFactory.getLogger(PaymentDAO.class);
	
	public boolean paymentSubmit(BillVO vo) {
		logger.info("PaymentDAO 거래처리 진입");
		boolean check = false;
		
		try {
			PaymentMapper mapper = session.getMapper(PaymentMapper.class);
			check = mapper.paymentSubmit(vo);
		} catch (Exception e) {
			logger.info("[PaymentDAO] 결제 정보 DB저장 실패");
		}
		
		return check;
	}
}
