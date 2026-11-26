
package Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL =
            "jdbc:mysql://127.0.0.1:3306/animal_care_platform";

    private static final String USER =
            System.getenv("DB_USER");

    private static final String PASSWORD =
            System.getenv("DB_PASSWORD");

    public static Connection getConnection() throws SQLException {

        if (USER == null || USER.isBlank()) {
            throw new SQLException("DB_USER is missing");
        }

        if (PASSWORD == null || PASSWORD.isBlank()) {
            throw new SQLException("DB_PASSWORD is missing");
        }

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }
}
