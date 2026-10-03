import java.time.LocalDate;
import java.time.LocalDateTime;


public class MedicalCondition {

    private int conditionID;
    private String conditionName;
    private String description;
    private boolean chronic;
    private int animalId;
    private LocalDate diagnosisDate;
    private LocalDateTime createdAt;
    private LocalDateTime updateAt;
    private String status;
    private String notes;

    public MedicalCondition(int conditionID, String conditionName, String description, boolean chronic, int animalId, LocalDate diagnosisDate, LocalDateTime createdAt, LocalDateTime updateAt, String status, String notes) {
        this.conditionID = conditionID;
        this.conditionName = conditionName;
        this.description = description;
        this.chronic = chronic;
        this.animalId = animalId;
        this.diagnosisDate = diagnosisDate;
        this.createdAt = createdAt;
        this.updateAt = updateAt;
        this.status = status;
        this.notes = notes;
    }

    public MedicalCondition() {
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public int getConditionID() {
        return conditionID;
    }

    public void setConditionID(int conditionID) {
        this.conditionID = conditionID;
    }

    public String getConditionName() {
        return conditionName;
    }

    public void setConditionName(String conditionName) {
        this.conditionName = conditionName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isChronic() {
        return chronic;
    }

    public void setChronic(boolean chronic) {
        this.chronic = chronic;
    }

    public int getAnimalId() {
        return animalId;
    }

    public void setAnimalId(int animalId) {
        this.animalId = animalId;
    }

    public LocalDate getDiagnosisDate() {
        return diagnosisDate;
    }

    public void setDiagnosisDate(LocalDate diagnosisDate) {
        this.diagnosisDate = diagnosisDate;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(LocalDateTime updateAt) {
        this.updateAt = updateAt;
    }

    /*METHODS*/

    public void createMedicalCondition() {
    }

    //Δημιουργεί μια νέα καταχώριση πάθησης

    public void findMedicalCondition() {
    }

    //Αναζητά μια πάθηση με βάση το conditionId

    public void getMedicalConditionsByAnimal() {
    }

    //	Επιστρέφει όλες τις παθήσεις ενός ζώου

    public void updateMedicalCondition() {
    }

    //Ενημερώνει τα στοιχεία μιας πάθησης


    public void countMedicalConditions() {
    }

    //	Μετρά τις συνολικές καταχωρίσεις παθήσεων


    public void countChronicConditions() {
    }

    //Μετρά τις χρόνιες παθήσεις


    public void hasChronicCondition() {
    }

    //Ελέγχει αν ένα συγκεκριμένο ζώο έχει χρόνια πάθηση


    public void closeMedicalCondition() {
    }

    //	Σημειώνει ότι μια πάθηση έχει θεραπευτεί ή δεν είναι πλέον ενεργή


    public void getActiveConditionsByAnimal() {
    }

    //Εμφανίζει τις ενεργές παθήσεις ενός ζώου.


    public void getChronicConditionsByAnimal() {
    }

    //Εμφανίζει τις χρόνιες παθήσεις ενός ζώου.


    public void updateConditionStatus() {
    }

    //Αλλάζει την κατάσταση μιας πάθησης (Active, Resolved).


    public void updateDiagnosisDate() {
    }

    //Διορθώνει την ημερομηνία διάγνωσης.


    public void addConditionNotes() {
    }

    //Προσθέτει παρατηρήσεις για την πάθηση.


    public void countConditionsByAnimal() {
    }

    //Μετρά πόσες παθήσεις έχουν καταγραφεί για ένα ζώο.


    public void countAnimalsWithCondition() {
    }

    //Μετρά πόσα ζώα έχουν μια συγκεκριμένη πάθηση.


    public void getConditionsByDiagnosisDate() {
    }

    //Αναζητά παθήσεις βάσει ημερομηνίας διάγνωσης.
}
