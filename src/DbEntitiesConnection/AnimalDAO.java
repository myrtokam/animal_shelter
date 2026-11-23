
package DbEntitiesConnection;

import Model.Health.Animals;
import Util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnimalDAO {

    // CREATE
    public long insertAnimal(Animals animal) throws SQLException {

        if (animal == null) {
            throw new IllegalArgumentException("Animal cannot be null");
        }

        String sql = """
                INSERT INTO animals
                (name, sex, microchip_number, color,
                 species_id, breed_id, organization_id,
                 special_needs_summary)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, animal.getName());
            statement.setString(2,
                    animal.getSex() == null ? "UNKNOWN" : animal.getSex());
            statement.setString(3, animal.getMicrochipNumber());
            statement.setString(4, animal.getColor());

            setNullableId(statement, 5, animal.getSpeciesId());
            setNullableId(statement, 6, animal.getBreedId());
            setNullableId(statement, 7, animal.getOrganizationId());

            statement.setString(8, animal.getSpecialNeedsSummary());

            int rows = statement.executeUpdate();

            if (rows != 1) {
                throw new SQLException("Animal insertion failed");
            }

            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (keys.next()) {
                    long id = keys.getLong(1);
                    animal.setAnimalId(id);
                    return id;
                }
            }

            throw new SQLException("Generated animal ID not found");
        }
    }

    // READ ALL
    public List<Animals> getAnimals() throws SQLException {

        String sql = """
                SELECT animals_id, name, sex, microchip_number,
                       color, species_id, breed_id,
                       organization_id, special_needs_summary
                FROM animals
                ORDER BY animals_id
                LIMIT 1000
                """;

        List<Animals> animals = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                animals.add(mapAnimal(rs));
            }
        }

        return animals;
    }

    // READ BY ID
    public Animals getAnimalById(long animalId) throws SQLException {

        String sql = """
                SELECT animals_id, name, sex, microchip_number,
                       color, species_id, breed_id,
                       organization_id, special_needs_summary
                FROM animals
                WHERE animals_id = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, animalId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapAnimal(rs);
                }
            }
        }

        return null;
    }

    // READ BY MICROCHIP
    public Animals getAnimalByMicrochip(String microchip) throws SQLException {

        String sql = """
                SELECT animals_id, name, sex, microchip_number,
                       color, species_id, breed_id,
                       organization_id, special_needs_summary
                FROM animals
                WHERE microchip_number = ?
                ORDER BY animals_id
                LIMIT 1
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, microchip);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapAnimal(rs);
                }
            }
        }

        return null;
    }

    // UPDATE
    public boolean updateAnimal(Animals animal) throws SQLException {

        if (animal == null || animal.getAnimalId() <= 0) {
            throw new IllegalArgumentException("Valid animal ID required");
        }

        String sql = """
                UPDATE animals
                SET name = ?,
                    sex = ?,
                    microchip_number = ?,
                    color = ?,
                    species_id = ?,
                    breed_id = ?,
                    organization_id = ?,
                    special_needs_summary = ?
                WHERE animals_id = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, animal.getName());
            statement.setString(2,
                    animal.getSex() == null ? "UNKNOWN" : animal.getSex());
            statement.setString(3, animal.getMicrochipNumber());
            statement.setString(4, animal.getColor());

            setNullableId(statement, 5, animal.getSpeciesId());
            setNullableId(statement, 6, animal.getBreedId());
            setNullableId(statement, 7, animal.getOrganizationId());

            statement.setString(8, animal.getSpecialNeedsSummary());
            statement.setLong(9, animal.getAnimalId());

            return statement.executeUpdate() == 1;
        }
    }

    // DELETE
    public boolean deleteAnimal(long animalId) throws SQLException {

        String sql = "DELETE FROM animals WHERE animals_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, animalId);

            return statement.executeUpdate() == 1;
        }
    }

    // COUNT
    public long countAnimals() throws SQLException {

        String sql = "SELECT COUNT(*) FROM animals";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            if (rs.next()) {
                return rs.getLong(1);
            }
        }

        return 0;
    }

    // Convert database row into an Animals object
    private Animals mapAnimal(ResultSet rs) throws SQLException {

        Animals animal = new Animals();

        animal.setAnimalId(rs.getLong("animals_id"));
        animal.setName(rs.getString("name"));
        animal.setSex(rs.getString("sex"));
        animal.setMicrochipNumber(rs.getString("microchip_number"));
        animal.setColor(rs.getString("color"));

        animal.setSpeciesId(rs.getLong("species_id"));
        animal.setBreedId(rs.getLong("breed_id"));
        animal.setOrganizationId(rs.getLong("organization_id"));

        animal.setSpecialNeedsSummary(
                rs.getString("special_needs_summary"));

        return animal;
    }

    // Convert 0 into SQL NULL for optional foreign keys
    private void setNullableId(
            PreparedStatement statement, int index, long id
    ) throws SQLException {

        if (id <= 0) {
            statement.setNull(index, Types.BIGINT);
        } else {
            statement.setLong(index, id);
        }
    }
}


