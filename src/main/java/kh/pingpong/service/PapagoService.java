package kh.pingpong.service;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

import kh.pingpong.dto.LanguageDTO;

// 네이버 기계번역 (Papago SMT) API 예제
@Service
public class PapagoService {

	// nmtReturnResult의 함수를 통해서 한글 - > 영어로 번역
	public String[] nmtReturnRseult(String original_str, LanguageDTO lang, String change_lang){

	    //String clientId = "Zprr_EnU6RonMqqOkNkU"; //애플리케이션 클라이언트 아이디값";
	    //String clientId = "N2TSG6ENIXxuIulXFjSw"; //애플리케이션 클라이언트 아이디값";
		//String clientSecret = "JvPsKCMdOI";
		//String clientSecret = "qWA5wr7LKh";
		String clientId = "Zprr_EnU6RonMqqOkNkU"; 
		String clientSecret = "JvPsKCMdOI";

		String[] resultString = new String[2];
		try {
			//original_str 값이 우리가 변환할 값
			String text = URLEncoder.encode(original_str, "UTF-8");
			System.out.println(text);
			String apiURL = "https://openapi.naver.com/v1/papago/detectLangs";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			
			
			// post request
			String postParams =  "query="  + text+"&target="+change_lang;
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(postParams);
			wr.flush();
			wr.close();
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode==200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			//
			HashMap<String, Object> rs = new ObjectMapper().readValue(response.toString(), HashMap.class) ;
            String langCode = (String)rs.get("langCode") ;
            System.out.println("1"+langCode);
            System.out.println("2"+change_lang);
            resultString[0] = langCode;
            resultString[1] = this.nmtRseult(original_str, langCode, change_lang);
		} catch (Exception e) {
			System.out.println(e);
		}
		return resultString;
	}


	public String nmtRseult(String original_str, String lang, String change_lang){

	      //애플리케이션 클라이언트 아이디값";
	      String clientId = "jPPntjzUc09zBQsT_zU7";
	      //애플리케이션 클라이언트 시크릿값";
	      String clientSecret = "iSGGw0F3NI";

	      String resultString ="";
	      try {
	         //original_str 값이 우리가 변환할 값
	         String text = URLEncoder.encode(original_str, "UTF-8");


	         String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
	         URL url = new URL(apiURL);
	         HttpURLConnection con = (HttpURLConnection)url.openConnection();
	         con.setRequestMethod("POST");
	         con.setRequestProperty("X-Naver-Client-Id", clientId);
	         con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	         
	         
	         // post request
	         String postParams = "source="+lang+"&target="+change_lang+"&text=" + text;
	         con.setDoOutput(true);
	         DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	         wr.writeBytes(postParams);
	         wr.flush();
	         wr.close();
	         int responseCode = con.getResponseCode();
	         BufferedReader br;
	         if(responseCode==200) { // 정상 호출
	            br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF8"));
	         } else { // 에러 발생
	            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	         }
	         String inputLine;
	         StringBuffer response = new StringBuffer();
	         while ((inputLine = br.readLine()) != null) {
	            response.append(inputLine);
	         }
	         br.close();
	         System.out.println(response.toString());

	         resultString = response.toString();
	      } catch (Exception e) {
	         System.out.println(e);
	      }

	      return resultString;
	   }	

}