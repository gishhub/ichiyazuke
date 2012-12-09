package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class PersonalsDAO extends IchiyazukeDAO {
	Logger log = Logger.getLogger(PersonalsDAO.class.getName());

	private final String QUESTION_ID = "question_id";
	private final String SELECT_QUESTION_IDS = "SELECT question_id FROM personals WHERE personal_id = ?";
	private final String INSERT_RESULT_IDS = "INSERT INTO personals(personal_id, question_id, category, result) VALUES (?, ?, (select category  from questions where id = ?), ?)";

	public ArrayList<Integer> selectQuestionIds(Connection con, int personalId) {
		ArrayList<Integer> idList = new ArrayList<Integer>();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement(SELECT_QUESTION_IDS);
			ps.setInt(1, personalId);

			rs = ps.executeQuery();
			while (rs.next()) {
				idList.add(rs.getInt(QUESTION_ID));
			}
		} catch (SQLException e) {
			log.error("selectQuestionIds: " + "",e);
		}

		return idList;
	}

	public boolean updateResultIds(Connection con, int personalId,
			int questionId, int result) {

		PreparedStatement ps = null;
		int sqlResult = 0;

		try {
			ps = con.prepareStatement(INSERT_RESULT_IDS);
			ps.setInt(1, personalId);
			ps.setInt(2, questionId);
			ps.setInt(3, questionId);
			ps.setInt(4, result);

			sqlResult = ps.executeUpdate();

		} catch (SQLException e) {
			log.error("updateResultIds: " + "",e);
		}

		if (sqlResult == 0) {
			return false;
		} else {
			return true;
		}
	}

}
