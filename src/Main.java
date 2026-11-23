import DbEntitiesConnection.AllergyDAO;
import DbEntitiesConnection.AnimalDAO;
import DbEntitiesConnection.MedicalRecordsDAO;
import Model.Health.Allergy;
import Model.Health.Animals;
import Model.Health.MedicalRecords;

import java.sql.SQLException;
import java.util.List;

public class Main {

    static void main(String[] args) throws SQLException {

        // MEDICAL RECORDS
        System.out.println("===== MEDICAL RECORDS =====");

        MedicalRecordsDAO medicalDao = new MedicalRecordsDAO();
        List<MedicalRecords> records = medicalDao.getMedicalRecords();

        for (MedicalRecords record : records) {
            System.out.println(record);
        }

        // ALLERGIES
        System.out.println("===== ALLERGIES =====");

        AllergyDAO allergyDao = new AllergyDAO();
        List<Allergy> allergies = allergyDao.getAlergies();

        for (Allergy allergy : allergies) {
            System.out.println(
                    allergy.getAllergyId() + " | " +
                            allergy.getName() + " | " +
                            allergy.getStatus()
            );
        }

        // ANIMALS
        AnimalDAO animalDao = new AnimalDAO();

        // READ ALL
        System.out.println("===== ALL ANIMALS =====");

        List<Animals> animals = animalDao.getAnimals();

        for (Animals animal : animals) {
            System.out.println(
                    animal.getAnimalId() + " | " +
                            animal.getName() + " | " +
                            animal.getMicrochipNumber()
            );
        }

        // COUNT
        System.out.println("===== ANIMAL COUNT =====");

        System.out.println(
                "Total animals: " + animalDao.countAnimals()
        );

        // READ BY ID
        System.out.println("===== SEARCH ANIMAL BY ID =====");

        Animals found = animalDao.getAnimalById(1);

        if (found != null) {
            System.out.println(
                    "Found: " + found.getAnimalId() +
                            " | " + found.getName()
            );
        } else {
            System.out.println("Animal not found");
        }
    }
}
