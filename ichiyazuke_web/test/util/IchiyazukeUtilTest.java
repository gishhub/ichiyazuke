package util;

import static org.junit.Assert.*;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import util.IchiyazukeUtil;

import org.junit.Before;
import org.junit.Test;

public class IchiyazukeUtilTest {
	
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void testSplitCharAndTex() {
		IchiyazukeUtil ichiyazukeUtil = new IchiyazukeUtil();

		try {
			// 正常系 - 文字列のみ
			assertEquals("aaa", ichiyazukeUtil.splitCharAndTex("aaa"));
			assertEquals("ああああ", ichiyazukeUtil.splitCharAndTex("ああああ"));
			assertEquals("奈良貴仁", ichiyazukeUtil.splitCharAndTex("奈良貴仁"));
			assertEquals("", ichiyazukeUtil.splitCharAndTex(""));
			assertEquals("~!@#$%^&*()_-+={[}]|\\;:<,>.?/", ichiyazukeUtil.splitCharAndTex("~!@#$%^&*()_-+={[}]|\\;:<,>.?/"));
			
			// 正常系 - 数式のみ
			assertEquals(
					"<img src=\"https://chart.googleapis.com/chart?cht=tx&chl="
							+ URLEncoder.encode("sin{15^{circ}}", "UTF-8")
							+ "\"/>",
					ichiyazukeUtil.splitCharAndTex("\"sin{15^{circ}}'"));

			// 正常系
			// 文字 + 数式
			assertEquals(
					"これは、"
							+ "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl="
							+ URLEncoder.encode("sin{15^{circ}}", "UTF-8")
							+ "\"/>",
					ichiyazukeUtil.splitCharAndTex("これは、\"sin{15^{circ}}'"));
			// 数式 + 文字
			assertEquals(
					"<img src=\"https://chart.googleapis.com/chart?cht=tx&chl="
							+ URLEncoder.encode("sin{15^{circ}}", "UTF-8")
							+ "\"/>" + "です。",
					ichiyazukeUtil.splitCharAndTex("\"sin{15^{circ}}'です。"));
			// 文字 + 数式 + 文字 
			assertEquals(
					"これは" + "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl="
							+ URLEncoder.encode("sin{15^{circ}}", "UTF-8")
							+ "\"/>" + "です。",
					ichiyazukeUtil.splitCharAndTex("これは\"sin{15^{circ}}'です。"));
			// 数式 + 文字 + 数式
			assertEquals(
					"<img src=\"https://chart.googleapis.com/chart?cht=tx&chl="
							+ URLEncoder.encode("sin{15^{circ}}", "UTF-8")
							+ "\"/>" + "と" + "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl="
							+ URLEncoder.encode("cos{15^{circ}}", "UTF-8")
							+ "\"/>",
					ichiyazukeUtil.splitCharAndTex("\"sin{15^{circ}}'と\"cos{15^{circ}}'"));
			

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

}
