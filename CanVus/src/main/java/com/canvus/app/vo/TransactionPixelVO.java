package com.canvus.app.vo;

import lombok.Data;

@Data
public class TransactionPixelVO implements CanVusVOs {
	private int transaction_id;
	private String sender;
	private String receiver;
	private int pixels_amount;
	private String transaction_date;
}
