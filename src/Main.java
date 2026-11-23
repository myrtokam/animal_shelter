import DbEntitiesConnection.*;
import Model.Health.*;

import java.sql.SQLException;
import java.util.List;

public class Main {

    static void main(String[] args) throws SQLException {

        // IDs used for testing
        // Replace these with IDs that exist in your database.
        long animalId = 1;
        long treatmentPlanId = 1;
        long medicationId = 1;
        long administrationId = 1;


        // ==========================================
        // MEDICAL RECORDS


        System.out.println("\n===== MEDICAL RECORDS =====");

        MedicalRecordsDAO medicalDao = new MedicalRecordsDAO();

        List<MedicalRecords> records =
                medicalDao.getMedicalRecords();

        for (MedicalRecords record : records) {
            System.out.println(record);
        }


        // ==========================================
        // ALLERGIES


        System.out.println("\n===== ALLERGIES =====");

        AllergyDAO allergyDao = new AllergyDAO();

        List<Allergy> allergies = allergyDao.getAlergies();

        for (Allergy allergy : allergies) {

            System.out.println(
                    allergy.getAllergyId() + " | " +
                            allergy.getName() + " | " +
                            allergy.getStatus()
            );
        }


        // ==========================================
        // ANIMALS


        AnimalDAO animalDao = new AnimalDAO();


        // READ ALL

        System.out.println("\n===== ALL ANIMALS =====");

        List<Animals> animals = animalDao.getAnimals();

        for (Animals animal : animals) {

            System.out.println(
                    animal.getAnimalId() + " | " +
                            animal.getName() + " | " +
                            animal.getMicrochipNumber()
            );
        }


        // COUNT

        System.out.println("\n===== ANIMAL COUNT =====");

        System.out.println(
                "Total animals: " + animalDao.countAnimals()
        );


        // READ BY ID

        System.out.println("\n===== SEARCH ANIMAL BY ID =====");

        Animals found = animalDao.getAnimalById(animalId);

        if (found != null) {

            System.out.println(
                    "Found: " + found.getAnimalId() +
                            " | " + found.getName()
            );

        } else {
            System.out.println("Animal not found");
        }


        // ==========================================
        // TREATMENTS


        TreatmentDAO treatmentDao = new TreatmentDAO();


        // READ ALL TREATMENT PLANS

        System.out.println("\n===== TREATMENT PLANS =====");

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


        // READ TREATMENT PROGRESS

        System.out.println("\n===== TREATMENT PROGRESS =====");

        List<Treatment> treatmentProgress =
                treatmentDao.getTreatmentProgress(treatmentPlanId);

        for (Treatment treatment : treatmentProgress) {

            System.out.println(
                    treatment.getTreatmentId() + " | " +
                            treatment.getTreatmentName() + " | " +
                            treatment.getDescription() + " | " +
                            treatment.getStatus()
            );
        }


        // READ PARASITE TREATMENTS BY ANIMAL

        System.out.println("\n===== PARASITE TREATMENTS =====");

        List<Treatment> parasiteTreatments =
                treatmentDao.getParasiteTreatmentsByAnimal(animalId);

        for (Treatment treatment : parasiteTreatments) {

            System.out.println(
                    treatment.getTreatmentId() + " | " +
                            treatment.getTreatmentName() + " | " +
                            treatment.getStatus()
            );
        }


        // ==========================================
        // MEDICATIONS


        MedicationDAO medicationDao = new MedicationDAO();


        // READ ALL MEDICATIONS

        System.out.println("\n===== ALL MEDICATIONS =====");

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


        // READ MEDICATION BY ID

        System.out.println("\n===== MEDICATION BY ID =====");

        Medication foundMedication =
                medicationDao.getMedicationById(medicationId);

        if (foundMedication != null) {

            System.out.println(
                    foundMedication.getMedicationId() + " | " +
                            foundMedication.getMedicationName() + " | " +
                            foundMedication.getActiveIngredient()
            );

        } else {
            System.out.println("Medication not found");
        }


        // READ MEDICATION SCHEDULES BY ANIMAL

        System.out.println("\n===== MEDICATION SCHEDULES =====");

        List<Medication> schedules =
                medicationDao.getMedicationSchedulesByAnimal(animalId);

        for (Medication schedule : schedules) {

            System.out.println(
                    schedule.getMedicationScheduleId() + " | " +
                            schedule.getScheduledAt() + " | " +
                            schedule.getScheduledDoseAmount() + " | " +
                            schedule.getDoseUnit()
            );
        }


        // READ MEDICATION ADMINISTRATIONS BY ANIMAL

        System.out.println("\n===== MEDICATION ADMINISTRATIONS =====");

        List<Medication> administrations =
                medicationDao.getAdministrationsByAnimal(animalId);

        for (Medication administration : administrations) {

            System.out.println(
                    administration.getMedicationAdministrationId() + " | " +
                            administration.getAdministeredAt() + " | " +
                            administration.getAdministeredDoseAmount() + " | " +
                            administration.getAdministrationOutcome()
            );
        }


        // READ ADMINISTRATION DETAILS

        System.out.println("\n===== ADMINISTRATION DETAILS =====");

        List<Medication> administrationDetails =
                medicationDao.getAdministrationDetails(administrationId);

        for (Medication detail : administrationDetails) {

            System.out.println(
                    detail.getAdministrationDetailId() + " | " +
                            detail.getActualDose() + " | " +
                            detail.getAdministeredByName() + " | " +
                            detail.getAdverseEventNotes()
            );
        }


        System.out.println("\n===== END OF DATABASE READ =====");
    }
}
