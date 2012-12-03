package util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class IchiyazukeUtil {

	/*
	 * 問題文など、DB内に数式を含んだ形で格納されている文字列を、単純文字列と数式(tex)に分割するメソッド 
	 * 奈良作のsplitCharAndTex()を作り直したいと思ってます.String返すようにしたいんです.
	 */
	public String splitCharAndTex2(String original) {
		String translatedStr = "";
		List<String> list_str = new ArrayList<String>();
		List<String> list_tex = new ArrayList<String>();

		Pattern pattern_str = Pattern.compile("(\'.+?\")|(^.+?\")|(\'.+?$)|^((?!(\'|\")).)*$");
		Pattern pattern_tex = Pattern.compile("\".+?\'");

		Matcher matcher_str = pattern_str.matcher(original);
		Matcher matcher_tex = pattern_tex.matcher(original);

		// 単純文字列('で始まって、"で終わる)であるならば
		while (matcher_str.find()) {
			String tmp = matcher_str.group();
			if (!tmp.isEmpty()) {

				//最初の文字が'ならば、その'を除いた文字列をtmpへ格納
				if (tmp.substring(0, 1).equals("'")) {
					tmp = tmp.substring(1);
				}

				//最後の文字が"ならば、その"を除いた文字列をtmpへ格納
				if (tmp.substring(tmp.length() - 1).equals("\"")) {
					tmp = tmp.substring(0, tmp.length() - 1);
				}
				// list_strにtmp(単純文字列)を追加

				list_str.add(tmp);
			}
		}

		// 数式("で始まって、'で終わる)であるならば
		while (matcher_tex.find()) {
			String tmp = matcher_tex.group();
			if (!tmp.isEmpty()) {
				// list_texにtmp(数式)を追加

				list_tex.add(tmp.substring(1, tmp.length() - 1));
			}
		}
		
		Pattern pattern_decision = Pattern.compile("^\".*");
		Matcher matcher = pattern_decision.matcher(original);

		int total_size = list_str.size() + list_tex.size();

		boolean match = matcher.matches();
		int tmp_i;
		

		// 変換前文字列の最初の文字が"であるならば
		if (match == true) {
			for (int i = 0; i < total_size; ++i) {
				tmp_i = i / 2;
				if (i % 2 == 0) {
					try {
						translatedStr += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl="
								+ URLEncoder.encode(list_tex.get(tmp_i),
										"UTF-8") + "\"/>";
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else {
					translatedStr += list_str.get(tmp_i);
				}
			}
			// 変換前文字列の最初の文字が"でないならば
		} else {
			for (int i = 0; i < total_size; ++i) {
				tmp_i = i / 2;
				if (i % 2 == 0) {
					translatedStr += list_str.get(tmp_i);
				} else {
					try {
						translatedStr += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl="
								+ URLEncoder.encode(list_tex.get(tmp_i),
										"UTF-8") + "\"/>";
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}
			}
		}
//		System.out.println("変換前の文字列 : " + original);	//デバッグ
//		System.out.println("変換後の文字列 : " + translatedStr);	//デバッグ
//		System.out.println("");	//デバッグ
		return translatedStr;
	}
	
	public String convertHashTagBRToTagBR(String original){
		String regex_br = "#BR";
		String convertedStr = original.replaceAll(regex_br, "<br>");
		
		return convertedStr;
	}
}
