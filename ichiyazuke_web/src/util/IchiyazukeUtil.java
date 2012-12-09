package util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

public class IchiyazukeUtil {
	Logger log = Logger.getLogger(IchiyazukeUtil.class.getName());

	/*
	 * 問題文など、DB内に数式を含んだ形で格納されている文字列を、単純文字列と数式(tex)に分割するメソッド
	 */
	public String splitCharAndTex(String original) {
		log.debug("変換開始: " + original);

		//改行コードを<br>に変換
		String modifiedOriginal = convertLineFeedCodeToTag(original);

		String translatedStr = "";
		List<String> listStr = new ArrayList<String>();
		List<String> listTex = new ArrayList<String>();

		Pattern patternStr = Pattern
				.compile("(\'.+?\")|(^.+?\")|(\'.+?$)|^((?!(\'|\")).)*$");
		Pattern patternTex = Pattern.compile("\".+?\'");

		Matcher matcherStr = patternStr.matcher(modifiedOriginal);
		Matcher matcherTex = patternTex.matcher(modifiedOriginal);

		// 単純文字列('で始まって、"で終わる)であるならば
		while (matcherStr.find()) {
			String tmp = matcherStr.group();
			if (!tmp.isEmpty()) {
				// 最初の文字が'ならば、その'を除いた文字列をtmpへ格納
				if (tmp.substring(0, 1).equals("'")) {
					tmp = tmp.substring(1);
				}
				// 最後の文字が"ならば、その"を除いた文字列をtmpへ格納
				if (tmp.substring(tmp.length() - 1).equals("\"")) {
					tmp = tmp.substring(0, tmp.length() - 1);
				}
				// listStrにtmp(単純文字列)を追加
				listStr.add(tmp);
			}
		}

		// 数式("で始まって、'で終わる)であるならば
		while (matcherTex.find()) {
			String tmp = matcherTex.group();
			if (!tmp.isEmpty()) {
				// listTexにtmp(数式)を追加
				listTex.add(tmp.substring(1, tmp.length() - 1));
			}
		}

		Pattern patternDecision = Pattern.compile("^\".*");
		Matcher matcher = patternDecision.matcher(modifiedOriginal);
		int totalSize = listStr.size() + listTex.size();
		boolean match = matcher.matches();
		int tmp_i;

		// 変換前文字列の最初の文字が"であるならば
		if (match == true) {
			for (int i = 0; i < totalSize; ++i) {
				tmp_i = i / 2;
				if (i % 2 == 0) {
					try {
						translatedStr += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl="
								+ URLEncoder.encode(listTex.get(tmp_i),
										"UTF-8") + "\"/>";
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else {
					translatedStr += listStr.get(tmp_i);
				}
			}
			// 変換前文字列の最初の文字が"でないならば
		} else {
			for (int i = 0; i < totalSize; ++i) {
				tmp_i = i / 2;
				if (i % 2 == 0) {
					translatedStr += listStr.get(tmp_i);
				} else {
					try {
						translatedStr += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl="
								+ URLEncoder.encode(listTex.get(tmp_i),
										"UTF-8") + "\"/>";
					} catch (UnsupportedEncodingException e) {
						log.error("splitCharAndTex: " + "",e);
					}
				}
			}
		}
		log.debug("変換完了: " + translatedStr);
		return translatedStr;
	}

	public String convertLineFeedCodeToTag(String original) {
		String regex_BR = "#BR";
		String regex_rn = "\r\n";
		String regex_r  = "\r";
		String regex_n  = "\n";

		String convertedStr = original;
		convertedStr = convertedStr.replaceAll(regex_BR, "<br>");
		convertedStr = convertedStr.replaceAll(regex_rn, "<br>");
		convertedStr = convertedStr.replaceAll(regex_r,  "<br>");
		convertedStr = convertedStr.replaceAll(regex_n,  "<br>");

		return convertedStr;
	}
}
