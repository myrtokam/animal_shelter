
package DbEntitiesConnection;

import Model.Health.Animals;
import Util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AnimalDAO {

    public List<Animals> getAnimals() throws SQLException {

        String sql = """
                SELECT animals_id, name, microchip_number, color, special_needs_summary
                FROM animals
                ORDER BY animals_id
                LIMIT 1000
                """;

        List<Animals> animalsList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Animals animal = new Animals();

                animal.setAnimalId(
                        resultSet.getLong("animals_id"));

                animal.setName(
                        resultSet.getString("name"));

                animal.setMicrochipNumber(
                        resultSet.getString("microchip_number"));

                animal.setColor(
                        resultSet.getString("color"));

                animal.setSpecialNeedsSummary(
                        resultSet.getString("special_needs_summary"));

                animalsList.add(animal);
            }
        }

        return animalsList;
    }
}

