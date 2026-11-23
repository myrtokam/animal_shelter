
package DbEntitiesConnection;

import Model.Health.Treatment;
import Util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TreatmentDAO {


    // DATABASE CONNECTION


    public void testConnection() throws SQLException {

        try (Connection connection =
                     DatabaseConnection.getConnection()) {

            System.out.println("Connection successful");
        }
    }


    // SELECT - TREATMENT PLANS


    public List<Treatment> getAllTreatmentPlans()
            throws SQLException {

        List<Treatment> treatments = new ArrayList<>();

        String sql = """
                SELECT
                    treatment_plans_id,
                    animal_id,
                    name,
                    description,
                    status,
                    created_at,
                    updated_at,
                    clinical_assessment,
                    clinical_recommendations,
                    followup_at
                FROM treatment_plans
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql);

             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Treatment treatment = new Treatment();

                treatment.setTreatmentId(
                        resultSet.getLong("treatment_plans_id")
                );

                long animalId =
                        resultSet.getLong("animal_id");

                if (!resultSet.wasNull()) {
                    treatment.setAnimalId(animalId);
                }

                treatment.setTreatmentName(
                        resultSet.getString("name")
                );

                treatment.setDescription(
                        resultSet.getString("description")
                );

                treatment.setStatus(
                        resultSet.getString("status")
                );

                treatment.setDiagnosis(
                        resultSet.getString("clinical_assessment")
                );

                treatment.setInstructions(
                        resultSet.getString("clinical_recommendations")
                );

                Timestamp createdAt =
                        resultSet.getTimestamp("created_at");

                if (createdAt != null) {
                    treatment.setCreatedAt(
                            createdAt.toLocalDateTime()
                    );
                }

                Timestamp updatedAt =
                        resultSet.getTimestamp("updated_at");

                if (updatedAt != null) {
                    treatment.setUpdatedAt(
                            updatedAt.toLocalDateTime()
                    );
                }

                Timestamp followupAt =
                        resultSet.getTimestamp("followup_at");

                if (followupAt != null) {
                    treatment.setNextReviewDate(
                            followupAt.toLocalDateTime()
                                    .toLocalDate()
                    );
                }

                treatment.setTreatmentType("GENERAL");

                treatments.add(treatment);
            }
        }

        return treatments;
    }

    // SELECT - TREATMENT PROGRESS


    public List<Treatment> getTreatmentProgress(
            long treatmentPlanId) throws SQLException {

        List<Treatment> progressList = new ArrayList<>();

        String sql = """
                SELECT
                    treatment_progress_id,
                    treatment_plan_id,
                    name,
                    description,
                    status,
                    clinical_findings,
                    clinical_assessment,
                    clinical_recommendations,
                    observed_at,
                    created_at,
                    updated_at
                FROM treatment_progress
                WHERE treatment_plan_id = ?
                ORDER BY observed_at DESC,
                         treatment_progress_id DESC
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, treatmentPlanId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Treatment treatment = new Treatment();

                    treatment.setTreatmentId(
                            resultSet.getLong(
                                    "treatment_progress_id"
                            )
                    );

                    treatment.setTreatmentName(
                            resultSet.getString("name")
                    );

                    treatment.setDescription(
                            resultSet.getString("description")
                    );

                    treatment.setStatus(
                            resultSet.getString("status")
                    );

                    treatment.setDiagnosis(
                            resultSet.getString(
                                    "clinical_assessment"
                            )
                    );

                    treatment.setNotes(
                            resultSet.getString(
                                    "clinical_findings"
                            )
                    );

                    treatment.setInstructions(
                            resultSet.getString(
                                    "clinical_recommendations"
                            )
                    );

                    Timestamp observedAt =
                            resultSet.getTimestamp("observed_at");

                    if (observedAt != null) {
                        treatment.setStartDate(
                                observedAt.toLocalDateTime()
                                        .toLocalDate()
                        );
                    }

                    Timestamp createdAt =
                            resultSet.getTimestamp("created_at");

                    if (createdAt != null) {
                        treatment.setCreatedAt(
                                createdAt.toLocalDateTime()
                        );
                    }

                    Timestamp updatedAt =
                            resultSet.getTimestamp("updated_at");

                    if (updatedAt != null) {
                        treatment.setUpdatedAt(
                                updatedAt.toLocalDateTime()
                        );
                    }

                    treatment.setTreatmentType("PROGRESS");

                    progressList.add(treatment);
                }
            }
        }

        return progressList;
    }


    // SELECT - PARASITE TREATMENTS


    public List<Treatment> getParasiteTreatmentsByAnimal(
            long animalId) throws SQLException {

        List<Treatment> treatments = new ArrayList<>();

        String sql = """
                SELECT
                    parasite_treatments_id,
                    animal_id,
                    name,
                    description,
                    status,
                    clinical_findings,
                    clinical_assessment,
                    observed_at,
                    created_at,
                    updated_at
                FROM parasite_treatments
                WHERE animal_id = ?
                ORDER BY created_at DESC
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, animalId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Treatment treatment = new Treatment();

                    treatment.setTreatmentId(
                            resultSet.getLong(
                                    "parasite_treatments_id"
                            )
                    );

                    treatment.setAnimalId(
                            resultSet.getLong("animal_id")
                    );

                    treatment.setTreatmentName(
                            resultSet.getString("name")
                    );

                    treatment.setDescription(
                            resultSet.getString("description")
                    );

                    treatment.setStatus(
                            resultSet.getString("status")
                    );

                    treatment.setNotes(
                            resultSet.getString(
                                    "clinical_findings"
                            )
                    );

                    treatment.setDiagnosis(
                            resultSet.getString(
                                    "clinical_assessment"
                            )
                    );

                    Timestamp observedAt =
                            resultSet.getTimestamp("observed_at");

                    if (observedAt != null) {
                        treatment.setStartDate(
                                observedAt.toLocalDateTime()
                                        .toLocalDate()
                        );
                    }

                    Timestamp createdAt =
                            resultSet.getTimestamp("created_at");

                    if (createdAt != null) {
                        treatment.setCreatedAt(
                                createdAt.toLocalDateTime()
                        );
                    }

                    Timestamp updatedAt =
                            resultSet.getTimestamp("updated_at");

                    if (updatedAt != null) {
                        treatment.setUpdatedAt(
                                updatedAt.toLocalDateTime()
                        );
                    }

                    treatment.setTreatmentType("PARASITE");

                    treatments.add(treatment);
                }
            }
        }

        return treatments;
    }


    /// ///////////////////////////////////////////////////
    // INSERT - PLACEHOLDERS
    public void createTreatmentPlan(Treatment treatment) {
        // TODO: INSERT INTO treatment_plans
    }

    public void recordTreatmentProgress(
            long treatmentPlanId,
            String description) {

        // TODO: INSERT INTO treatment_progress
    }

    public void recordParasiteTreatment(
            long animalId,
            String description) {

        // TODO: INSERT INTO parasite_treatments
    }

    /// ///////////////////////////////////////////////////
    // UPDATE - PLACEHOLDERS
    public void updateTreatmentPlan(Treatment treatment) {
        // TODO: UPDATE treatment_plans
    }

    public void updateTreatmentProgress(
            long progressId,
            String description) {

        // TODO: UPDATE treatment_progress
    }

    public void updateParasiteTreatment(Treatment treatment) {
        // TODO: UPDATE parasite_treatments
    }

    /// ///////////////////////////////////////////////////
    // DELETE - PLACEHOLDERS
    public void deleteTreatmentPlan(long treatmentPlanId) {
        // TODO: DELETE FROM treatment_plans
    }

    public void deleteTreatmentProgress(long progressId) {
        // TODO: DELETE FROM treatment_progress
    }

    public void deleteParasiteTreatment(long parasiteTreatmentId) {
        // TODO: DELETE FROM parasite_treatments
    }
}
