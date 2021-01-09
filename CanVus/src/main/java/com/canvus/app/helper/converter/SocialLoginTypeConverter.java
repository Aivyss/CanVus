package com.canvus.app.helper.converter;


import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;

import com.canvus.app.helper.consants.SocialLoginType;

@Configuration
public class SocialLoginTypeConverter implements Converter<String, SocialLoginType>{

	@Override
	public SocialLoginType convert(String source) {
		return SocialLoginType.valueOf(source.toUpperCase());
	}
}
