package util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class IchiyazukeUtil {

	/*
	 * 問題文など、DB内に数式を含んだ形で格納されている文字列を、単純文字列と数式(tex)に分割するメソッド 
	 * 奈良貴仁
	 */
	public HashMap<Integer, HashMap<String, String>> splitCharAndTex(String str) {
		HashMap<Integer, HashMap<String, String>> sbHashMap = new HashMap<Integer, HashMap<String, String>>();

		List<String> list_str = new ArrayList<String>();
		List<String> list_tex = new ArrayList<String>();

		Pattern pattern_str = Pattern.compile("(\'.+\")|(^.+\")|(\'.+$)|^((?!(\'|\")).)*$");
		Pattern pattern_tex = Pattern.compile("\".+\'");

		Matcher matcher_str = pattern_str.matcher(str);
		Matcher matcher_tex = pattern_tex.matcher(str);

		while (matcher_str.find()) {
			String tmp = matcher_str.group();
			if (!tmp.isEmpty()) {
				if (tmp.substring(0, 1).equals("'")) {
					tmp = tmp.substring(1);
				}

				if (tmp.substring(tmp.length() - 1).equals("\"")) {
					tmp = tmp.substring(0, tmp.length() - 1);
				}
				list_str.add(tmp);
			}
		}
		while (matcher_tex.find()) {
			String tmp = matcher_tex.group();
			if (!tmp.isEmpty()) {
				list_tex.add(tmp.substring(1, tmp.length() - 1));
			}
		}

		String regex_decision = "^\".*";
		Pattern pattern_decision = Pattern.compile(regex_decision);
		Matcher matcher = pattern_decision.matcher(str);

		int total_size = list_str.size() + list_tex.size();
		for (int i = 0; i < total_size; ++i) {
			boolean match = matcher.matches();
			int tmp_i;

			if (match == true) {
				HashMap<String, String> strHashMap = new HashMap<String, String>();
				HashMap<String, String> texHashMap = new HashMap<String, String>();

				if (i % 2 == 0) {
					tmp_i = i / 2;
					strHashMap.put("tex", list_tex.get(i));
					sbHashMap.put(i, strHashMap);
				} else {
					tmp_i = i / 2;
					texHashMap.put("str", list_str.get(i));
					sbHashMap.put(i, texHashMap);
				}
			} else {
				HashMap<String, String> strHashMap = new HashMap<String, String>();
				HashMap<String, String> texHashMap = new HashMap<String, String>();

				if (i % 2 == 0) {
					tmp_i = i / 2;
					texHashMap.put("str", list_str.get(tmp_i));
					sbHashMap.put(i, texHashMap);
				} else {
					tmp_i = i / 2;
					strHashMap.put("tex", list_tex.get(tmp_i));
					sbHashMap.put(i, strHashMap);
				}
			}
		}
		return sbHashMap;
	}
	/*
	 * 問題文など、DB内に数式を含んだ形で格納されている文字列を、単純文字列と数式(tex)に分割するメソッド 
	 * 奈良作のsplitCharAndTex()を作り直したいと思ってます.String返すようにしたいんです.
	 */
	public String splitCharAndTex2(String original) {
		String translatedStr = "";
		List<String> list_str = new ArrayList<String>();
		List<String> list_tex = new ArrayList<String>();

		Pattern pattern_str = Pattern.compile("(\'.+\")|(^.+\")|(\'.+$)|^((?!(\'|\")).)*$");
		Pattern pattern_tex = Pattern.compile("\".+\'");

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
		for (int i = 0; i < total_size; ++i) {
			boolean match = matcher.matches();
			int tmp_i;

			//変換前文字列の最初の文字が"であるならば
			if (match == true) {
				if (i % 2 == 0) {
					try {
						translatedStr += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl=" + URLEncoder.encode(list_tex.get(i),"UTF-8") + "\"/>";
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else {
					translatedStr += list_str.get(i);
				}

			//変換前文字列の最初の文字が"でないならば
			} else {
				if (i % 2 == 0) {
					tmp_i = i / 2;
					translatedStr += list_str.get(tmp_i);
				} else {
					tmp_i = i / 2;
					try {
						translatedStr += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl=" + URLEncoder.encode(list_tex.get(tmp_i),"UTF-8") + "\"/>";
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}
			}
		}
		System.out.println("変換前の文字列 : " + original);	//デバッグ
		System.out.println("変換後の文字列 : " + translatedStr);	//デバッグ
		System.out.println("");	//デバッグ
		return translatedStr;
	}
}
