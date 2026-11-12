import DbEntitiesConnection.MedicalRecordsDAO;
import Model.MedicalRecords;

import java.sql.SQLException;
import java.util.List;

public class Main {

    static void main(String[] args) throws SQLException {

        MedicalRecordsDAO dao = new MedicalRecordsDAO();

        List<MedicalRecords> records = dao.getMedicalRecords();

        for (MedicalRecords record : records) {
            System.out.println(record);
        }
    }
}

