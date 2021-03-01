package com.canvus.app.dao;

import com.canvus.app.dao.mapper.TransactionPixelMapper;
import com.canvus.app.dao.mapper.UserMapper;
import com.canvus.app.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.canvus.app.dao.mapper.PaymentMapper;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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

	/**
	 * 픽셀을 선물하는 메소드
	 * 작성일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param transPx
	 * @return
	 */
	@Transactional(rollbackFor = {Exception.class})
	public boolean presentPixel(TransactionPixelVO transPx) {
		boolean check = false;
		UserVO sender = CanVusVOFactory.newInstance(CanVusVOType.UserVO);
		UserVO receiver = CanVusVOFactory.newInstance(CanVusVOType.UserVO);
		sender.setUser_id(transPx.getSender());
		sender.setPixels(transPx.getPixels_amount());
		receiver.setUser_id(transPx.getReceiver());
		receiver.setPixels(transPx.getPixels_amount());

		try {
			TransactionPixelMapper transPxMapper = session.getMapper(TransactionPixelMapper.class);
			UserMapper userMapper = session.getMapper(UserMapper.class);
			userMapper.withdrawPixel(sender);
			userMapper.depositPixel(receiver);
			check = transPxMapper.presentPixel(transPx);
		} catch (Exception e) {
			log.info("픽셀 선물 sql오류");
			e.printStackTrace();
		}

		return check;
	}

	/**
	 * 당월 결제내역 조회
	 * 20210301
	 * 이한결
	 * @param userId
	 * @return
	 */
    public List<BillVO> getPaymentHistory(String userId) {
		List<BillVO> billList = null;
		
		try {
			PaymentMapper mapper = session.getMapper(PaymentMapper.class);
			billList = mapper.getPaymentHistory(userId);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("당월 결제 내역 sql조회 실패");
		}

		return billList;
    }

	/**
	 * 당월 픽셀 이동 내역 조회
	 * 20210301
	 * 이한결
	 * @param userId
	 * @return
	 */
	public List<TransactionPixelVO> getTransactionHistory(String userId) {
		List<TransactionPixelVO> trnxList = null;

		try {
			TransactionPixelMapper mapper = session.getMapper(TransactionPixelMapper.class);
			trnxList = mapper.getTransactionHistory(userId);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("이동내역 조회 실패");
		}

		return trnxList;
	}
}
