import DbEntitiesConnection.AllergyDAO;
import DbEntitiesConnection.MedicalRecordsDAO;
import Model.Allergy;
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
    }
}

