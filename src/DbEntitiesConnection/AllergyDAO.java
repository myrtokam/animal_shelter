package DbEntitiesConnection;

import Model.Health.Allergy;
import Util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class AllergyDAO {

    public void testConnection() throws SQLException {
        try (Connection connection = DatabaseConnection.getConnection()) {

            System.out.println("Connection Successful");

        }
    }

    public List<Model.Health.Allergy> getAlergies() throws SQLException {

        // Το SQL query που θα εκτελεστεί στη βάση.
        String sql = """
                SELECT name, allergies_id, description, status
                FROM allergies
                order by allergies_id
                limit 1000
                """;

        // Δημιουργούμε μια άδεια λίστα για τα αποτελέσματα.
        List<Allergy> allergieslist = new ArrayList<>();


        try (Connection connection = DatabaseConnection.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            {
                while (resultSet.next()) {
                    Allergy allergy = new Allergy();
                    allergy.setAllergyId(resultSet.getLong("allergies_id"));
                    allergy.setDescription(resultSet.getString("description"));
                    allergy.setName(resultSet.getString("name"));
                    allergy.setStatus(resultSet.getString("status"));

                    allergieslist.add(allergy);
                }
            }
            return allergieslist;
        }
    }
}