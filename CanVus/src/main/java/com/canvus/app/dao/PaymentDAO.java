package com.canvus.app.dao;

import com.canvus.app.dao.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.canvus.app.dao.mapper.PaymentMapper;
import com.canvus.app.vo.BillVO;

@Slf4j
@Repository
public class PaymentDAO {
	@Autowired
	SqlSession session;

	public boolean paymentSubmit(BillVO vo) {
		log.info("PaymentDAO 거래처리 dao 메소드 진입 ");
		boolean check = false;
		
		try {
			PaymentMapper mapper = session.getMapper(PaymentMapper.class);
			check = mapper.paymentSubmit(vo);

			if (check) {
				UserMapper mapper2 = session.getMapper(UserMapper.class);
				check = mapper2.updatePaymentPixels(vo);
			}
		} catch (Exception e) {
			log.info("[PaymentDAO] 결제 정보 DB저장 실패");
			e.printStackTrace();
		}
		
		return check;
	}
}
