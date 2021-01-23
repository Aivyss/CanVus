package com.canvus.app.vo;

import lombok.Data;

/**
 * Followings 테이블에 대응하는 DTO
 * 작성일: 2021.01.23 / 완성일: 2021.01.23 / 버그검증일:
 * @author 이한결
 *
 */
@Data
public class FollowingsVO {
	// 테이블 내 컬럼들
	private int f_id;
	private String user_id;
	private String following_id;
	
	// 테이블 이외에 join으로 가져온 컬럼들
	private String profile_photo;
}
