import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Allergy {
    private int allergyId;
    private int animalId;
    private String allergen;
    private String reaction;
    private String severity;
    private LocalDate diagnosisDate;
    private String notes;

    public Allergy() {
    }

    public Allergy(int allergyId, int animalId, String allergen, String reaction, String severity, LocalDate diagnosisDate, String notes) {
        this.allergyId = allergyId;
        this.animalId = animalId;
        this.allergen = allergen;
        this.reaction = reaction;
        this.severity = severity;
        this.diagnosisDate = diagnosisDate;
        this.notes = notes;
    }

    public static boolean registerAllergy(Allergy[] registerAllergy, Allergy alergies) {//Καταχωρίζει νέα αλλεργία
        for (int i = 0; i < registerAllergy.length; i++) {
            if (registerAllergy[i] != null) {
                registerAllergy[i] = alergies;
                return true;
            }
        }
        return false;
    }

    public static Allergy findAllergyById(Allergy[] registerAllergy, int allergyId, Allergy allergy) {/*Allergy	Αναζητά αλλεργία με το ID της*/
        for (int i = 0; i < registerAllergy.length; i++) {
            if (registerAllergy[i] != null && registerAllergy[i].getAllergyId() == allergyId) {
                return registerAllergy[i];
            }
        }

        return allergy;
    }

    public static List<Allergy> getAllergiesByAnimal(Allergy[] registerAllergy, Animals animals, Allergy allergy) {/* ArrayList<Allergy> Επιστρέφει όλες τις αλλεργίες ενός ζώου*/
        List<Allergy> allergies = new ArrayList<>();


        for (int i = 0; i < registerAllergy.length; i++) {
            if (registerAllergy[i] != null && registerAllergy[i].getAnimalId() == animals.getAnimalId()) {
                allergies.add(registerAllergy[i]);
            }
        }
        return allergies;
    }

    public static boolean updateAllergy(Allergy[] registerAllergy, int id, String newValue, Animals animals, Allergy allergy) {/*  Ενημερώνει στοιχεία αλλεργίας*/

        for (int i = 0; i < registerAllergy.length; i++) {
            if (registerAllergy[i] != null && registerAllergy[i].getAnimalId() == animals.getAnimalId()) {
                registerAllergy[i].setAllergyId(id);
            }
            if (registerAllergy[i] != null && registerAllergy[i].getAnimalId() == animals.getAnimalId()) {
                registerAllergy[i].setAllergen(newValue);
            }
            if (registerAllergy[i] != null && registerAllergy[i].getAnimalId() == animals.getAnimalId()) {
                registerAllergy[i].setReaction(newValue);
            }
            if (registerAllergy[i] != null && registerAllergy[i].getAnimalId() == animals.getAnimalId()) {
                registerAllergy[i].setDiagnosisDate(LocalDate.of(2026, 11, 11));
            }
            if (registerAllergy[i] != null && registerAllergy[i].getAnimalId() == animals.getAnimalId()) {
                registerAllergy[i].setNotes(newValue);
            }
            if (registerAllergy[i] != null && registerAllergy[i].getAnimalId() == animals.getAnimalId()) {
                registerAllergy[i].setSeverity(newValue);
            }
            return true;
        }
        return false;
    }


    public static int countAllergiesByAnimal(Allergy[] registerAllergy, int id, String newValue, Animals animals, Allergy allergy) {/*Μετρά τις αλλεργίες συγκεκριμένου ζώου*/
        int count = 0;
        for (int i = 0; i < registerAllergy.length; i++) {
            if (registerAllergy[i] != null) {
            }
        }
        return 0;
    }

    public int getAllergyId() {
        return allergyId;
    }

    public void setAllergyId(int allergyId) {
        this.allergyId = allergyId;
    }

    public int getAnimalId() {
        return animalId;
    }

    public void setAnimalId(int animalId) {
        this.animalId = animalId;
    }

    public String getAllergen() {
        return allergen;
    }

    public void setAllergen(String allergen) {
        this.allergen = allergen;
    }

    public String getReaction() {
        return reaction;
    }

    public void setReaction(String reaction) {
        this.reaction = reaction;
    }

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public LocalDate getDiagnosisDate() {
        return diagnosisDate;
    }

    public void setDiagnosisDate(LocalDate diagnosisDate) {
        this.diagnosisDate = diagnosisDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
