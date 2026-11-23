package Model.Health;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Appointment {

    private long appointmentId;
    private LocalDateTime startsAt;
    private LocalDateTime endsAt;
    private String status;
    private Long organizationId;
    private Long animalId;
    private Long appointmentTypeId;
    private Long veterinarianId;
    private LocalDateTime serviceDatetime;
    private LocalDateTime checkinAt;
    private LocalDateTime checkoutAt;
    private String triageLevel;
    private String appointmentReason;
    private String clientInstructions;
    private String serviceOutcome;
    private LocalDateTime followupDueAt;
    private String cancellationReason;
    private LocalDateTime appointmentDate;
    private String reason;
    private String notes;

    public Appointment() {
    }

    public Appointment(long appointmentId, LocalDateTime startsAt, LocalDateTime endsAt, String status, Long organizationId, Long animalId, Long appointmentTypeId, Long veterinarianId, LocalDateTime serviceDatetime, LocalDateTime checkinAt, LocalDateTime checkoutAt, String triageLevel, String appointmentReason, String clientInstructions, String serviceOutcome, LocalDateTime followupDueAt, String cancellationReason, LocalDateTime appointmentDate, String reason, String notes) {
        this.appointmentId = appointmentId;
        this.startsAt = startsAt;
        this.endsAt = endsAt;
        this.status = status;
        this.organizationId = organizationId;
        this.animalId = animalId;
        this.appointmentTypeId = appointmentTypeId;
        this.veterinarianId = veterinarianId;
        this.serviceDatetime = serviceDatetime;
        this.checkinAt = checkinAt;
        this.checkoutAt = checkoutAt;
        this.triageLevel = triageLevel;
        this.appointmentReason = appointmentReason;
        this.clientInstructions = clientInstructions;
        this.serviceOutcome = serviceOutcome;
        this.followupDueAt = followupDueAt;
        this.cancellationReason = cancellationReason;
        this.appointmentDate = appointmentDate;
        this.reason = reason;
        this.notes = notes;
    }

    public LocalDateTime getStartsAt() {
        return startsAt;
    }

    public void setStartsAt(LocalDateTime startsAt) {
        this.startsAt = startsAt;
    }

    public LocalDateTime getEndsAt() {
        return endsAt;
    }

    public void setEndsAt(LocalDateTime endsAt) {
        this.endsAt = endsAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Long getOrganizationId() {
        return organizationId;
    }

    public void setOrganizationId(Long organizationId) {
        this.organizationId = organizationId;
    }

    public Long getAnimalId() {
        return animalId;
    }

    public void setAnimalId(Long animalId) {
        this.animalId = animalId;
    }

    public Long getAppointmentTypeId() {
        return appointmentTypeId;
    }

    public void setAppointmentTypeId(Long appointmentTypeId) {
        this.appointmentTypeId = appointmentTypeId;
    }

    public Long getVeterinarianId() {
        return veterinarianId;
    }

    public void setVeterinarianId(Long veterinarianId) {
        this.veterinarianId = veterinarianId;
    }

    public LocalDateTime getServiceDatetime() {
        return serviceDatetime;
    }

    public void setServiceDatetime(LocalDateTime serviceDatetime) {
        this.serviceDatetime = serviceDatetime;
    }

    public LocalDateTime getCheckinAt() {
        return checkinAt;
    }

    public void setCheckinAt(LocalDateTime checkinAt) {
        this.checkinAt = checkinAt;
    }

    public LocalDateTime getCheckoutAt() {
        return checkoutAt;
    }

    public void setCheckoutAt(LocalDateTime checkoutAt) {
        this.checkoutAt = checkoutAt;
    }

    public String getTriageLevel() {
        return triageLevel;
    }

    public void setTriageLevel(String triageLevel) {
        this.triageLevel = triageLevel;
    }

    public String getAppointmentReason() {
        return appointmentReason;
    }

    public void setAppointmentReason(String appointmentReason) {
        this.appointmentReason = appointmentReason;
    }

    public String getClientInstructions() {
        return clientInstructions;
    }

    public void setClientInstructions(String clientInstructions) {
        this.clientInstructions = clientInstructions;
    }

    public String getServiceOutcome() {
        return serviceOutcome;
    }

    public void setServiceOutcome(String serviceOutcome) {
        this.serviceOutcome = serviceOutcome;
    }

    public LocalDateTime getFollowupDueAt() {
        return followupDueAt;
    }

    public void setFollowupDueAt(LocalDateTime followupDueAt) {
        this.followupDueAt = followupDueAt;
    }

    public String getCancellationReason() {
        return cancellationReason;
    }

    public void setCancellationReason(String cancellationReason) {
        this.cancellationReason = cancellationReason;
    }

    public LocalDateTime getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(LocalDateTime appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public long getAppointmentId() {
        return appointmentId;
    }

    public static boolean createAppointment(Appointment[] appointments, Appointment newAppointment) {

        if (appointments == null || newAppointment == null) {
            return false;
        }

        for (int i = 0; i < appointments.length; i++) {

            if (appointments[i] == null) {
                appointments[i] = newAppointment;
                return true;
            }
        }

        return false;
    }
    public static Appointment findAppointmentById(Appointment[] appointments, int appointmentId) {

        if (appointments == null) {
            return null;
        }

        for (int i = 0; i < appointments.length; i++) {

            if (appointments[i] != null &&
                    appointments[i].getAppointmentId() == appointmentId) {

                return appointments[i];
            }
        }

        return null;
    }
    public static Appointment updateAppointment(Appointment[] appointments, Appointment newAppointment, Animals animal) {

        if (appointments == null || newAppointment == null) {
            return null;
        }

        for (int i = 0; i < appointments.length; i++) {

            if (appointments[i] != null &&
                    appointments[i].getAppointmentId() ==
                            newAppointment.getAppointmentId()) {

                if (newAppointment.getStatus() != null) {
                    appointments[i].setStatus(newAppointment.getStatus());
                }

                if (newAppointment.getAppointmentDate() != null) {
                    appointments[i].setAppointmentDate(
                            newAppointment.getAppointmentDate());
                }

                if (newAppointment.getReason() != null) {
                    appointments[i].setReason(newAppointment.getReason());
                }

                if (newAppointment.getNotes() != null) {
                    appointments[i].setNotes(newAppointment.getNotes());
                }

                return appointments[i];
            }
        }

        return null;
    }
    public static boolean deleteAppointment(Appointment[] appointments, int appointmentId) {

        if (appointments == null) {
            return false;
        }

        for (int i = 0; i < appointments.length; i++) {

            if (appointments[i] != null &&
                    appointments[i].getAppointmentId() == appointmentId) {

                appointments[i] = null;
                return true;
            }
        }

        return false;
    }
    public static List<Appointment> getAppointmentsByAnimal(Appointment[] appointments, Appointment newAppointment, Animals animal) {

        List<Appointment> results = new ArrayList<>();

        if (appointments == null || animal == null) {
            return results;
        }

        for (int i = 0; i < appointments.length; i++) {

            if (appointments[i] != null &&
                    appointments[i].getAnimalId() == animal.getAnimalId()) {

                results.add(appointments[i]);
            }
        }

        return results;
    }
    public static boolean cancelAppointment(Appointment[] appointments, Appointment newAppointment, Animals animal) {

        if (appointments == null || newAppointment == null) {
            return false;
        }

        for (int i = 0; i < appointments.length; i++) {

            if (appointments[i] != null &&
                    appointments[i].getAppointmentId() ==
                            newAppointment.getAppointmentId()) {

                if ("Scheduled".equals(appointments[i].getStatus())) {
                    appointments[i].setStatus("Cancelled");
                    return true;
                }

                return false;
            }
        }

        return false;
    }

    public static int countAppointments(Appointment[] appointments, Appointment newAppointment, Animals animal) {

        if (appointments == null) {
            return 0;
        }

        int counter = 0;

        for (int i = 0; i < appointments.length; i++) {

            if (appointments[i] != null) {
                counter++;
            }
        }

        return counter;
    }

    public void setAppointmentId(long appointmentId) {
        this.appointmentId = appointmentId;
    }

}
