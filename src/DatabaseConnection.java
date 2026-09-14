
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private Connection connection;

    public DatabaseConnection() {
        String url = "jdbc:postgresql://localhost:5432/PawBase";
        String username = "shelter_app";
        String password = "Dean_Wintcheaster";

        try {
            this.connection = DriverManager.getConnection(url, username, password);
            System.out.println("Database connection successful!");
        } catch (SQLException e) {
            System.out.println("Database connection failed!");
            e.printStackTrace();
        }

    }

    public Connection getConnection() {

        return this.connection;
    }
}

