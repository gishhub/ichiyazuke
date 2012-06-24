package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.ConfReader;

public class PersonalsDAO extends IchiyazukeDAO {

    private final String QUESTION_ID = "question_id";
    private final String SELECT_QUESTION_IDS = "SELECT question_id FROM personals WHERE personal_id = ?";

    private final String UPDATE_RESULT_IDS = "INSERT INTO personals(personal_id, question_id, category, result) VALUES (?, ?, (select category  from questions where id = ?), ?)";
    
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
            e.printStackTrace();
        }

        return idList;
    }

	public boolean updteResultIds(Connection con, int personalId,
		int questionId) {

        PreparedStatement ps = null;
        boolean result = false;

        try {
            ps = con.prepareStatement(UPDATE_RESULT_IDS);
            ps.setInt(1, personalId);
            ps.setInt(2, questionId);
            ps.setInt(3, questionId);
            ps.setInt(4, 1);

            result = ps.execute();
//            while (rs.next()) {
//                idList.add(rs.getInt(QUESTION_ID));
//            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

		return result;
	}

}
