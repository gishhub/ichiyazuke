package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import bean.Question;


import util.IchiyazukeUtil;

public class QuestionsDAO extends IchiyazukeDAO {
	Logger log = Logger.getLogger(QuestionsDAO.class.getName());
	IchiyazukeUtil ichiyazukeUtil = new IchiyazukeUtil();

	private final String SELECT_QUESTION_IDS   = "SELECT id,title,contents,reg_date FROM questions WHERE grade = ? AND level = ? AND category = ?";
	private final String SELECT_QUESTION_BY_ID = "SELECT id,title,contents,choice1,choice2,choice3,choice4,answer,explanation,reg_date FROM questions WHERE id = ?";

	public ArrayList<Question> selectQuestionIds(Connection con, int grade, int level, int category, ArrayList<Integer> notList) {
		ArrayList<Question> quiestions = new ArrayList<Question>();
		String sql = SELECT_QUESTION_IDS;
		PreparedStatement ps = null;
		ResultSet rs = null;
		log.debug("SQL: " + sql);

		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, grade);
			ps.setInt(2, level);
			ps.setInt(3, category);
			rs = ps.executeQuery();
			while (rs.next()) {
				Question question = new Question(
						rs.getInt("id"),
						rs.getString("title"),
						rs.getString("contents").replaceAll("\'","").replaceAll("\"",""),
						rs.getDate("reg_date"));
				quiestions.add(question);
			}
		} catch (SQLException e) {
			log.error("selectQuestionIds: " + "", e);
		}
		return quiestions;
	}

	public Question selectQuestionById(Connection con, int questionId) {
		Question question = new Question();
		String sql = SELECT_QUESTION_BY_ID;
		PreparedStatement ps = null;
		ResultSet rs = null;
		log.debug("SQL: " + sql);

		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, questionId);
			rs = ps.executeQuery();
			while (rs.next()) {
				question = new Question(
						rs.getInt("id"),
						rs.getString("title"),
						ichiyazukeUtil.splitCharAndTex(rs.getString("contents")),
						ichiyazukeUtil.splitCharAndTex(rs.getString("choice1")),
						ichiyazukeUtil.splitCharAndTex(rs.getString("choice2")),
						ichiyazukeUtil.splitCharAndTex(rs.getString("choice3")),
						ichiyazukeUtil.splitCharAndTex(rs.getString("choice4")),
						ichiyazukeUtil.splitCharAndTex(rs.getString("answer")),
						ichiyazukeUtil.splitCharAndTex(rs.getString("explanation")),
						rs.getDate("reg_date"));
			}
		} catch (SQLException e) {
			log.error("selectQuestionById: " + "",e);
		}
		return question;
	}
}