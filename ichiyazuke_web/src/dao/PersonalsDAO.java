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

}
