package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import util.ConfReader;

abstract class IchiyazukeDAO {

    public Connection getConection(String dbName) {
        ConfReader confReader = ConfReader.getInstance();
        Connection con = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            String dbHost     = confReader.getDbHost();
            String dbPort     = confReader.getDbPort();
            String dbUser     = confReader.getDbUser();
            String dbPassword = confReader.getDbPassword();

            String url        = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName;

            con = DriverManager.getConnection(url, dbUser, dbPassword);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return con;
    }

    public void closeConnection(Connection con) {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
