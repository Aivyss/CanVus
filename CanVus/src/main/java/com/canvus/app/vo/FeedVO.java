package com.canvus.app.vo;

import lombok.Data;

/**
 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
 * @author 이한결
 *
 */
@Data
public class FeedVO implements CanVusVOs {
	// 테이블에 있는 컬럼과 매핑되는 멤버변수
	private String feed_id;
	private String user_id1;
	private String user_id2;
	private String user_id3;
	private String user_id4;
	private String context;
	private String inputdate;
	
	// 배너 그림을 위해서 마련된 부가 멤버변수
	private String original_page_name;
	private String server_page_name;
}
