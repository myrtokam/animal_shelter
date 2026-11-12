package DbEntitiesConnection;

import Util.DatabaseConnection;

import java.sql.Connection;
import java.sql.SQLException;


public class AllergyDAO {

    public void testConnection() throws SQLException {
        try (Connection cqnnection = DatabaseConnection.getConnection()) {

            System.out.println("Connection Successful");

        }
    }
}
