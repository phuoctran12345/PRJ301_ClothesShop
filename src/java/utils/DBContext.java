package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    public static String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static String dbURL = "jdbc:sqlserver://localhost:1433;databaseName=Shop;";
//    public static String dbURL = "jdbc:sqlserver://myserver.database.windows.net:1433;databaseName=lab4;encrypt=true;trustServerCertificate=false;";

    public static String userDB = "sa";
    public static String passDB = "Phuoc12345@";

    public static Connection getConnection() {
        Connection con = null;
        try{
            Class.forName(driverName);
            con = DriverManager.getConnection(dbURL, userDB, passDB);
            return con;
        } catch (Exception ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void main(String[] args) {
        try(Connection con = getConnection()) {
            if(con != null) {
                System.out.println("Connect Success");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}