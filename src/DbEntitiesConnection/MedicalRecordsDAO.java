
package DbEntitiesConnection;

import Model.MedicalRecords;
import Util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MedicalRecordsDAO {
    /*
     Ελέγχει αν η εφαρμογή μπορεί να συνδεθεί στη MySQL.
     Η DatabaseConnection.getConnection() δημιουργεί τη σύνδεση.
     Το try-with-resources την κλείνει αυτόματα όταν τελειώσει
     η εκτέλεση, ακόμη και αν προκύψει σφάλμα.
     Η μέθοδος ελέγχει μόνο τη σύνδεση.
     Δεν διαβάζει ούτε τροποποιεί δεδομένα.
     */
    public void testConnection() throws SQLException {

        try (Connection connection = DatabaseConnection.getConnection()) {
            System.out.println("Connection successful");
        }
    }

    /*
     Διαβάζει έως 5 ιατρικούς φακέλους από τη MySQL.

     Για κάθε γραμμή που επιστρέφει το SELECT:
     1. Δημιουργεί ένα αντικείμενο MedicalRecords.
     2. Συμπληρώνει τα πεδία του με τις τιμές της βάσης.
     3. Προσθέτει το αντικείμενο σε μια λίστα.
     Στο τέλος επιστρέφει τη λίστα στην κλάση
     που κάλεσε τη μέθοδο, για παράδειγμα στη Main.
     */
    public List<MedicalRecords> getMedicalRecords() throws SQLException {

        // Το SQL query που θα εκτελεστεί στη βάση.
        String sql_medical_records = """
                SELECT medical_records_id, name, status, animal_id
                FROM medical_records
                LIMIT 500
                """;

        // Δημιουργούμε μια άδεια λίστα για τα αποτελέσματα.
        List<MedicalRecords> records = new ArrayList<>();

        /*
         Connection: ανοίγει τη σύνδεση με τη MySQL.
         PreparedStatement: προετοιμάζει την SQL εντολή.
         executeQuery(): εκτελεί το SELECT.
         ResultSet: μας επιτρέπει να διαβάσουμε τις γραμμές
         που επέστρεψε η βάση.
         Το try-with-resources κλείνει αυτόματα και τα τρία
         JDBC resources όταν ολοκληρωθεί η διαδικασία.
         */
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql_medical_records);
             ResultSet resultSet = statement.executeQuery()) {

            // Διαβάζουμε μία-μία τις γραμμές του αποτελέσματος.
            while (resultSet.next()) {

                // Κάθε γραμμή γίνεται ένα νέο Java object.
                MedicalRecords record = new MedicalRecords();
                // Διαβάζουμε το ID του ιατρικού φακέλου.
                record.setMedicalRecordsId(
                        resultSet.getLong("medical_records_id")
                );
                // Διαβάζουμε το όνομα του ιατρικού φακέλου.
                record.setName(resultSet.getString("name"));

                // Διαβάζουμε την κατάσταση του φακέλου.
                record.setStatus(resultSet.getString("status"));
                /*
                 Διαβάζουμε το ID του ζώου.
                 Χρησιμοποιούμε Long αντί για long επειδή
                 η στήλη animal_id μπορεί να έχει τιμή NULL.
                 */
                record.setAnimalId(resultSet.getObject("animal_id", Long.class));

                // Προσθέτουμε το αντικείμενο στη λίστα.
                records.add(record);
            }
        }
        // Επιστρέφουμε τη λίστα με τους ιατρικούς φακέλους.
        return records;
    }

    /**
     * Αναζητά όλους τους ιατρικούς φακέλους ενός ζώου.
     *
     * @param animalId Το ID του ζώου.
     * @return Λίστα με τους ιατρικούς φακέλους του ζώου.
     * @throws SQLException Αν προκύψει σφάλμα στη βάση.
     */
    public List<MedicalRecords> getMedicalRecordsByAnimalId(long animalId)
            throws SQLException {

        // SQL query με παράμετρο για το ID του ζώου.
        String sql = """
                SELECT medical_records_id, name, status, animal_id
                FROM medical_records
                WHERE animal_id = ?
                ORDER BY medical_records_id
                """;

        // Λίστα στην οποία θα αποθηκεύσουμε τα αποτελέσματα.
        List<MedicalRecords> records = new ArrayList<>();

        // Σύνδεση με τη MySQL και δημιουργία PreparedStatement.
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Δίνουμε τιμή στην πρώτη παράμετρο (?).
            statement.setLong(1, animalId);

            // Εκτελούμε το SELECT.
            try (ResultSet resultSet = statement.executeQuery()) {

                // Διαβάζουμε κάθε γραμμή του αποτελέσματος.
                while (resultSet.next()) {

                    // Δημιουργούμε νέο αντικείμενο MedicalRecords.
                    MedicalRecords record = new MedicalRecords();

                    // Μεταφέρουμε τις τιμές της MySQL στο αντικείμενο.
                    record.setMedicalRecordsId(
                            resultSet.getLong("medical_records_id")
                    );

                    record.setName(
                            resultSet.getString("name")
                    );

                    record.setStatus(
                            resultSet.getString("status")
                    );

                    record.setAnimalId(
                            resultSet.getObject("animal_id", Long.class)
                    );

                    // Προσθέτουμε το αντικείμενο στη λίστα.
                    records.add(record);
                }
            }
        }

        // Επιστρέφουμε τη λίστα με τους φακέλους του ζώου.
        return records;
    }
}