
package DbEntitiesConnection;

import Model.Health.Appointment;
import Util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public void testConnection() throws SQLException {

        try (Connection connection = DatabaseConnection.getConnection()) {
            System.out.println("Connection Successful");
        }
    }

    public List<Appointment> appointments() throws SQLException {

        String SQL = """
                SELECT appointments_id, starts_at, ends_at,
                       status, organization_id, animal_id, appointment_type_id,
                       veterinarian_id, created_at, updated_at, service_datetime,
                       checkin_at, checkout_at, triage_level, appointment_reason,
                       client_instructions, service_outcome, followup_due_at,
                       cancellation_reason, billing_reference, record_reference,
                       record_source, recorded_by_user_id, verified_by_user_id,
                       verified_at, review_due_at
                FROM appointments
                ORDER BY appointments_id
                LIMIT 1000
                """;

        List<Appointment> appointment = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(SQL);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Appointment appointments = new Appointment();

                appointments.setAppointmentId(
                        resultSet.getLong("appointments_id")
                );

                Timestamp startsAt = resultSet.getTimestamp("starts_at");
                appointments.setStartsAt(
                        startsAt != null ? startsAt.toLocalDateTime() : null
                );

                Timestamp endsAt = resultSet.getTimestamp("ends_at");
                appointments.setEndsAt(
                        endsAt != null ? endsAt.toLocalDateTime() : null
                );

                appointments.setStatus(
                        resultSet.getString("status")
                );

                long organizationId = resultSet.getLong("organization_id");
                appointments.setOrganizationId(
                        resultSet.wasNull() ? null : organizationId
                );

                long animalId = resultSet.getLong("animal_id");
                appointments.setAnimalId(
                        resultSet.wasNull() ? null : animalId
                );

                long appointmentTypeId = resultSet.getLong("appointment_type_id");
                appointments.setAppointmentTypeId(
                        resultSet.wasNull() ? null : appointmentTypeId
                );

                long veterinarianId = resultSet.getLong("veterinarian_id");
                appointments.setVeterinarianId(
                        resultSet.wasNull() ? null : veterinarianId
                );

                Timestamp serviceDatetime =
                        resultSet.getTimestamp("service_datetime");

                appointments.setServiceDatetime(
                        serviceDatetime != null
                                ? serviceDatetime.toLocalDateTime()
                                : null
                );

                Timestamp checkinAt = resultSet.getTimestamp("checkin_at");
                appointments.setCheckinAt(
                        checkinAt != null ? checkinAt.toLocalDateTime() : null
                );

                Timestamp checkoutAt = resultSet.getTimestamp("checkout_at");
                appointments.setCheckoutAt(
                        checkoutAt != null ? checkoutAt.toLocalDateTime() : null
                );

                appointments.setTriageLevel(
                        resultSet.getString("triage_level")
                );

                appointments.setAppointmentReason(
                        resultSet.getString("appointment_reason")
                );

                appointments.setClientInstructions(
                        resultSet.getString("client_instructions")
                );

                appointments.setServiceOutcome(
                        resultSet.getString("service_outcome")
                );

                Timestamp followupDueAt =
                        resultSet.getTimestamp("followup_due_at");

                appointments.setFollowupDueAt(
                        followupDueAt != null
                                ? followupDueAt.toLocalDateTime()
                                : null
                );

                appointments.setCancellationReason(
                        resultSet.getString("cancellation_reason")
                );

                // Παλαιότερα πεδία της Appointment.java
                appointments.setAppointmentDate(
                        startsAt != null ? startsAt.toLocalDateTime() : null
                );

                appointments.setReason(
                        resultSet.getString("appointment_reason")
                );

                appointment.add(appointments);
            }
        }

        return appointment;
    }
}
