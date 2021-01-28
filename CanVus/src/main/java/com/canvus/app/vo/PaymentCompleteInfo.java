package com.canvus.app.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString
public class PaymentCompleteInfo implements CanVusVOs {
	private String imp_uid;
	private String merchant_uid;
	private String paid_amount;
	private String apply_num;
}
