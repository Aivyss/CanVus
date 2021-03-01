package com.canvus.app.dao.mapper;

import com.canvus.app.vo.BillVO;

import java.util.List;

public interface PaymentMapper {
	
	public boolean paymentSubmit(BillVO vo);

    List<BillVO> getPaymentHistory(String userId);
}
