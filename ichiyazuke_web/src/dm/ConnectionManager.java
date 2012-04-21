package dm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionManager {

	public static Connection getConnection() throws SQLException {
		// TODO Auto-generated method stub
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ichiyazuke_db" + "?usernicode=true&characterEncoding=Windows-31J", "ichiyazuke_user", "password");
			
		} catch (ClassNotFoundException e) {
			throw new SQLException(e.getMessage());
		}
			
		return con;
	}

}
