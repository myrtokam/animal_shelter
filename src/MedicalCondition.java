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
    Animals[] animals = new Animals[100000000];
    private String newNotes;
    private MedicalCondition[] medicalCondition = new MedicalCondition[100000000];

    public MedicalCondition(MedicalCondition[] medicalCondition) {
        this.medicalCondition = medicalCondition;
    }

    public static boolean createMedicalCondition(MedicalCondition[] medicalCondition, Animals[] animals, MedicalCondition conditionName) {
        //Δημιουργεί μια νέα καταχώριση πάθησης

        boolean animalExist = false;
        for (int i = 0; i < animals.length; i++) {
            if (animals[i].getAnimalId() == medicalCondition[i].getAnimalId()) {
                animalExist = true;
                break;

            }
        }
        if (!animalExist) {
            return false;
        }

        for (int j = 0; j < medicalCondition.length; j++) {


            if (medicalCondition[j] == null) {
                medicalCondition[j] = conditionName;
                return true;
            }
        }
        return false;
    }

    public static boolean findMedicalCondition(MedicalCondition medicalCondition, MedicalCondition[] medicalConditions, Animals animal, Animals[] animals) {
        //Αναζητά μια πάθηση με βάση το conditionId
        for (int j = 0; j < animals.length; j++) {
            if (animal == null) {
                return false;
            }
        }

        for (int i = 0; i < medicalConditions.length; i++) {
            if (medicalConditions[i] != null && medicalConditions[i].getAnimalId() == animal.getAnimalId()) {
                return true;
            }
        }
        return false;
    }

    public static MedicalCondition[] getMedicalConditionsByAnimal(MedicalCondition[] medicalConditions, Animals animal) {
        //	Επιστρέφει όλες τις παθήσεις ενός ζώου
        int count = 0;
        MedicalCondition[] medicalCondition1 = new MedicalCondition[count];

        int counter = 0;

        // Δεύτερο for: Αποθηκεύουμε τις παθήσεις
        for (int i = 0; i < medicalConditions.length; i++) {

            if (medicalConditions[i] != null &&
                    medicalConditions[i].getAnimalId() == animal.getAnimalId()) {

                medicalCondition1[counter] = medicalConditions[i];
                counter++;
            }
    }

        return medicalCondition1;
    }

    public static String updateMedicalCondition(MedicalCondition[] medicalConditions, String value, MedicalCondition medicalCondition, Animals animals) {
        //Ενημερώνει τα στοιχεία μιας πάθησης

        for (int i = 0; i < medicalConditions.length; i++) {

            if (medicalConditions[i] != null && medicalConditions[i].getAnimalId() == animals.getAnimalId()) {

                medicalConditions[i].setStatus(value);
                medicalConditions[i].setUpdateAt(LocalDateTime.now());
                return value;
            }
        }

        return null;
    }

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

    public MedicalCondition[] getMedicalCondition() {
        return medicalCondition;
    }

    public void setMedicalCondition(MedicalCondition[] medicalCondition) {
        this.medicalCondition = medicalCondition;
    }

    public String getNewNotes() {
        return newNotes;
    }

    public void setNewNotes(String newNotes) {
        this.newNotes = newNotes;
    }

    public int countMedicalConditions(MedicalCondition[] medicalConditions, MedicalCondition medicalCondition, Animals animal) {
        //	Μετρά τις συνολικές καταχωρίσεις παθήσεων
        int count = 0;
        for (int i = 0; i < medicalConditions.length; i++) {

            if (medicalConditions[i] != null) {
                count++;
            }
        }
        return count;
    }

    public boolean hasChronicCondition(MedicalCondition[] medicalConditions, MedicalCondition medicalCondition, Animals animal) {
        //Ελέγχει αν ένα συγκεκριμένο ζώο έχει χρόνια πάθηση
        boolean isVChronic = false;
        for (int i = 0; i < medicalConditions.length; i++) {
            if (medicalConditions[i] != null && medicalConditions[i].getAnimalId() == animal.getAnimalId() &&
                    medicalConditions[i].isChronic()) {
                return true;
            }
        }
        return false;
    }

    public void closeMedicalCondition(Animals animals, MedicalCondition[] medicalConditions, MedicalCondition medicalCondition) {
        //	Σημειώνει ότι μια πάθηση έχει θεραπευτεί ή δεν είναι πλέον ενεργή
        for (int i = 0; i < medicalConditions.length; i++) {
            if (medicalConditions[i] != null && medicalConditions[i].getAnimalId() == animals.getAnimalId()) {
                if (medicalConditions[i].getStatus().equals("ACTIVE")) {
                    medicalConditions[i].setStatus("RESOLVED");
                    return;
                }
            }
        }
    }

    public boolean getActiveConditionsByAnimal(MedicalCondition[] medicalConditions, MedicalCondition medicalCondition, Animals animals) {
    //Εμφανίζει τις ενεργές παθήσεις ενός ζώου.
        for (int i = 0; i < medicalConditions.length; i++) {
            if (medicalConditions[i] != null && medicalConditions[i].getAnimalId() == animals.getAnimalId()) {
                if (medicalConditions[i].getStatus().equals("ACTIVE")) {
                    return true;
                }
            }
        }
        return false;
    }

    public boolean getChronicConditionsByAnimal(MedicalCondition[] medicalConditions, MedicalCondition medicalCondition, Animals animals) {
        //Εμφανίζει τις χρόνιες παθήσεις ενός ζώου.
        for (int i = 0; i < medicalConditions.length; i++) {
            if (medicalConditions[i] != null && medicalConditions[i].getAnimalId() == animals.getAnimalId()) {
                if (medicalConditions[i].isChronic()) {
                    return true;
                }
            }
        }
        return false;
    }

    public void updateConditionStatus(MedicalCondition[] medicalConditions, MedicalCondition medicalCondition, Animals animals) {
        //Αλλάζει την <κατάσταση μιας πάθησης (Active, Resolved).
        for (int i = 0; i < medicalConditions.length; i++) {
            if (medicalConditions[i] != null && medicalConditions[i].getAnimalId() == animals.getAnimalId() && medicalConditions[i].getConditionID() == medicalCondition.getConditionID()) {
                if (medicalConditions[i].getStatus().equals("ACTIVE")) {
                    medicalConditions[i].setStatus("COMPLETE");
                }
            }
        }
    }

    public void updateDiagnosisDate(MedicalCondition medicalCondition, MedicalCondition[] medicalConditions, Animals animal) {
    //Διορθώνει την ημερομηνία διάγνωσης.
        for (int i = 0; i < medicalConditions.length; i++) {
            if (medicalConditions[i] != null && medicalConditions[i].getAnimalId() == animal.getAnimalId() && medicalConditions[i].getConditionID() == medicalCondition.getConditionID()) {
                if (medicalConditions[i].getDiagnosisDate() == null) {
                    medicalConditions[i].setDiagnosisDate(LocalDate.of(2026, 11, 11));
                }
            }
        }
    }

    public void addConditionNotes(MedicalCondition[] medicalConditions, MedicalCondition medicalCondition, String newNotes, Animals animals) {
        //Προσθέτει παρατηρήσεις για την πάθηση.
        for (int i = 0; i < medicalConditions.length; i++) {
            if (medicalConditions[i] != null && medicalConditions[i].getAnimalId() == animals.getAnimalId() && medicalConditions[i].getConditionID() == medicalCondition.getConditionID()) {
                if (medicalConditions[i].getNotes() != null) {
                    medicalConditions[i].setNotes(medicalCondition.getNotes() + "\n" + newNotes);
                } else {
                    medicalConditions[i].setNotes(newNotes);
                    return;
                }
            }
        }
    }

    public int countConditionsByAnimal(MedicalCondition medicalCondition, MedicalCondition[] medicalConditions, Animals animals) {
        //Μετρά πόσες παθήσεις έχουν καταγραφεί για ένα ζώο.
        int count = 0;

        for (int i = 0; i < medicalConditions.length; i++) {
            if (medicalConditions[i] != null && medicalConditions[i].getAnimalId() == animals.getAnimalId()) {
                count++;
            }
        }
        return count;
    }

    public int countAnimalsWithCondition(MedicalCondition[] medicalConditions, MedicalCondition medicalCondition, Animals animals) {
        //Μετρά πόσα ζώα έχουν μια συγκεκριμένη πάθηση.
        int count = 0;

        for (int i = 0; i < medicalConditions.length; i++) {

            if (medicalConditions[i] != null
                    && medicalCondition.getMedicalCondition().equals(
                    medicalConditions[i].getMedicalCondition())) {
                count++;
            }
        }
        return count;
    }

    public String getConditionsByDiagnosisDate(MedicalCondition[] medicalConditions, MedicalCondition medicalCondition, Animals animals) {
        //Αναζητά παθήσεις βάσει ημερομηνίας διάγνωσης.
        for (int i = 0; i < medicalConditions.length; i++) {
            if (medicalConditions[i] != null && medicalConditions[i].getDiagnosisDate() != null) {
                if (medicalConditions[i].getDiagnosisDate().equals(medicalCondition.getDiagnosisDate())) {
                    return medicalConditions[i].getConditionName();
                }
            }
            return null;
        }
        return "";
    }
}
