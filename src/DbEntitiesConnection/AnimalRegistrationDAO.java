package DbEntitiesConnection;

import Util.DatabaseConnection;

import java.sql.Connection;
import java.sql.SQLException;

public class AnimalRegistrationDAO {

    public void testConnection() throws SQLException {
        try (Connection connection = DatabaseConnection.getConnection()) {
            System.out.println("Connection Successful");
        }
    }

}
