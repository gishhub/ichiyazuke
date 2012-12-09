package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class UsersDAO extends IchiyazukeDAO {
	Logger log = Logger.getLogger(UsersDAO.class.getName());

	private final String SELECT_USER_BY_NICKNAME = "SELECT * FROM users WHERE nickname = ?";
	private final String SELECT_USER_BY_NICKNAME_PASSWORD = "SELECT * FROM users WHERE nickname = ? AND password = ?";
	private final String INSERT_USER = "INSERT INTO users(nickname, password) VALUES (?, ?)";

	public boolean selectUser(Connection con, String nickname, String passward) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 0;

		try {
			ps = con.prepareStatement(SELECT_USER_BY_NICKNAME_PASSWORD);
			ps.setString(1, nickname);
			ps.setString(2, passward);

			rs = ps.executeQuery();
			while (rs.next()) {
				count++;
			}

			if (count == 0) {
				return false;
			} else {
				return true;
			}
		} catch (SQLException e) {
			log.error("selectUser: " + "",e);
		}
		return false;
	}

	public boolean insertUser(Connection con, String nickname, String passward) {

		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 0;
		int result = 0;

		try {
			ps = con.prepareStatement(SELECT_USER_BY_NICKNAME);
			ps.setString(1, nickname);

			rs = ps.executeQuery();
			while (rs.next()) {
				count++;
			}

			// 既存nicknameかどうか
			if (count == 0) {
				ps = null;
				ps = con.prepareStatement(INSERT_USER);
				ps.setString(1, nickname);
				ps.setString(2, passward);

				result = ps.executeUpdate();

				if (result == 1) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		} catch (SQLException e) {
			log.error("insertUser: " + "",e);
		}
		return false;
	}
}
