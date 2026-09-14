import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AnimalDAO {

    private DatabaseConnection databaseConnection;

    public AnimalDAO(DatabaseConnection databaseConnection) {
        this.databaseConnection = databaseConnection;
    }

    public AnimalDAO() {

    }
    public boolean registerAnimal(Animals animal) throws SQLException {

        Connection dbConnection = databaseConnection.getConnection();

        String insertAnimalSql = """
                INSERT INTO animals (
                    animal_id,
                    microchip_number,
                    name,
                    species_id,
                    breed_id,
                    sex_id,
                    status_id,
                    date_of_birth,
                    estimated_birth_date,
                    color,
                    weight,
                    sterilized,
                    sterilization_date,
                    found_date,
                    intake_date,
                    death_date,
                    description,
                    special_needs,
                    created_at,
                    updated_at
                )
                VALUES (
                    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
                    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
                )
                """;

        PreparedStatement preparedStatement =
                dbConnection.prepareStatement(insertAnimalSql);

        preparedStatement.setInt(1, animal.getAnimalId());
        preparedStatement.setString(2, animal.getMicrochipNumber());
        preparedStatement.setString(3, animal.getName());
        preparedStatement.setInt(4, animal.getSpeciesId());
        preparedStatement.setInt(5, animal.getBreedId());
        preparedStatement.setString(6, animal.getSex_id());
        preparedStatement.setInt(7, animal.getStatus_id());

        preparedStatement.setDate(8, animal.getDate_of_birth());
        preparedStatement.setDate(9, animal.getEstimated_birth_date());

        preparedStatement.setString(10, animal.getColor());
        preparedStatement.setDouble(11, animal.getWeight());
        preparedStatement.setBoolean(12, animal.isSterilized());

        preparedStatement.setDate(13, animal.getSterilization_date());
        preparedStatement.setDate(14, animal.getFound_date());
        preparedStatement.setDate(15, animal.getIntake_date());
        preparedStatement.setDate(16, animal.getDeath_date());

        preparedStatement.setString(17, animal.getDescription());
        preparedStatement.setBoolean(18, animal.getSpecial_needs());

        preparedStatement.setDate(19, animal.getCreated_at());
        preparedStatement.setDate(20, animal.getUpdated_at());

        int rowsAffected = preparedStatement.executeUpdate();

        return rowsAffected > 0;
    }
}