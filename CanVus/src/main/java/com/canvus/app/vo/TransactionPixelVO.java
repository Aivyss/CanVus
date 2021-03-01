package com.canvus.app.vo;

import lombok.Data;

@Data
public class TransactionPixelVO implements CanVusVOs {
	private int transaction_id;
	private String sender;
	private String receiver;
	private int pixels_amount;
	private String transaction_date;

	// 편의성 추가 메소드
	private String sender_nickname;
	private String receiver_nickname;
}
