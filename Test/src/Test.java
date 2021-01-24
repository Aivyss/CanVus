import java.util.*;
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/* Name of the class has to be "Main" only if the class is public. */
class Test {
	public static void main (String[] args) throws java.lang.Exception {
		Pattern pattern = Pattern.compile("([#][a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣぁ-ゔァ-ヴー々〆〤一-龥]*)");
		Matcher matcher = pattern.matcher("#태그1 아주힘들도다 #태그2#태그3 잘될까?");

		while (matcher.find()) {
			System.out.println(matcher.group(1));
			
		    if(matcher.group(1) ==  null)
		    	break;
		}
	}
}