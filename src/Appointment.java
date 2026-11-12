
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Appointment {

    private int appointmentId;
    private int animalId;
    private int veterinarianId;
    private LocalDateTime appointmentDate;
    private String reason;
    private String status;
    private String notes;


    public Appointment() {
    }
    public Appointment( int appointmentId,  int animalId,  int veterinarianId,  LocalDateTime appointmentDate,  String reason,  String status,  String notes) {

        this.appointmentId = appointmentId;
        this.animalId = animalId;
        this.veterinarianId = veterinarianId;
        this.appointmentDate = appointmentDate;
        this.reason = reason;
        this.status = status;
        this.notes = notes;
    }
    public int getAppointmentId() {
        return appointmentId;
    }
    public int getAnimalId() {
        return animalId;
    }
    public int getVeterinarianId() {
        return veterinarianId;
    }
    public LocalDateTime getAppointmentDate() {
        return appointmentDate;
    }
    public String getReason() {
        return reason;
    }
    public String getStatus() {
        return status;
    }
    public String getNotes() {
        return notes;
    }
    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }
    public void setAnimalId(int animalId) {
        this.animalId = animalId;
    }
    public void setVeterinarianId(int veterinarianId) {
        this.veterinarianId = veterinarianId;
    }
    public void setAppointmentDate(LocalDateTime appointmentDate) {
        this.appointmentDate = appointmentDate;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public void setNotes(String notes) {
        this.notes = notes;
    }


    public static boolean createAppointment( Appointment[] appointments,  Appointment newAppointment) {

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
    public static Appointment findAppointmentById( Appointment[] appointments, int appointmentId) {

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
    public static Appointment updateAppointment( Appointment[] appointments,  Appointment newAppointment,  Animals animal) {

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
}

