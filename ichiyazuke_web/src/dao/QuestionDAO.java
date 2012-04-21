package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import dto.Question;

public class QuestionDAO {
	private Connection con;
	
	public QuestionDAO(Connection con){
		this.con = con;
	}
	
	public Question selectById(int id) throws SQLException {
		Question q = null;
		String sql = "SELECT * WHERE ID=" + id;
		Statement stmt = con.createStatement();
		
		ResultSet rset = stmt.executeQuery(sql);
		
		if (rset.next()) {
			q = new Question(rset.getInt(1),
					rset.getInt(2), rset.getInt(3),rset.getString(4), 
					rset.getString(5), rset.getString(6),rset.getString(7),rset.getString(8), rset.getString(9), rset.getString(10), rset.getString(11), rset.getDate(12),rset.getDate(13));
		}
		
		return q;		
	}
}
