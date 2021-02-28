package com.canvus.app.vo;

import lombok.Data;

@Data
public class BillVO implements CanVusVOs {
	private String imp_uid;
	private String merchant_uid;
	private int paid_amount;
	private String user_id;
	private int pixel;
	private String apply_num;
	private int inputdate;
}
