
package DbEntitiesConnection;

import Model.Health.Appointment;
import Model.Health.Appoitment_types;
import Util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {


    // ==========================================
    // BASE SELECT QUERIES
    // ==========================================

    private static final String BASE_SELECT = """
            SELECT
                a.*,
                at.name AS appointment_type_name,
                at.description AS appointment_type_description
            FROM appointments a
            LEFT JOIN appointment_types at
                ON a.appointment_type_id =
                   at.appointment_types_id
            """;


    private static final String TYPE_SELECT = """
            SELECT
                appointment_types_id,
                name,
                description,
                status,
                created_at,
                updated_at,
                recorded_by_user_id,
                verified_by_user_id,
                verified_at,
                review_due_at,
                record_reference,
                record_source
            FROM appointment_types
            """;


    // ==========================================
    // TEST CONNECTION
    // ==========================================

    public void testConnection() throws SQLException {

        try (Connection connection =
                     DatabaseConnection.getConnection()) {

            System.out.println("Connection Successful");
        }
    }


    // ==========================================
    // READ ALL APPOINTMENTS
    // ==========================================

    public List<Appointment> appointments()
            throws SQLException {

        String sql = BASE_SELECT + """
                ORDER BY a.appointments_id
                LIMIT 1000
                """;

        return executeAppointmentQuery(sql);
    }


    // ==========================================
    // READ APPOINTMENT BY ID
    // ==========================================

    public Appointment getAppointmentById(long appointmentId)
            throws SQLException {

        String sql = BASE_SELECT + """
                WHERE a.appointments_id = ?
                """;

        List<Appointment> results =
                executeAppointmentQuery(sql, appointmentId);

        return results.isEmpty() ? null : results.get(0);
    }


    // ==========================================
    // READ APPOINTMENTS BY ANIMAL
    // ==========================================

    public List<Appointment> getAppointmentsByAnimal(
            long animalId) throws SQLException {

        String sql = BASE_SELECT + """
                WHERE a.animal_id = ?
                ORDER BY a.starts_at DESC
                """;

        return executeAppointmentQuery(sql, animalId);
    }


    // ==========================================
    // READ APPOINTMENTS BY VETERINARIAN
    // ==========================================

    public List<Appointment> getAppointmentsByVeterinarian(
            long veterinarianId) throws SQLException {

        String sql = BASE_SELECT + """
                WHERE a.veterinarian_id = ?
                ORDER BY a.starts_at DESC
                """;

        return executeAppointmentQuery(sql, veterinarianId);
    }


    // ==========================================
    // READ APPOINTMENTS BY ORGANIZATION
    // ==========================================

    public List<Appointment> getAppointmentsByOrganization(
            long organizationId) throws SQLException {

        String sql = BASE_SELECT + """
                WHERE a.organization_id = ?
                ORDER BY a.starts_at DESC
                """;

        return executeAppointmentQuery(sql, organizationId);
    }


    // ==========================================
    // READ APPOINTMENT TYPES
    // ==========================================

    public List<Appoitment_types> getAppointmentTypes()
            throws SQLException {

        String sql = TYPE_SELECT + """
                ORDER BY name
                """;

        return executeTypeQuery(sql);
    }


    // ==========================================
    // READ ACTIVE APPOINTMENT TYPES
    // ==========================================

    public List<Appoitment_types> getActiveAppointmentTypes()
            throws SQLException {

        String sql = TYPE_SELECT + """
                WHERE status = ?
                ORDER BY name
                """;

        return executeTypeQuery(sql, "ACTIVE");
    }


    // ==========================================
    // READ APPOINTMENT TYPE BY ID
    // ==========================================

    public Appoitment_types getAppointmentTypeById(
            long appointmentTypeId) throws SQLException {

        String sql = TYPE_SELECT + """
                WHERE appointment_types_id = ?
                """;

        List<Appoitment_types> results =
                executeTypeQuery(sql, appointmentTypeId);

        return results.isEmpty() ? null : results.get(0);
    }


    // ==========================================
    // READ APPOINTMENTS BY TYPE ID
    // ==========================================

    public List<Appointment> getAppointmentsByType(
            long appointmentTypeId) throws SQLException {

        String sql = BASE_SELECT + """
                WHERE a.appointment_type_id = ?
                ORDER BY a.starts_at DESC
                """;

        return executeAppointmentQuery(sql, appointmentTypeId);
    }


    // ==========================================
    // READ APPOINTMENTS BY TYPE NAME
    // ==========================================

    public List<Appointment> getAppointmentsByTypeName(
            String typeName) throws SQLException {

        String sql = BASE_SELECT + """
                WHERE at.name = ?
                ORDER BY a.starts_at DESC
                """;

        return executeAppointmentQuery(sql, typeName);
    }


    // ==========================================
    // READ APPOINTMENTS BY STATUS
    // ==========================================

    public List<Appointment> getAppointmentsByStatus(
            String status) throws SQLException {

        String sql = BASE_SELECT + """
                WHERE a.status = ?
                ORDER BY a.starts_at DESC
                """;

        return executeAppointmentQuery(sql, status);
    }


    // ==========================================
    // READ APPOINTMENTS BY BOOKING TYPE
    // ==========================================

    public List<Appointment> getAppointmentsByBookingType(
            String bookingType) throws SQLException {

        String sql = BASE_SELECT + """
                WHERE a.booking_type = ?
                ORDER BY a.starts_at DESC
                """;

        return executeAppointmentQuery(sql, bookingType);
    }


    // ==========================================
    // READ APPOINTMENTS BY TRIAGE LEVEL
    // ==========================================

    public List<Appointment> getAppointmentsByTriageLevel(
            String triageLevel) throws SQLException {

        String sql = BASE_SELECT + """
                WHERE a.triage_level = ?
                ORDER BY a.starts_at DESC
                """;

        return executeAppointmentQuery(sql, triageLevel);
    }


    // ==========================================
    // GENERAL CONSULTATIONS
    // ==========================================

    public List<Appointment> getGeneralConsultations()
            throws SQLException {

        return getAppointmentsByTypeName(
                "General Consultation"
        );
    }


    // ==========================================
    // SCHEDULED APPOINTMENTS
    // ==========================================

    public List<Appointment> getScheduledAppointments()
            throws SQLException {

        return getAppointmentsByBookingType("SCHEDULED");
    }


    // ==========================================
    // WALK-IN APPOINTMENTS
    // ==========================================

    public List<Appointment> getWalkInAppointments()
            throws SQLException {

        return getAppointmentsByBookingType("WALK_IN");
    }


    // ==========================================
    // UNSCHEDULED APPOINTMENTS
    // ==========================================

    public List<Appointment> getUnscheduledAppointments()
            throws SQLException {

        return getAppointmentsByBookingType("UNSCHEDULED");
    }


    // ==========================================
    // URGENT APPOINTMENTS
    // ==========================================

    public List<Appointment> getUrgentAppointments()
            throws SQLException {

        return getAppointmentsByTriageLevel("URGENT");
    }


    // ==========================================
    // EMERGENCY APPOINTMENTS
    // ==========================================

    public List<Appointment> getEmergencyAppointments()
            throws SQLException {

        String sql = BASE_SELECT + """
                WHERE a.triage_level IN (?, ?)
                ORDER BY a.starts_at DESC
                """;

        return executeAppointmentQuery(
                sql,
                "EMERGENCY",
                "CRITICAL"
        );
    }


    // ==========================================
    // CRITICAL APPOINTMENTS
    // ==========================================

    public List<Appointment> getCriticalAppointments()
            throws SQLException {

        return getAppointmentsByTriageLevel("CRITICAL");
    }


    // ==========================================
    // ALL SURGERIES
    // ==========================================

    public List<Appointment> getSurgeries()
            throws SQLException {

        return getAppointmentsByTypeName("Surgery");
    }


    // ==========================================
    // EMERGENCY SURGERIES
    // ==========================================

    public List<Appointment> getEmergencySurgeries()
            throws SQLException {

        String sql = BASE_SELECT + """
                WHERE at.name = ?
                AND a.triage_level IN (?, ?)
                ORDER BY a.starts_at DESC
                """;

        return executeAppointmentQuery(
                sql,
                "Surgery",
                "EMERGENCY",
                "CRITICAL"
        );
    }


    // ==========================================
    // SCHEDULED SURGERIES
    // ==========================================

    public List<Appointment> getScheduledSurgeries()
            throws SQLException {

        String sql = BASE_SELECT + """
                WHERE at.name = ?
                AND a.booking_type = ?
                ORDER BY a.starts_at
                """;

        return executeAppointmentQuery(
                sql,
                "Surgery",
                "SCHEDULED"
        );
    }


    // ==========================================
    // HOSPITALIZATIONS
    // ==========================================

    public List<Appointment> getHospitalizations()
            throws SQLException {

        return getAppointmentsByTypeName("Hospitalization");
    }


    // ==========================================
    // FOLLOW-UP APPOINTMENTS
    // ==========================================

    public List<Appointment> getFollowUpAppointments()
            throws SQLException {

        return getAppointmentsByTypeName(
                "Follow-up Examination"
        );
    }


    // ==========================================
    // VACCINATION APPOINTMENTS
    // ==========================================

    public List<Appointment> getVaccinationAppointments()
            throws SQLException {

        return getAppointmentsByTypeName("Vaccination");
    }


    // ==========================================
    // STERILIZATION APPOINTMENTS
    // ==========================================

    public List<Appointment> getSterilizationAppointments()
            throws SQLException {

        return getAppointmentsByTypeName("Sterilization");
    }


    // ==========================================
    // DIAGNOSTIC EXAMINATIONS
    // ==========================================

    public List<Appointment> getDiagnosticExaminations()
            throws SQLException {

        return getAppointmentsByTypeName(
                "Diagnostic Examination"
        );
    }


    // ==========================================
    // APPOINTMENTS BY DATE RANGE
    // ==========================================

    public List<Appointment> getAppointmentsByDateRange(
            LocalDateTime from,
            LocalDateTime to) throws SQLException {

        if (from == null || to == null || !to.isAfter(from)) {

            throw new IllegalArgumentException(
                    "Invalid date range"
            );
        }

        String sql = BASE_SELECT + """
                WHERE a.starts_at >= ?
                AND a.starts_at < ?
                ORDER BY a.starts_at
                """;

        return executeAppointmentQuery(
                sql,
                Timestamp.valueOf(from),
                Timestamp.valueOf(to)
        );
    }


    // ==========================================
    // COMPLETED APPOINTMENTS
    // ==========================================

    public List<Appointment> getCompletedAppointments()
            throws SQLException {

        return getAppointmentsByStatus("COMPLETED");
    }


    // ==========================================
    // CANCELLED APPOINTMENTS
    // ==========================================

    public List<Appointment> getCancelledAppointments()
            throws SQLException {

        return getAppointmentsByStatus("CANCELLED");
    }


    // ==========================================
    // UNCLASSIFIED APPOINTMENTS
    // ==========================================

    public List<Appointment> getUnclassifiedAppointments()
            throws SQLException {

        String sql = BASE_SELECT + """
                WHERE a.booking_type IS NULL
                OR a.triage_level IS NULL
                OR a.appointment_type_id IS NULL
                ORDER BY a.appointments_id
                """;

        return executeAppointmentQuery(sql);
    }


    // ==========================================
    // COUNT APPOINTMENTS
    // ==========================================

    public long countAppointments() throws SQLException {

        String sql = """
                SELECT COUNT(*) AS total
                FROM appointments
                """;

        return executeCountQuery(sql);
    }


    // ==========================================
    // COUNT APPOINTMENTS BY ANIMAL
    // ==========================================

    public long countAppointmentsByAnimal(
            long animalId) throws SQLException {

        String sql = """
                SELECT COUNT(*) AS total
                FROM appointments
                WHERE animal_id = ?
                """;

        return executeCountQuery(sql, animalId);
    }


    // ==========================================
    // COUNT APPOINTMENT TYPES
    // ==========================================

    public long countAppointmentTypes() throws SQLException {

        String sql = """
                SELECT COUNT(*) AS total
                FROM appointment_types
                """;

        return executeCountQuery(sql);
    }


    // ==========================================
    // EXECUTE APPOINTMENT QUERY
    // ==========================================

    private List<Appointment> executeAppointmentQuery(
            String sql,
            Object... parameters) throws SQLException {

        List<Appointment> appointments = new ArrayList<>();

        try (Connection connection =
                     DatabaseConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            setParameters(statement, parameters);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    appointments.add(
                            mapAppointment(resultSet)
                    );
                }
            }
        }

        return appointments;
    }


    // ==========================================
    // EXECUTE APPOINTMENT TYPE QUERY
    // ==========================================

    private List<Appoitment_types> executeTypeQuery(
            String sql,
            Object... parameters) throws SQLException {

        List<Appoitment_types> types = new ArrayList<>();

        try (Connection connection =
                     DatabaseConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            setParameters(statement, parameters);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    types.add(
                            mapAppointmentType(resultSet)
                    );
                }
            }
        }

        return types;
    }


    // ==========================================
    // EXECUTE COUNT QUERY
    // ==========================================

    private long executeCountQuery(
            String sql,
            Object... parameters) throws SQLException {

        try (Connection connection =
                     DatabaseConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            setParameters(statement, parameters);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    return resultSet.getLong("total");
                }
            }
        }

        return 0;
    }


    // ==========================================
    // MAP APPOINTMENT
    // ==========================================

    private Appointment mapAppointment(
            ResultSet resultSet) throws SQLException {

        Appointment appointment = new Appointment();


        // IDENTIFICATION

        appointment.setAppointmentId(
                resultSet.getLong("appointments_id")
        );

        appointment.setOrganizationId(
                getNullableLong(resultSet, "organization_id")
        );

        appointment.setAnimalId(
                getNullableLong(resultSet, "animal_id")
        );

        appointment.setAppointmentTypeId(
                getNullableLong(resultSet, "appointment_type_id")
        );

        appointment.setVeterinarianId(
                getNullableLong(resultSet, "veterinarian_id")
        );


        // CLASSIFICATION

        appointment.setAppointmentTypeName(
                resultSet.getString("appointment_type_name")
        );

        appointment.setAppointmentTypeDescription(
                resultSet.getString("appointment_type_description")
        );

        appointment.setBookingType(
                resultSet.getString("booking_type")
        );

        appointment.setTriageLevel(
                resultSet.getString("triage_level")
        );

        appointment.setStatus(
                resultSet.getString("status")
        );


        // DATE AND TIME

        appointment.setStartsAt(
                getDateTime(resultSet, "starts_at")
        );

        appointment.setEndsAt(
                getDateTime(resultSet, "ends_at")
        );

        appointment.setServiceDatetime(
                getDateTime(resultSet, "service_datetime")
        );

        appointment.setCheckinAt(
                getDateTime(resultSet, "checkin_at")
        );

        appointment.setCheckoutAt(
                getDateTime(resultSet, "checkout_at")
        );

        appointment.setFollowupDueAt(
                getDateTime(resultSet, "followup_due_at")
        );


        // CLINICAL INFORMATION

        appointment.setAppointmentReason(
                resultSet.getString("appointment_reason")
        );

        appointment.setClientInstructions(
                resultSet.getString("client_instructions")
        );

        appointment.setServiceOutcome(
                resultSet.getString("service_outcome")
        );

        appointment.setCancellationReason(
                resultSet.getString("cancellation_reason")
        );

        appointment.setNotes(
                resultSet.getString("notes")
        );


        // RECORD INFORMATION

        appointment.setBillingReference(
                resultSet.getString("billing_reference")
        );

        appointment.setRecordReference(
                resultSet.getString("record_reference")
        );

        appointment.setRecordSource(
                resultSet.getString("record_source")
        );


        // AUDIT INFORMATION

        appointment.setRecordedByUserId(
                getNullableLong(resultSet, "recorded_by_user_id")
        );

        appointment.setVerifiedByUserId(
                getNullableLong(resultSet, "verified_by_user_id")
        );

        appointment.setCreatedAt(
                getDateTime(resultSet, "created_at")
        );

        appointment.setUpdatedAt(
                getDateTime(resultSet, "updated_at")
        );

        appointment.setVerifiedAt(
                getDateTime(resultSet, "verified_at")
        );

        appointment.setReviewDueAt(
                getDateTime(resultSet, "review_due_at")
        );

        return appointment;
    }


    // ==========================================
    // MAP APPOINTMENT TYPE
    // ==========================================

    private Appoitment_types mapAppointmentType(
            ResultSet resultSet) throws SQLException {

        Appoitment_types type = new Appoitment_types();

        type.setAppointmentTypeId(
                resultSet.getLong("appointment_types_id")
        );

        type.setName(
                resultSet.getString("name")
        );

        type.setDescription(
                resultSet.getString("description")
        );

        type.setStatus(
                resultSet.getString("status")
        );

        type.setCreatedAt(
                getDateTime(resultSet, "created_at")
        );

        type.setUpdatedAt(
                getDateTime(resultSet, "updated_at")
        );

        type.setRecordedByUserId(
                getNullableLong(resultSet, "recorded_by_user_id")
        );

        type.setVerifiedByUserId(
                getNullableLong(resultSet, "verified_by_user_id")
        );

        type.setVerifiedAt(
                getDateTime(resultSet, "verified_at")
        );

        type.setReviewDueAt(
                getDateTime(resultSet, "review_due_at")
        );

        type.setRecordReference(
                resultSet.getString("record_reference")
        );

        type.setRecordSource(
                resultSet.getString("record_source")
        );

        return type;
    }


    // ==========================================
    // HELPER METHODS
    // ==========================================

    private void setParameters(
            PreparedStatement statement,
            Object... parameters) throws SQLException {

        for (int i = 0; i < parameters.length; i++) {

            statement.setObject(i + 1, parameters[i]);
        }
    }


    private LocalDateTime getDateTime(
            ResultSet resultSet,
            String columnName) throws SQLException {

        Timestamp timestamp =
                resultSet.getTimestamp(columnName);

        return timestamp != null
                ? timestamp.toLocalDateTime()
                : null;
    }


    private Long getNullableLong(
            ResultSet resultSet,
            String columnName) throws SQLException {

        long value = resultSet.getLong(columnName);

        return resultSet.wasNull() ? null : value;
    }


    // ==========================================
    // INSERT - PLACEHOLDERS
    // ==========================================

    public void createAppointment(Appointment appointment) {

        // TODO: INSERT INTO appointments

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    public void createAppointmentType(Appoitment_types type) {

        // TODO: INSERT INTO appointment_types

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    public void recordStatusHistory(
            long appointmentId,
            String status) {

        // TODO: INSERT INTO appointment_status_history

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    // ==========================================
    // UPDATE - PLACEHOLDERS
    // ==========================================

    public void updateAppointment(Appointment appointment) {

        // TODO: UPDATE appointments

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    public void updateAppointmentType(Appoitment_types type) {

        // TODO: UPDATE appointment_types

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    public void updateAppointmentStatus(
            long appointmentId,
            String status) {

        // TODO: UPDATE appointments
        // TODO: INSERT INTO appointment_status_history
        // TODO: Use SQL transaction

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    public void cancelAppointment(
            long appointmentId,
            String reason) {

        // TODO: UPDATE appointments
        // TODO: INSERT INTO appointment_status_history

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    public void rescheduleAppointment(
            long appointmentId,
            LocalDateTime startsAt,
            LocalDateTime endsAt) {

        // TODO: UPDATE appointment dates

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    public void updateBookingType(
            long appointmentId,
            String bookingType) {

        // TODO: UPDATE booking_type

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    public void updateTriageLevel(
            long appointmentId,
            String triageLevel) {

        // TODO: UPDATE triage_level

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    // ==========================================
    // DELETE - PLACEHOLDERS
    // ==========================================

    public void deleteAppointment(long appointmentId) {

        // TODO: Check foreign key references
        // TODO: Check retention requirements

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }


    public void deleteAppointmentType(long appointmentTypeId) {

        // TODO: Check foreign key references
        // Prefer deactivation over deletion

        throw new UnsupportedOperationException(
                "Not implemented yet"
        );
    }
}
