package action;

import java.sql.Connection;

import dao.UsersDAO;

public class UserAction {

    private final String USERS_DB_NAME = "onenight";

    private String username;
    private String passward;

    public UserAction(String username, String passward) {
		this.username = username;
		this.passward = passward;
	}

    public boolean login(){
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