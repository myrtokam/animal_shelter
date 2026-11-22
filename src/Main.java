import DbEntitiesConnection.AllergyDAO;
import DbEntitiesConnection.AnimalDAO;
import DbEntitiesConnection.MedicalRecordsDAO;
import Model.Allergy;
import Model.Animals;
import Model.MedicalRecords;

import java.sql.SQLException;
import java.util.List;
public class Main {

    static void main(String[] args) throws SQLException {

        // Medical Records
        MedicalRecordsDAO medicalDao = new MedicalRecordsDAO();
        List<MedicalRecords> records = medicalDao.getMedicalRecords();

        for (MedicalRecords record : records) {
            System.out.println(record);
        }

        // Allergies
        AllergyDAO allergyDao = new AllergyDAO();
        List<Allergy> allergies = allergyDao.getAlergies();

        for (Allergy allergy : allergies) {

            System.out.println(
                    allergy.getAllergyId() + " | " +
                            allergy.getName() + " | " +
                            allergy.getStatus()
            );
        }
        AnimalDAO animalDao = new AnimalDAO();

        List<Animals> animals = animalDao.getAnimals();

        for (Animals animal : animals) {

            System.out.println(
                    animal.getAnimalId() + " | " +
                            animal.getName() + " | " +
                            animal.getMicrochipNumber()
            );
        }
    }
}

