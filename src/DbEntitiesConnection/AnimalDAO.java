package DbEntitiesConnection;

import Model.Animals;
import Util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

public class AnimalDAO {

    public boolean registerAnimal(Animals animal) throws SQLException {

        String sql = """
                INSERT INTO animals (
                    name,
                    sex,
                    species_id,
                    breed_id,
                    organization_id,
                    microchip_number,
                    date_of_birth,
                    color,
                    sterilized,
                    sterilization_date,
                    found_date,
                    intake_date,
                    death_date,
                    special_needs_summary
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, animal.getName());
            statement.setString(2, animal.getSex());

            statement.setLong(3, animal.getSpeciesId());
            statement.setLong(4, animal.getBreedId());
            statement.setLong(5, animal.getOrganizationId());

            statement.setString(6, animal.getMicrochipNumber());

            if (animal.getDateOfBirth() != null) {
                statement.setDate(7,
                        java.sql.Date.valueOf(animal.getDateOfBirth()));
            } else {
                statement.setNull(7, Types.DATE);
            }

            statement.setString(8, animal.getColor());
            statement.setBoolean(9, animal.isSterilized());

            if (animal.getSterilizationDate() != null) {
                statement.setDate(10,
                        java.sql.Date.valueOf(animal.getSterilizationDate()));
            } else {
                statement.setNull(10, Types.DATE);
            }

            if (animal.getFoundDate() != null) {
                statement.setDate(11,
                        java.sql.Date.valueOf(animal.getFoundDate()));
            } else {
                statement.setNull(11, Types.DATE);
            }

            if (animal.getIntakeDate() != null) {
                statement.setDate(12,
                        java.sql.Date.valueOf(animal.getIntakeDate()));
            } else {
                statement.setNull(12, Types.DATE);
            }

            if (animal.getDeathDate() != null) {
                statement.setDate(13,
                        java.sql.Date.valueOf(animal.getDeathDate()));
            } else {
                statement.setNull(13, Types.DATE);
            }

            statement.setString(14, animal.getSpecialNeedsSummary());

            int rowsAffected = statement.executeUpdate();

            return rowsAffected > 0;
        }
    }
}
