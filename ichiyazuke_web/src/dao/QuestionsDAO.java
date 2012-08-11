package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class QuestionsDAO extends IchiyazukeDAO {

    private final String QUESTION_ID = "id";

    /*
     * ここは現在まだ使ってない
    private final String SELECT_QUESTIONS  = "SELECT id FROM questions WHERE NOT id IN";
    private final String PARENTHESIS_OPEN  = " (";
    private final String PARENTHESIS_CLOSE = ")";
    private final String QUESTION_MARK     = "?";
    private final String COMMA             = ", ";
    private final String AND_GRADE         = " AND grade = ?";
    private final String AND_LEVEL         = " AND level = ?";
    private final String AND_CATEGORY      = " AND category = ?";
    */

    private final String SELECT_QUESTION_IDS    = "SELECT id FROM questions WHERE grade = ? AND level = ? AND category = ?";
    private final String SELECT_QUESTIONS_BY_ID = "SELECT title, contents, choice1, choice2, choice3, choice4, answer, explanation, reg_date FROM questions WHERE id = ?";

    /*
     * 解いたことある問題IDを除いて問題IDリスト返すんだけど
     * ここはまだ使わない
    public ArrayList<Integer> selectQuestionIds(Connection con, int grade, int level, ArrayList<Integer> notList, int category) {
        StringBuffer sb = new StringBuffer();
        ArrayList<Integer> idList = new ArrayList<Integer>();
        Iterator<Integer> quiestionIds = notList.iterator();
        String sql = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        sb.append(SELECT_QUESTIONS);
        sb.append(PARENTHESIS_OPEN);
        for (int i = 0; i < notList.size(); i++) {
            sb.append(QUESTION_MARK);
            
            if (i != notList.size() - 1)
            	sb.append(COMMA);
        }
        sb.append(PARENTHESIS_CLOSE);
        sb.append(AND_GRADE);
        sb.append(AND_LEVEL);
        sb.append(AND_CATEGORY);

        sql = sb.toString();
        try {
            ps = con.prepareStatement(sql);
            int counter = 1;
            while (quiestionIds.hasNext()) {
                int quiestionId = quiestionIds.next();

                ps.setInt(counter, quiestionId);
                counter++;
            }
            ps.setInt(counter++, grade);
            ps.setInt(counter++, level);
            ps.setInt(counter, category);

            rs = ps.executeQuery();

            while (rs.next()) {
                idList.add(rs.getInt(QUESTION_ID));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return idList;
    }
    */

    public ArrayList<Integer> selectQuestionIds(Connection con, int grade, int level, int category, ArrayList<Integer> notList) {
        ArrayList<Integer> idList = new ArrayList<Integer>();
        String sql = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        sql = SELECT_QUESTION_IDS;

        //デバッグ
        System.out.println("SQL : " + sql);
        try {
            ps = con.prepareStatement(sql);

            ps.setInt(1, grade);
            ps.setInt(2, level);
            ps.setInt(3, category);

            //デバッグ
            System.out.println("grade : " + grade);
            System.out.println("level : " + level);
            System.out.println("category : " + category);

            rs = ps.executeQuery();

            while (rs.next()) {
                idList.add(rs.getInt(QUESTION_ID));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return idList;
    }

    public HashMap<String,String> selectQuestionById(Connection con, int questionId) {
		
        StringBuffer sb = new StringBuffer();
		HashMap<String,String> qHashMap = new HashMap<String,String>();
        String sql = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        sb.append(SELECT_QUESTIONS_BY_ID);

        sql = sb.toString();
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, questionId);

            rs = ps.executeQuery();
            while (rs.next()) {
            	qHashMap.put("title",       rs.getString("title"));
            	qHashMap.put("contents",    rs.getString("contents"));
            	qHashMap.put("choice1",     rs.getString("choice1"));
            	qHashMap.put("choice2",     rs.getString("choice2"));
            	qHashMap.put("choice3",     rs.getString("choice3"));
            	qHashMap.put("choice4",     rs.getString("choice4"));
            	qHashMap.put("answer",      rs.getString("answer"));
            	qHashMap.put("explanation", rs.getString("explanation"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 
    	
		return qHashMap;
	}
}
