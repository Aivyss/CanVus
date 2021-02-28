package com.canvus.app.dao.mapper;

import com.canvus.app.vo.BillVO;

public interface PaymentMapper {
	
	public boolean paymentSubmit(BillVO vo);
}
