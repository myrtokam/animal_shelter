
import java.util.Date;

public class MedicalRecords {
    private String medicalrecord;
    private Date medicalExamingdDate;
    private String DoctorsName;
    private String Diagnosis;
    private String MedicalTreatment;
    private String MedicalPrescriptions;
    private String MedicalNotes;

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

