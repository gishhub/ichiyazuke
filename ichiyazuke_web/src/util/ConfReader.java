package util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class ConfReader {

    private static ConfReader confReader = new ConfReader();

    private String dbHost;
    private String dbPort;
    private String dbUser;
    private String dbPassword;

    public void readConf(String configFilePath) {
        Properties properties = new Properties();

        try {
            properties.load(new FileInputStream(configFilePath));
            this.dbHost     = properties.getProperty("db.host");
            this.dbPort     = properties.getProperty("db.port");
            this.dbUser     = properties.getProperty("db.user");
            this.dbPassword = properties.getProperty("db.password");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static ConfReader getInstance() {
        return confReader;
    }

    public String getDbHost() {
        return dbHost;
    }

    public String getDbPort() {
        return dbPort;
    }

    public String getDbUser() {
        return dbUser;
    }

    public String getDbPassword() {
        return dbPassword;
    }

}