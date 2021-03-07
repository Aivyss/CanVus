package com.canvus.app.util;

import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;

public class Base64ToImgDecoder {
	/**
	 * base64로 인코딩된 그림파일을 디코딩하고 저장하는 메소드
	 * ext : 확장자
	 * 작성일: 2021.01.23
	 * @param base64
	 * @param target
	 * @return
	 */
	public static boolean decoder(String base64, String target, String fileName, String ext){
		String data = base64.split(",")[1];
		byte[] imageBytes = DatatypeConverter.parseBase64Binary(data);
		boolean check = true;
		
		try {
			BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));
			ImageIO.write(bufImg, ext, new File(target + "/" + fileName + "." + ext));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			check = false;
		}
		
		return check;
	}
}