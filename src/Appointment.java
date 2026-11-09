import java.time.LocalDateTime;
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

    public Appointment(int appointmentId, int animalId, int veterinarianId, LocalDateTime appointmentDate, String reason, String status, String notes) {
        this.appointmentId = appointmentId;
        this.animalId = animalId;
        this.veterinarianId = veterinarianId;
        this.appointmentDate = appointmentDate;
        this.reason = reason;
        this.status = status;
        this.notes = notes;
    }

    public static boolean createAppointment(Appointment[] appointments, Appointment newAppointment, Animals animal) {
        // Δημιουργία ραντεβού.
        if (appointments != null) {
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

    public static boolean findAppointmentById(Appointment[] appointments, Appointment newAppointment, Animals animal) {
        //Αναζήτηση με ID.
        for (int i = 0; i < appointments.length; i++) {
            if (appointments[i] != null && appointments[i].getAppointmentId() == newAppointment.getAppointmentId()) {
                return true;
            }
        }
        return false;
    }

    public static List<Appointment> getAppointmentsByAnimal(Appointment[] appointments, Appointment newAppointment, Animals animal) {
        // Όλα τα ραντεβού ενός ζώου.
        List<Appointment> animalAppointments = new java.util.ArrayList<>();
        if (appointments == null || newAppointment == null) {
            return animalAppointments;
        }
        for (int i = 0; i < appointments.length; i++) {
            if (appointments[i] != null && appointments[i].getAnimalId() == newAppointment.getAnimalId()) {
                animalAppointments.add(appointments[i]);
            }
        }
        return animalAppointments;
    }

    public static Appointment updateAppointment(Appointment[] appointments, Appointment newAppointment, Animals animal) {
        if (appointments == null || newAppointment == null) {
            return null;
        }
        // Ενημέρωση ραντεβού. Αλλαγή στοιχείων ραντεβού.
        for (int i = 0; i < appointments.length; i++) {

            if (appointments[i] != null && appointments[i].getAppointmentId() == newAppointment.getAppointmentId()) {
                if (newAppointment.getStatus() != null) {
                    appointments[i].setStatus(newAppointment.getStatus());
                }
                if (newAppointment.getAppointmentDate() != null) {
                    appointments[i].setAppointmentDate(newAppointment.getAppointmentDate());
                }
                if (newAppointment.getReason() != null) {
                    appointments[i].setReason(newAppointment.getReason());
                }
                if (newAppointment.getNotes() != null) {
                    appointments[i].setNotes(newAppointment.getNotes());

                }

                return appointments[i]; // Μέσα στο if
            }
        }

        return null;
    }

    public static boolean cancelAppointment(Appointment[] appointments, Appointment newAppointment, Animals animal) {
        //— Ακύρωση ραντεβού.
        return false;
    }

    public static boolean countAppointments(Appointment[] appointments, Appointment newAppointment, Animals animal) {
        //— Καταμέτρηση ραντεβού.
        return false;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public int getAnimalId() {
        return animalId;
    }

    public void setAnimalId(int animalId) {
        this.animalId = animalId;
    }

    public int getVeterinarianId() {
        return veterinarianId;
    }

    public void setVeterinarianId(int veterinarianId) {
        this.veterinarianId = veterinarianId;
    }

    public LocalDateTime getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(LocalDateTime appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    //Methods

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
