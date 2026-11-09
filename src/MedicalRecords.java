import java.util.Date;

public class MedicalRecords {
    private String medicalrecord;
    MedicalRecords[] medicalRecords = new MedicalRecords[1000000];
    private Date medicalExamingdDate;
    private String DoctorsName;
    private String Diagnosis;
    private String MedicalTreatment;
    private String MedicalPrescriptions;
    private String MedicalNotes;
    private String medicalrecordId;

    public MedicalRecords() {
    }

    public MedicalRecords(String medicalrecord, String medicalrecordId, Date medicalExamingdDate, String doctorsName, String diagnosis, String medicalTreatment, String medicalPrescriptions, String medicalNotes, MedicalRecords[] medicalRecords) {
        this.medicalrecord = medicalrecord;
        this.medicalrecordId = medicalrecordId;
        this.medicalExamingdDate = medicalExamingdDate;
        DoctorsName = doctorsName;
        Diagnosis = diagnosis;
        MedicalTreatment = medicalTreatment;
        MedicalPrescriptions = medicalPrescriptions;
        MedicalNotes = medicalNotes;
        this.medicalRecords = medicalRecords;
    }

    public static boolean createMedicalRecord(MedicalRecords[] medicalRecords, Animals animal, MedicalRecords medicalRecord) {

        for (int i = 0; i < medicalRecords.length; i++) {
            if (medicalRecords[i] == null) {
                medicalRecords[i] = medicalRecord;
                return true;
            }
        }
        return false;
    }
    public void setMedicalrecord(String medicalrecord) {
        this.medicalrecord = medicalrecord;
    }

    public static MedicalRecords findMedicalRecord(MedicalRecords[] medicalRecords, MedicalRecords medicalRecord) {

        for (int i = 0; i < medicalRecords.length; i++) {
            if (medicalRecords[i] != null) {
                if (medicalRecords[i].getMedicalrecord().equals(medicalRecord.getMedicalrecord())) {
                    return medicalRecords[i];
                }
            }
        }
        return null;
    }

    public static int countMedicalRecords(MedicalRecords[] medicalRecords, MedicalRecords medicalRecord, Animals animal) {
        if (medicalRecords == null) {
            return 0;
        }
        int counter = 0;
        for (int i = 0; i < medicalRecords.length; i++) {
            if (medicalRecords[i] != null) {
                medicalRecords[i] = medicalRecord;
                counter++;
            }
        }
        return 0;
    }

    public static int countMedicalRecordsByAnimal(MedicalRecords[] medicalRecords, MedicalRecords medicalRecord, Animals animal) {

        if (medicalRecords == null) {
            return 0;
        }
        int counter = 0;
        for (int i = 0; i < medicalRecords.length; i++) {
            if (medicalRecords[i] != null) {
                if (medicalRecords[i].getMedicalrecordId().equals(medicalRecord.getMedicalrecordId())) {
                    counter++;
                }
            }
        }
        return counter;
    }
    public void setMedicalExamingdDate(Date medicalExamingdDate) {
        this.medicalExamingdDate = medicalExamingdDate;
    }

    public String getMedicalrecord() {
        return medicalrecord;
    }

    public String getMedicalrecordId() {
        return medicalrecordId;
    }

    public void setMedicalrecordId(String medicalrecordId) {
        this.medicalrecordId = medicalrecordId;
    }

    public Date getMedicalExamingdDate() {
        return medicalExamingdDate;
    }

    public String getDoctorsName() {
        return DoctorsName;
    }

    public void setDoctorsName(String doctorsName) {
        DoctorsName = doctorsName;
    }

    public String getDiagnosis() {
        return Diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        Diagnosis = diagnosis;
    }

    public String getMedicalTreatment() {
        return MedicalTreatment;
    }

    public void setMedicalTreatment(String medicalTreatment) {
        MedicalTreatment = medicalTreatment;
    }

    public String getMedicalPrescriptions() {
        return MedicalPrescriptions;
    }

    public void setMedicalPrescriptions(String medicalPrescriptions) {
        MedicalPrescriptions = medicalPrescriptions;
    }

    // Methods

    public String getMedicalNotes() {
        return MedicalNotes;
    }

    public void setMedicalNotes(String medicalNotes) {
        MedicalNotes = medicalNotes;
    }

    public MedicalRecords[] getMedicalRecords() {
        return medicalRecords;
    }

    public void setMedicalRecords(MedicalRecords[] medicalRecords) {
        this.medicalRecords = medicalRecords;
    }

}
