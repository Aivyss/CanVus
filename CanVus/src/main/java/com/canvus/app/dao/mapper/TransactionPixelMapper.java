package com.canvus.app.dao.mapper;

import com.canvus.app.vo.TransactionPixelVO;

import java.util.List;

public interface TransactionPixelMapper {

	public boolean presentPixel(TransactionPixelVO transPx);

    List<TransactionPixelVO> getTransactionHistory(String userId);
}
