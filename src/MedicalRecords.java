import java.util.Date;

public class MedicalRecords {
    private String medicalrecord;
    private Date medicalExamingdDate;
    private String DoctorsName;
    private String Diagnosis;
    private String MedicalTreatment;
    private String MedicalPrescriptions;
    private String MedicalNotes;
     MedicalRecords [] medicalRecords = new  MedicalRecords[1000000];
    public static void create_medical_record() {
    }

    public String getMedicalrecord() {
        return this.medicalrecord;
    }

    public void setMedicalrecord(String medicalrecord) {
        this.medicalrecord = medicalrecord;
    }

    public Date getMedicalExamingdDate() {
        return this.medicalExamingdDate;
    }

    public void setMedicalExamingdDate(Date medicalExamingdDate) {
        this.medicalExamingdDate = medicalExamingdDate;
    }

    public String getDoctorsName() {
        return this.DoctorsName;
    }

    public void setDoctorsName(String doctorsName) {
        this.DoctorsName = doctorsName;
    }

    public String getDiagnosis() {
        return this.Diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.Diagnosis = diagnosis;
    }

    public String getMedicalTreatment() {
        return this.MedicalTreatment;
    }

    public void setMedicalTreatment(String medicalTreatment) {
        this.MedicalTreatment = medicalTreatment;
    }

    public String getMedicalPrescriptions() {
        return this.MedicalPrescriptions;
    }

    public void setMedicalPrescriptions(String medicalPrescriptions) {
        this.MedicalPrescriptions = medicalPrescriptions;
    }

    public String getMedicalNotes() {
        return this.MedicalNotes;
    }

    public void setMedicalNotes(String medicalNotes) {
        this.MedicalNotes = medicalNotes;
    }

    public MedicalRecords() {
    }

    public MedicalRecords(String medicalrecord, Date medicalExamingdDate, String doctorsName, String diagnosis, String medicalTreatment, String medicalPrescriptions, String medicalNotes) {
        this.medicalrecord = medicalrecord;
        this.medicalExamingdDate = medicalExamingdDate;
        this.DoctorsName = doctorsName;
        this.Diagnosis = diagnosis;
        this.MedicalTreatment = medicalTreatment;
        this.MedicalPrescriptions = medicalPrescriptions;
        this.MedicalNotes = medicalNotes;
    }

    public static void connect_medical_record_to_animal() {
    }
    public static boolean createMedicalRecord(){
        // ΒΗΜΑ 1:
        // Πέρασε μία-μία όλες τις θέσεις του πίνακα records.
        // Χρειάζεσαι for.


        // ΒΗΜΑ 2:
        // Για κάθε θέση, έλεγξε:
        // "Είναι αυτή η θέση άδεια;"
        //
        // Άδεια θέση σημαίνει == null.


        // ΒΗΜΑ 3:
        // Αν βρεις άδεια θέση,
        // βάλε εκεί μέσα το record που σου έδωσε ο χρήστης.
        //
        // Δηλαδή:
        // η θέση records[i] πρέπει να πάρει την τιμή record.


        // ΒΗΜΑ 4:
        // Αν το έβαλες επιτυχώς,
        // επέστρεψε true.


        // ΒΗΜΑ 5:
        // Αν τελειώσει ΟΛΗ η for και δεν βρήκες
        // καμία άδεια θέση, επέστρεψε false.
        return false;
    }

    public  static MedicalRecords findMedicalRecord()
    {
        // ΒΗΜΑ 1:
        // Πέρασε μία-μία όλες τις θέσεις του records.


        // ΒΗΜΑ 2:
        // Έλεγξε πρώτα ότι η συγκεκριμένη θέση
        // ΔΕΝ είναι null.


        // ΒΗΜΑ 3:
        // Πάρε το medicalRecord της συγκεκριμένης εγγραφής
        // χρησιμοποιώντας τον getter:
        //
        // records[i].getMedicalrecord()


        // ΒΗΜΑ 4:
        // Σύγκρινέ το με το medicalRecord που ψάχνουμε.
        //
        // ΠΡΟΣΟΧΗ:
        // Είναι String, επομένως χρησιμοποίησε .equals()
        // και όχι ==


        // ΒΗΜΑ 5:
        // Αν είναι ίδιο,
        // επέστρεψε ΟΛΟΚΛΗΡΟ το records[i].


        // ΒΗΜΑ 6:
        // Αν τελειώσει η for και δεν βρεθεί,
        return null;
    }
    public static int countMedicalRecords() {
        // ΒΗΜΑ 1:
        // Φτιάξε έναν counter και ξεκίνα τον από 0.


        // ΒΗΜΑ 2:
        // Πέρασε όλες τις θέσεις του πίνακα με for.


        // ΒΗΜΑ 3:
        // Αν records[i] ΔΕΝ είναι null,
        // σημαίνει ότι υπάρχει ιατρική εγγραφή.


        // ΒΗΜΑ 4:
        // Για κάθε πραγματική εγγραφή,
        // αύξησε τον counter κατά 1.


        // ΒΗΜΑ 5:
        // Όταν τελειώσει η for,
        // επέστρεψε τον counter.
        return 0;
    }

    public static int countMedicalRecordsByAnimal(
            MedicalRecords[] records,
            int animalId) {

        // ΒΗΜΑ 1:
        // Φτιάξε counter = 0.


        // ΒΗΜΑ 2:
        // Πέρασε μία-μία όλες τις εγγραφές.


        // ΒΗΜΑ 3:
        // Έλεγξε ότι records[i] != null.


        // ΒΗΜΑ 4:
        // Αν υπάρχει record,
        // πάρε το animalId του συγκεκριμένου record.


        // ΒΗΜΑ 5:
        // Σύγκρινε:
        //
        // animalId του records[i]
        //          ΜΕ
        // animalId που ψάχνουμε


        // ΒΗΜΑ 6:
        // Αν είναι ίδια,
        // counter++.


        // ΒΗΜΑ 7:
        // Όταν τελειώσει η for,
        // return counter.
        return 0;
    }
    public static boolean updateDiagnosis(){
        return false;
    }
    public static void medical_examination_date() {
    }

    public static void DoctorsName() {
    }

    public static void Diagnosis() {
    }

    public static void MedicalTreatment() {
    }

    public static void MedicalPrescriptions() {
    }

    public static void MedicalNotes() {
    }

    public static void MedicalHistoryPerAnimal() {
    }
}

