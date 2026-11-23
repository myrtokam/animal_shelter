
package DbEntitiesConnection;

import Model.Health.Medication;
import Util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicationDAO {

    // DATABASE CONNECTION

    public void testConnection() throws SQLException {

        try (Connection connection =
                     DatabaseConnection.getConnection()) {

            System.out.println("Connection successful");
        }
    }

    // SELECT - ALL MEDICATIONS

    public List<Medication> getAllMedications()
            throws SQLException {

        List<Medication> medications = new ArrayList<>();

        String sql = """
                SELECT
                    medications_id,
                    name,
                    active_ingredient,
                    form,
                    strength,
                    created_at,
                    updated_at
                FROM medications
                ORDER BY medications_id
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Medication medication = new Medication();

                medication.setMedicationId(
                        resultSet.getLong("medications_id")
                );

                medication.setMedicationName(
                        resultSet.getString("name")
                );

                medication.setActiveIngredient(
                        resultSet.getString("active_ingredient")
                );

                medication.setForm(
                        resultSet.getString("form")
                );

                medication.setStrength(
                        resultSet.getString("strength")
                );

                Timestamp createdAt =
                        resultSet.getTimestamp("created_at");

                if (createdAt != null) {
                    medication.setCreatedAt(
                            createdAt.toLocalDateTime()
                    );
                }

                Timestamp updatedAt =
                        resultSet.getTimestamp("updated_at");

                if (updatedAt != null) {
                    medication.setUpdatedAt(
                            updatedAt.toLocalDateTime()
                    );
                }

                medications.add(medication);
            }
        }

        return medications;
    }

    // SELECT - MEDICATION BY ID

    public Medication getMedicationById(long medicationId)
            throws SQLException {

        String sql = """
                SELECT
                    medications_id,
                    name,
                    active_ingredient,
                    form,
                    strength,
                    created_at,
                    updated_at
                FROM medications
                WHERE medications_id = ?
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, medicationId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    Medication medication = new Medication();

                    medication.setMedicationId(
                            resultSet.getLong("medications_id")
                    );

                    medication.setMedicationName(
                            resultSet.getString("name")
                    );

                    medication.setActiveIngredient(
                            resultSet.getString("active_ingredient")
                    );

                    medication.setForm(
                            resultSet.getString("form")
                    );

                    medication.setStrength(
                            resultSet.getString("strength")
                    );

                    Timestamp createdAt =
                            resultSet.getTimestamp("created_at");

                    if (createdAt != null) {
                        medication.setCreatedAt(
                                createdAt.toLocalDateTime()
                        );
                    }

                    Timestamp updatedAt =
                            resultSet.getTimestamp("updated_at");

                    if (updatedAt != null) {
                        medication.setUpdatedAt(
                                updatedAt.toLocalDateTime()
                        );
                    }

                    return medication;
                }
            }
        }

        return null;
    }

    // SELECT - MEDICATION SCHEDULES BY ANIMAL

    public List<Medication> getMedicationSchedulesByAnimal(
            long animalId) throws SQLException {

        List<Medication> schedules = new ArrayList<>();

        String sql = """
                SELECT
                    medication_schedules_id,
                    animal_id,
                    scheduled_at,
                    dose_amount,
                    dose_unit,
                    created_at,
                    updated_at
                FROM medication_schedules
                WHERE animal_id = ?
                ORDER BY scheduled_at
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, animalId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Medication medication = new Medication();

                    medication.setMedicationScheduleId(
                            resultSet.getLong(
                                    "medication_schedules_id"
                            )
                    );

                    long dbAnimalId =
                            resultSet.getLong("animal_id");

                    if (!resultSet.wasNull()) {
                        medication.setAnimalId(dbAnimalId);
                    }

                    Timestamp scheduledAt =
                            resultSet.getTimestamp("scheduled_at");

                    if (scheduledAt != null) {
                        medication.setScheduledAt(
                                scheduledAt.toLocalDateTime()
                        );
                    }

                    medication.setScheduledDoseAmount(
                            resultSet.getBigDecimal("dose_amount")
                    );

                    medication.setDoseUnit(
                            resultSet.getString("dose_unit")
                    );

                    Timestamp createdAt =
                            resultSet.getTimestamp("created_at");

                    if (createdAt != null) {
                        medication.setCreatedAt(
                                createdAt.toLocalDateTime()
                        );
                    }

                    Timestamp updatedAt =
                            resultSet.getTimestamp("updated_at");

                    if (updatedAt != null) {
                        medication.setUpdatedAt(
                                updatedAt.toLocalDateTime()
                        );
                    }

                    schedules.add(medication);
                }
            }
        }

        return schedules;
    }

    // SELECT - ADMINISTRATIONS BY ANIMAL

    public List<Medication> getAdministrationsByAnimal(
            long animalId) throws SQLException {

        List<Medication> administrations = new ArrayList<>();

        String sql = """
                SELECT
                    medication_administrations_id,
                    animal_id,
                    medication_schedule_id,
                    administered_at,
                    dose_amount,
                    outcome,
                    notes,
                    created_at,
                    updated_at
                FROM medication_administrations
                WHERE animal_id = ?
                ORDER BY administered_at DESC
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, animalId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Medication medication = new Medication();

                    medication.setMedicationAdministrationId(
                            resultSet.getLong(
                                    "medication_administrations_id"
                            )
                    );

                    long dbAnimalId =
                            resultSet.getLong("animal_id");

                    if (!resultSet.wasNull()) {
                        medication.setAnimalId(dbAnimalId);
                    }

                    long scheduleId =
                            resultSet.getLong("medication_schedule_id");

                    if (!resultSet.wasNull()) {
                        medication.setMedicationScheduleId(scheduleId);
                    }

                    Timestamp administeredAt =
                            resultSet.getTimestamp("administered_at");

                    if (administeredAt != null) {
                        medication.setAdministeredAt(
                                administeredAt.toLocalDateTime()
                        );
                    }

                    medication.setAdministeredDoseAmount(
                            resultSet.getBigDecimal("dose_amount")
                    );

                    medication.setAdministrationOutcome(
                            resultSet.getString("outcome")
                    );

                    medication.setNotes(
                            resultSet.getString("notes")
                    );

                    Timestamp createdAt =
                            resultSet.getTimestamp("created_at");

                    if (createdAt != null) {
                        medication.setCreatedAt(
                                createdAt.toLocalDateTime()
                        );
                    }

                    Timestamp updatedAt =
                            resultSet.getTimestamp("updated_at");

                    if (updatedAt != null) {
                        medication.setUpdatedAt(
                                updatedAt.toLocalDateTime()
                        );
                    }

                    administrations.add(medication);
                }
            }
        }

        return administrations;
    }

    // SELECT - ADMINISTRATION DETAILS

    public List<Medication> getAdministrationDetails(
            long administrationId) throws SQLException {

        List<Medication> details = new ArrayList<>();

        String sql = """
                SELECT
                    medication_administration_details_id,
                    administration_id,
                    dosage_unit_id,
                    route_id,
                    actual_dose,
                    batch_number,
                    administered_by_name,
                    missed_reason,
                    adverse_event_notes
                FROM medication_administration_details
                WHERE administration_id = ?
                ORDER BY medication_administration_details_id
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, administrationId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Medication medication = new Medication();

                    medication.setAdministrationDetailId(
                            resultSet.getLong(
                                    "medication_administration_details_id"
                            )
                    );

                    long parentId =
                            resultSet.getLong("administration_id");

                    if (!resultSet.wasNull()) {
                        medication.setMedicationAdministrationId(
                                parentId
                        );
                    }

                    long dosageUnitId =
                            resultSet.getLong("dosage_unit_id");

                    if (!resultSet.wasNull()) {
                        medication.setDosageUnitId(dosageUnitId);
                    }

                    long routeId =
                            resultSet.getLong("route_id");

                    if (!resultSet.wasNull()) {
                        medication.setAdministrationRouteId(routeId);
                    }

                    medication.setActualDose(
                            resultSet.getBigDecimal("actual_dose")
                    );

                    medication.setBatchNumber(
                            resultSet.getString("batch_number")
                    );

                    medication.setAdministeredByName(
                            resultSet.getString("administered_by_name")
                    );

                    medication.setMissedReason(
                            resultSet.getString("missed_reason")
                    );

                    medication.setAdverseEventNotes(
                            resultSet.getString("adverse_event_notes")
                    );

                    details.add(medication);
                }
            }
        }

        return details;
    }

    // INSERT - PLACEHOLDERS

    public void addMedication(Medication medication) {
        // TODO: INSERT INTO medications
    }

    public void scheduleMedication(Medication medication) {
        // TODO: INSERT INTO medication_schedules
    }

    public void recordAdministration(Medication medication) {
        // TODO: INSERT INTO medication_administrations
    }

    public void recordAdministrationDetails(Medication medication) {
        // TODO: INSERT INTO medication_administration_details
    }

    // UPDATE - PLACEHOLDERS

    public void updateMedication(Medication medication) {
        // TODO: UPDATE medications
    }

    public void updateMedicationSchedule(Medication medication) {
        // TODO: UPDATE medication_schedules
    }

    public void updateAdministration(Medication medication) {
        // TODO: UPDATE medication_administrations
    }

    public void updateAdministrationDetails(Medication medication) {
        // TODO: UPDATE medication_administration_details
    }

    // DELETE - PLACEHOLDERS

    public void deleteMedication(long medicationId) {
        // TODO: DELETE FROM medications
    }

    public void deleteMedicationSchedule(long scheduleId) {
        // TODO: DELETE FROM medication_schedules
    }

    public void deleteAdministration(long administrationId) {
        // TODO: DELETE FROM medication_administrations
    }

    public void deleteAdministrationDetails(long detailId) {
        // TODO: DELETE FROM medication_administration_details
    }
}
