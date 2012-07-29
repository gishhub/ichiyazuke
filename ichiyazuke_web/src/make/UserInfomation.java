package make;

import java.sql.Connection;

import dao.UsersDAO;

public class UserInfomation {

    private final String USERS_DB_NAME = "onenight";

    private String username;
    private String passward;

    public UserInfomation(String username, String passward) {
		this.username = username;
		this.passward = passward;
	}

    public boolean judgeLogin(){
    	boolean result = false;

        UsersDAO usersDao = new UsersDAO();
        Connection usersCon = usersDao.getConection(USERS_DB_NAME);

        result = usersDao.selectUser(usersCon, username, passward);

        return result;
    }

    public boolean signUp(){
    	boolean result = false;

        UsersDAO usersDao = new UsersDAO();
        Connection usersCon = usersDao.getConection(USERS_DB_NAME);

        result = usersDao.insertUser(usersCon, username, passward);

        return result;
    }
}