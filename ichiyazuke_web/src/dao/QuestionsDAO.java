package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import util.IchiyazukeUtil;

public class QuestionsDAO extends IchiyazukeDAO {
	Logger log = Logger.getLogger(QuestionsDAO.class.getName());

	private final String SELECT_QUESTION_IDS         = "SELECT id FROM questions WHERE grade = ? AND level = ? AND category = ?";
	private final String SELECT_QUESTION_BY_ID       = "SELECT title, contents, choice1, choice2, choice3, choice4, answer, explanation, reg_date FROM questions WHERE id = ?";
	private final String SELECT_QUESTION_BY_ID_LIGHT = "SELECT title, choice1, choice2, choice3, choice4, answer, explanation FROM questions WHERE id = ?";

	public ArrayList<Integer> selectQuestionIds(Connection con, int grade, int level, int category, ArrayList<Integer> notList) {
		ArrayList<Integer> idList = new ArrayList<Integer>();
		String sql = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		sql = SELECT_QUESTION_IDS;
		log.debug("SQL: " + sql);
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
			log.error("selectQuestionIds: " + "",e);
		}
		return idList;
	}

	public HashMap<String, String> selectQuestionById(Connection con, int questionId) {
		StringBuffer sb = new StringBuffer();
		HashMap<String, String> qHashMap = new HashMap<String, String>();
		String sql = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		sb.append(SELECT_QUESTION_BY_ID);
		sql = sb.toString();
		log.debug("SQL: " + sql);

		IchiyazukeUtil ichiyazukeUtil = new IchiyazukeUtil();
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, questionId);
			rs = ps.executeQuery();

			while (rs.next()) {
				qHashMap.put("answer",      ichiyazukeUtil.splitCharAndTex(rs.getString("answer")));
				qHashMap.put("title",       ichiyazukeUtil.splitCharAndTex(rs.getString("title")));
				qHashMap.put("contents",    ichiyazukeUtil.splitCharAndTex(rs.getString("contents")));
				qHashMap.put("choice1",     ichiyazukeUtil.splitCharAndTex(rs.getString("choice1")));
				qHashMap.put("choice2",     ichiyazukeUtil.splitCharAndTex(rs.getString("choice2")));
				qHashMap.put("choice3",     ichiyazukeUtil.splitCharAndTex(rs.getString("choice3")));
				qHashMap.put("choice4",     ichiyazukeUtil.splitCharAndTex(rs.getString("choice4")));
				qHashMap.put("explanation", ichiyazukeUtil.splitCharAndTex(rs.getString("explanation")));
			}
		} catch (SQLException e) {
			log.error("selectQuestionById: " + "",e);
		}
		return qHashMap;
	}

	public HashMap<String, String> selectAnswerById(Connection con, int questionId) {
		StringBuffer sb = new StringBuffer();
		HashMap<String, String> qHashMap = new HashMap<String, String>();
		String sql = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		sb.append(SELECT_QUESTION_BY_ID);
		sql = sb.toString();
		log.debug("SQL: " + sql);

		IchiyazukeUtil ichiyazukeUtil = new IchiyazukeUtil();
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, questionId);
			rs = ps.executeQuery();
			int correctAnswer;
			while (rs.next()) {
				correctAnswer = rs.getInt("answer");
				qHashMap.put("correctAnswer", String.valueOf(rs.getInt("answer")));
				qHashMap.put("title",       ichiyazukeUtil.splitCharAndTex(rs.getString("title")));
				qHashMap.put("contents",    ichiyazukeUtil.splitCharAndTex(rs.getString("contents")));
				qHashMap.put("explanation", ichiyazukeUtil.splitCharAndTex(rs.getString("explanation")));

				switch(correctAnswer){
				case 1:
					qHashMap.put("choice", ichiyazukeUtil.splitCharAndTex(rs.getString("choice1")));
					break;
				case 2:
					qHashMap.put("choice", ichiyazukeUtil.splitCharAndTex(rs.getString("choice2")));
					break;
				case 3:
					qHashMap.put("choice", ichiyazukeUtil.splitCharAndTex(rs.getString("choice3")));
					break;
				case 4:
					qHashMap.put("choice", ichiyazukeUtil.splitCharAndTex(rs.getString("choice4")));
					break;
				default:
					throw new Exception("正解の選択肢を取得できませんでした.");
				}
			}
		} catch (SQLException e) {
			log.error("selectAnswerById: " + "",e);
		} catch (Exception e) {
			log.error("selectAnswerById: " + "",e);
		}
		return qHashMap;
	}
}