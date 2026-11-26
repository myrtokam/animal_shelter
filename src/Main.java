
import DbEntitiesConnection.*;
import Model.Health.*;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public class Main {

    // ==========================================
    // TEST IDS
    // ==========================================

    private static final long ANIMAL_ID = 1;
    private static final long TREATMENT_PLAN_ID = 1;
    private static final long MEDICATION_ID = 1;
    private static final long ADMINISTRATION_ID = 1;
    private static final long APPOINTMENT_ID = 1;
    private static final long APPOINTMENT_TYPE_ID = 1;
    private static final long VETERINARIAN_ID = 1;
    private static final long ORGANIZATION_ID = 1;


    // ==========================================
    // MAIN
    // ==========================================

    static void main(String[] args) throws SQLException {

        testMedicalRecords();

        testAllergies();

        testAnimals();

        testTreatments();

        testMedications();

        testAppointments();

        testAppointmentTypes();

        System.out.println("\n===== END OF DATABASE READ =====");
    }


    // ==========================================
    // MEDICAL RECORDS
    // ==========================================

    public static void testMedicalRecords() throws SQLException {

        System.out.println("\n===== MEDICAL RECORDS =====");

        MedicalRecordsDAO medicalDao = new MedicalRecordsDAO();

        List<MedicalRecords> records =
                medicalDao.getMedicalRecords();

        for (MedicalRecords record : records) {
            System.out.println(record);
        }

    }
    // ==========================================
    // ALLERGIES
    // ==========================================

    public static void testAllergies() throws SQLException {

        AllergyDAO allergyDao = new AllergyDAO();

        printSection("ALLERGIES");

        List<Allergy> allergies = allergyDao.getAlergies();

        for (Allergy allergy : allergies) {

            System.out.println(
                    allergy.getAllergyId() + " | " +
                            allergy.getName() + " | " +
                            allergy.getStatus()
            );
        }
    }


    // ==========================================
    // ANIMALS
    // ==========================================

    public static void testAnimals() throws SQLException {

        AnimalDAO animalDao = new AnimalDAO();


        // READ ALL ANIMALS

        printSection("ALL ANIMALS");

        List<Animals> animals = animalDao.getAnimals();

        for (Animals animal : animals) {

            System.out.println(
                    animal.getAnimalId() + " | " +
                            animal.getName() + " | " +
                            animal.getMicrochipNumber()
            );
        }


        // COUNT ANIMALS

        printSection("ANIMAL COUNT");

        System.out.println(
                "Total animals: " + animalDao.countAnimals()
        );


        // READ ANIMAL BY ID

        printSection("SEARCH ANIMAL BY ID");

        Animals found = animalDao.getAnimalById(ANIMAL_ID);

        if (found != null) {

            System.out.println(
                    found.getAnimalId() + " | " +
                            found.getName()
            );

        } else {

            System.out.println("Animal not found");
        }
    }


    // ==========================================
    // TREATMENTS
    // ==========================================

    public static void testTreatments() throws SQLException {

        TreatmentDAO treatmentDao = new TreatmentDAO();


        // ALL TREATMENT PLANS

        printSection("TREATMENT PLANS");

        List<Treatment> treatmentPlans =
                treatmentDao.getAllTreatmentPlans();

        for (Treatment treatment : treatmentPlans) {

            System.out.println(
                    treatment.getTreatmentId() + " | " +
                            treatment.getTreatmentName() + " | " +
                            treatment.getDescription() + " | " +
                            treatment.getStatus()
            );
        }


        // TREATMENT PROGRESS

        printSection("TREATMENT PROGRESS");

        List<Treatment> treatmentProgress =
                treatmentDao.getTreatmentProgress(TREATMENT_PLAN_ID);

        for (Treatment treatment : treatmentProgress) {

            System.out.println(
                    treatment.getTreatmentId() + " | " +
                            treatment.getTreatmentName() + " | " +
                            treatment.getDescription() + " | " +
                            treatment.getStatus()
            );
        }


        // PARASITE TREATMENTS

        printSection("PARASITE TREATMENTS");

        List<Treatment> parasiteTreatments =
                treatmentDao.getParasiteTreatmentsByAnimal(ANIMAL_ID);

        for (Treatment treatment : parasiteTreatments) {

            System.out.println(
                    treatment.getTreatmentId() + " | " +
                            treatment.getTreatmentName() + " | " +
                            treatment.getStatus()
            );
        }
    }


    // ==========================================
    // MEDICATIONS
    // ==========================================

    public static void testMedications() throws SQLException {

        MedicationDAO medicationDao = new MedicationDAO();


        // ALL MEDICATIONS

        printSection("ALL MEDICATIONS");

        List<Medication> medications =
                medicationDao.getAllMedications();

        for (Medication medication : medications) {

            System.out.println(
                    medication.getMedicationId() + " | " +
                            medication.getMedicationName() + " | " +
                            medication.getActiveIngredient() + " | " +
                            medication.getStrength()
            );
        }


        // MEDICATION BY ID

        printSection("MEDICATION BY ID");

        Medication foundMedication =
                medicationDao.getMedicationById(MEDICATION_ID);

        if (foundMedication != null) {

            System.out.println(
                    foundMedication.getMedicationId() + " | " +
                            foundMedication.getMedicationName() + " | " +
                            foundMedication.getActiveIngredient()
            );

        } else {

            System.out.println("Medication not found");
        }


        // MEDICATION SCHEDULES

        printSection("MEDICATION SCHEDULES");

        List<Medication> schedules =
                medicationDao.getMedicationSchedulesByAnimal(ANIMAL_ID);

        for (Medication schedule : schedules) {

            System.out.println(
                    schedule.getMedicationScheduleId() + " | " +
                            schedule.getScheduledAt() + " | " +
                            schedule.getScheduledDoseAmount() + " | " +
                            schedule.getDoseUnit()
            );
        }


        // MEDICATION ADMINISTRATIONS

        printSection("MEDICATION ADMINISTRATIONS");

        List<Medication> administrations =
                medicationDao.getAdministrationsByAnimal(ANIMAL_ID);

        for (Medication administration : administrations) {

            System.out.println(
                    administration.getMedicationAdministrationId() + " | " +
                            administration.getAdministeredAt() + " | " +
                            administration.getAdministeredDoseAmount() + " | " +
                            administration.getAdministrationOutcome()
            );
        }


        // ADMINISTRATION DETAILS

        printSection("ADMINISTRATION DETAILS");

        List<Medication> administrationDetails =
                medicationDao.getAdministrationDetails(ADMINISTRATION_ID);

        for (Medication detail : administrationDetails) {

            System.out.println(
                    detail.getAdministrationDetailId() + " | " +
                            detail.getActualDose() + " | " +
                            detail.getAdministeredByName() + " | " +
                            detail.getAdverseEventNotes()
            );
        }
    }


    // ==========================================
    // APPOINTMENTS
    // ==========================================

    public static void testAppointments() throws SQLException {

        AppointmentDAO appointmentDao = new AppointmentDAO();

        appointmentDao.testConnection();


        // ALL APPOINTMENTS

        printSection("ALL APPOINTMENTS");

        printResults(
                appointmentDao.appointments()
        );


        // APPOINTMENT BY ID

        printSection("APPOINTMENT BY ID");

        Appointment foundAppointment =
                appointmentDao.getAppointmentById(APPOINTMENT_ID);

        if (foundAppointment != null) {

            System.out.println(foundAppointment);

        } else {

            System.out.println("Appointment not found");
        }


        // APPOINTMENTS BY ANIMAL

        printSection("APPOINTMENTS BY ANIMAL");

        printResults(
                appointmentDao.getAppointmentsByAnimal(ANIMAL_ID)
        );


        // APPOINTMENTS BY VETERINARIAN

        printSection("APPOINTMENTS BY VETERINARIAN");

        printResults(
                appointmentDao.getAppointmentsByVeterinarian(
                        VETERINARIAN_ID
                )
        );


        // APPOINTMENTS BY ORGANIZATION

        printSection("APPOINTMENTS BY ORGANIZATION");

        printResults(
                appointmentDao.getAppointmentsByOrganization(
                        ORGANIZATION_ID
                )
        );


        // APPOINTMENTS BY TYPE ID

        printSection("APPOINTMENTS BY TYPE ID");

        printResults(
                appointmentDao.getAppointmentsByType(
                        APPOINTMENT_TYPE_ID
                )
        );


        // APPOINTMENTS BY TYPE NAME

        printSection("APPOINTMENTS BY TYPE NAME");

        printResults(
                appointmentDao.getAppointmentsByTypeName(
                        "General Consultation"
                )
        );


        // APPOINTMENTS BY STATUS

        printSection("PENDING APPOINTMENTS");

        printResults(
                appointmentDao.getAppointmentsByStatus("PENDING")
        );


        // APPOINTMENTS BY BOOKING TYPE

        printSection("APPOINTMENTS BY BOOKING TYPE");

        printResults(
                appointmentDao.getAppointmentsByBookingType(
                        "SCHEDULED"
                )
        );


        // APPOINTMENTS BY TRIAGE LEVEL

        printSection("APPOINTMENTS BY TRIAGE LEVEL");

        printResults(
                appointmentDao.getAppointmentsByTriageLevel(
                        "URGENT"
                )
        );


        // GENERAL CONSULTATIONS

        printSection("GENERAL CONSULTATIONS");

        printResults(
                appointmentDao.getGeneralConsultations()
        );


        // SCHEDULED APPOINTMENTS

        printSection("SCHEDULED APPOINTMENTS");

        printResults(
                appointmentDao.getScheduledAppointments()
        );


        // WALK-IN APPOINTMENTS

        printSection("WALK-IN APPOINTMENTS");

        printResults(
                appointmentDao.getWalkInAppointments()
        );


        // UNSCHEDULED APPOINTMENTS

        printSection("UNSCHEDULED APPOINTMENTS");

        printResults(
                appointmentDao.getUnscheduledAppointments()
        );


        // URGENT APPOINTMENTS

        printSection("URGENT APPOINTMENTS");

        printResults(
                appointmentDao.getUrgentAppointments()
        );


        // EMERGENCY APPOINTMENTS

        printSection("EMERGENCY APPOINTMENTS");

        printResults(
                appointmentDao.getEmergencyAppointments()
        );


        // CRITICAL APPOINTMENTS

        printSection("CRITICAL APPOINTMENTS");

        printResults(
                appointmentDao.getCriticalAppointments()
        );


        // ALL SURGERIES

        printSection("ALL SURGERIES");

        printResults(
                appointmentDao.getSurgeries()
        );


        // SCHEDULED SURGERIES

        printSection("SCHEDULED SURGERIES");

        printResults(
                appointmentDao.getScheduledSurgeries()
        );


        // EMERGENCY SURGERIES

        printSection("EMERGENCY SURGERIES");

        printResults(
                appointmentDao.getEmergencySurgeries()
        );


        // HOSPITALIZATIONS

        printSection("HOSPITALIZATIONS");

        printResults(
                appointmentDao.getHospitalizations()
        );


        // FOLLOW-UP APPOINTMENTS

        printSection("FOLLOW-UP APPOINTMENTS");

        printResults(
                appointmentDao.getFollowUpAppointments()
        );


        // VACCINATIONS

        printSection("VACCINATIONS");

        printResults(
                appointmentDao.getVaccinationAppointments()
        );


        // STERILIZATIONS

        printSection("STERILIZATIONS");

        printResults(
                appointmentDao.getSterilizationAppointments()
        );


        // DIAGNOSTIC EXAMINATIONS

        printSection("DIAGNOSTIC EXAMINATIONS");

        printResults(
                appointmentDao.getDiagnosticExaminations()
        );


        // APPOINTMENTS BY DATE RANGE

        printSection("TODAY'S APPOINTMENTS");

        LocalDate today = LocalDate.now();

        printResults(
                appointmentDao.getAppointmentsByDateRange(
                        today.atStartOfDay(),
                        today.plusDays(1).atStartOfDay()
                )
        );


        // COMPLETED APPOINTMENTS

        printSection("COMPLETED APPOINTMENTS");

        printResults(
                appointmentDao.getCompletedAppointments()
        );


        // CANCELLED APPOINTMENTS

        printSection("CANCELLED APPOINTMENTS");

        printResults(
                appointmentDao.getCancelledAppointments()
        );


        // UNCLASSIFIED APPOINTMENTS

        printSection("UNCLASSIFIED APPOINTMENTS");

        printResults(
                appointmentDao.getUnclassifiedAppointments()
        );


        // COUNT APPOINTMENTS

        printSection("APPOINTMENT COUNT");

        System.out.println(
                "Total appointments: " +
                        appointmentDao.countAppointments()
        );


        // COUNT APPOINTMENTS BY ANIMAL

        printSection("ANIMAL APPOINTMENT COUNT");

        System.out.println(
                "Appointments for animal " + ANIMAL_ID + ": " +
                        appointmentDao.countAppointmentsByAnimal(ANIMAL_ID)
        );
    }


    // ==========================================
    // APPOINTMENT TYPES
    // ==========================================

    public static void testAppointmentTypes() throws SQLException {

        AppointmentDAO appointmentDao = new AppointmentDAO();


        // ALL APPOINTMENT TYPES

        printSection("ALL APPOINTMENT TYPES");

        List<Appoitment_types> types =
                appointmentDao.getAppointmentTypes();

        printResults(types);


        // ACTIVE APPOINTMENT TYPES

        printSection("ACTIVE APPOINTMENT TYPES");

        printResults(
                appointmentDao.getActiveAppointmentTypes()
        );


        // APPOINTMENT TYPE BY ID

        printSection("APPOINTMENT TYPE BY ID");

        Appoitment_types foundType =
                appointmentDao.getAppointmentTypeById(
                        APPOINTMENT_TYPE_ID
                );

        if (foundType != null) {

            System.out.println(foundType);

        } else {

            System.out.println("Appointment type not found");
        }


        // COUNT APPOINTMENT TYPES

        printSection("APPOINTMENT TYPE COUNT");

        System.out.println(
                "Total appointment types: " +
                        appointmentDao.countAppointmentTypes()
        );
    }


    // ==========================================
    // HELPER METHODS
    // ==========================================

    private static void printSection(String title) {

        System.out.println("\n==========================================");

        System.out.println(title);

        System.out.println("==========================================");
    }


    private static void printResults(List<?> results) {

        if (results.isEmpty()) {

            System.out.println("No records found");

            return;
        }

        for (Object result : results) {

            System.out.println(result);
        }

        System.out.println(
                "\nRecords retrieved: " + results.size()
        );
    }
}
