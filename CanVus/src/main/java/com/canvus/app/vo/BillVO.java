package com.canvus.app.vo;

import lombok.Data;

@Data
public class BillVO {
	private int bill_num;
	private String imp_uid;
	private String merchant_uid;
	private int	paid_amount;
	private String apply_num;
	private String user_id;
	private int pixel;
	private String date;
}
