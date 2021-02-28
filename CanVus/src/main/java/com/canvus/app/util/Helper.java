package com.canvus.app.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.RandomStringUtils;

import com.canvus.app.vo.CanVusVOFactory;
import com.canvus.app.vo.CanVusVOType;
import com.canvus.app.vo.TagsInFeedVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Helper {
	/**
	 * 저장된 문자열로부터 해시태그를 파싱하여 데이터베이스에 저장하는 메소드.
	 * 기능을 분리하였다.
	 * 작성일: 2021.01.24 / 완성일: / 버그검증일
	 * 작성자: 이한결
	 * @param room_Id
	 * @param context
	 * @return
	 */
	public static TagsInFeedVO tagParse(String feed_id, String context) {
		log.info("해시태그 추출 및 DB 삽입 헬퍼함수");
		
		List<String> tagList = new ArrayList<String>();
		
		// TODO 해시태그 추출
		Pattern pattern = Pattern.compile("([#][a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣぁ-ゔァ-ヴー々〆〤一-龥]*)");
		Matcher matcher = pattern.matcher(context);
		while (matcher.find()) {
			System.out.println(matcher.group(1));
			
		    if(matcher.group(1) ==  null) {
		    	break;
		    } else {
		    	tagList.add(matcher.group(1));
		    }
		}
		
		// TODO 데이터베이스로 보내기 위해 VO 객체 생성
		String[] tag_name = new String[tagList.size()];
		for (int i=0; i<tagList.size(); i++) {
			tag_name[i] = tagList.get(i);
		}
		TagsInFeedVO tif = CanVusVOFactory.newInstance(CanVusVOType.TagsInFeedVO);
		tif.setTag_name(tag_name);
		tif.setFeed_id(feed_id);
		
		// TODO 데이터베이스에 등록
		return tif;
	}

	/**
	 * 12버전 이하의 오라클 DB는 UUID를 primary key로 쓸수 없다. 11버전까지는 30바이트 이하의
	 * 문자열만 가증하기 때문. 그래서 시간+랜덤스트링으로 보완하고자 하였다.
	 * 작성일: 2021.02.19 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @return
	 */
	public static String uniqueIdGenerator () {
		String uniqueId = "";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Calendar cal = Calendar.getInstance();
		uniqueId = sdf.format(cal.getTime());
		uniqueId += ("_" + RandomStringUtils.randomAlphanumeric(12));

		return uniqueId;
	}

	/**
	 * 머천트 아이디를 생성하는 헬퍼메소드
	 * 20210228
	 * 이한결
	 * @param userId
	 * @param pixel
	 * @return
	 */
	public static String merchantIdGenerator (String userId, int pixel) {
		String uniqueId = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Calendar cal = Calendar.getInstance();

		uniqueId = userId + "-" + pixel + "-" + sdf.format(cal.getTime());

		return uniqueId;
	}
}
