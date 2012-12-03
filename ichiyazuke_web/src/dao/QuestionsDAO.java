package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import util.IchiyazukeUtil;

public class QuestionsDAO extends IchiyazukeDAO {
	private final String SELECT_QUESTION_IDS         = "SELECT id FROM questions WHERE grade = ? AND level = ? AND category = ?";
	private final String SELECT_QUESTION_BY_ID       = "SELECT title, contents, choice1, choice2, choice3, choice4, answer, explanation, reg_date FROM questions WHERE id = ?";
	private final String SELECT_QUESTION_BY_ID_LIGHT = "SELECT title, choice1, choice2, choice3, choice4, answer, explanation FROM questions WHERE id = ?";

	public ArrayList<Integer> selectQuestionIds(Connection con, int grade, int level, int category, ArrayList<Integer> notList) {
		ArrayList<Integer> idList = new ArrayList<Integer>();
		String sql = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		sql = SELECT_QUESTION_IDS;
//		System.out.println("SQL : " + sql);	//デバッグ
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, grade);
			ps.setInt(2, level);
			ps.setInt(3, category);
			rs = ps.executeQuery();
			while (rs.next()) {
				idList.add(rs.getInt("id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return idList;
	}

	//テスト@高田
	public HashMap<String, String> selectQuestionById2(Connection con, int questionId) {
		StringBuffer sb = new StringBuffer();
		HashMap<String, String> qHashMap = new HashMap<String, String>();
		String sql = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		sb.append(SELECT_QUESTION_BY_ID);
		sql = sb.toString();
//		System.out.println("SQL : " + sql);	//デバッグ

		IchiyazukeUtil ichiyazukeUtil = new IchiyazukeUtil();
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, questionId);
			rs = ps.executeQuery();
			
			
			
			while (rs.next()) {
				String split_answer      = ichiyazukeUtil.splitCharAndTex2(rs.getString("answer"));
				String split_title       = ichiyazukeUtil.splitCharAndTex2(rs.getString("title"));
				String split_contents    = ichiyazukeUtil.splitCharAndTex2(rs.getString("contents"));
				String split_choice1     = ichiyazukeUtil.splitCharAndTex2(rs.getString("choice1"));
				String split_choice2     = ichiyazukeUtil.splitCharAndTex2(rs.getString("choice2"));
				String split_choice3     = ichiyazukeUtil.splitCharAndTex2(rs.getString("choice3"));
				String split_choice4     = ichiyazukeUtil.splitCharAndTex2(rs.getString("choice4"));
				String split_explanation = ichiyazukeUtil.splitCharAndTex2(rs.getString("explanation"));

	
				String modified_answer      = ichiyazukeUtil.convertHashTagBRToTagBR(split_answer);
				String modified_title       = ichiyazukeUtil.convertHashTagBRToTagBR(split_title);
				String modified_contents    = ichiyazukeUtil.convertHashTagBRToTagBR(split_contents);
				String modified_choice1     = ichiyazukeUtil.convertHashTagBRToTagBR(split_choice1);
				String modified_choice2     = ichiyazukeUtil.convertHashTagBRToTagBR(split_choice2);
				String modified_choice3     = ichiyazukeUtil.convertHashTagBRToTagBR(split_choice3);
				String modified_choice4     = ichiyazukeUtil.convertHashTagBRToTagBR(split_choice4);
				String modified_explanation = ichiyazukeUtil.convertHashTagBRToTagBR(split_explanation);
			

                qHashMap.put("answer",      modified_answer);
                qHashMap.put("title",       modified_title);
                qHashMap.put("contents",    modified_contents);
                qHashMap.put("choice1",     modified_choice1);
                qHashMap.put("choice2",     modified_choice2);
                qHashMap.put("choice3",     modified_choice3);
                qHashMap.put("choice4",     modified_choice4);
                qHashMap.put("explanation", modified_explanation);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return qHashMap;
	}

	public HashMap<String, String> selectAnswerById(Connection con, int questionId) {
		StringBuffer sb = new StringBuffer();
		HashMap<String, String> qHashMap = new HashMap<String, String>();
		String sql = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		sb.append(SELECT_QUESTION_BY_ID_LIGHT);
		sql = sb.toString();
//		System.out.println("SQL : " + sql);	//デバッグ

		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, questionId);
			rs = ps.executeQuery();
			int correctAnswer;
			while (rs.next()) {
				correctAnswer = rs.getInt("answer");
				qHashMap.put("correctAnswer", String.valueOf(correctAnswer));
				qHashMap.put("title",       rs.getString("title"));
				qHashMap.put("explanation", rs.getString("explanation"));

				switch(correctAnswer){
				case 1:
					qHashMap.put("choice", rs.getString("choice1"));
					break;
				case 2:
					qHashMap.put("choice", rs.getString("choice2"));
					break;
				case 3:
					qHashMap.put("choice", rs.getString("choice3"));
					break;
				case 4:
					qHashMap.put("choice", rs.getString("choice4"));
					break;
				default:
					throw new Exception("正解の選択肢を取得できませんでした.");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return qHashMap;
	}
}