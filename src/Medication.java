
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Medication {

    private int medicationId;
    private int animalId;
    private String medicationName;
    private String dosage;
    private String frequency;
    private LocalDate startDate;
    private LocalDate endDate;
    private String prescribedBy;
    private String status;
    private String notes;

    public Medication() {
    }
    public Medication(int medicationId, int animalId, String medicationName, String dosage, String frequency, LocalDate startDate, LocalDate endDate, String prescribedBy, String status, String notes) {
        this.medicationId = medicationId;
        this.animalId = animalId;
        this.medicationName = medicationName;
        this.dosage = dosage;
        this.frequency = frequency;
        this.startDate = startDate;
        this.endDate = endDate;
        this.prescribedBy = prescribedBy;
        this.status = status;
        this.notes = notes;
    }

    public int getMedicationId() {
        return medicationId;
    }
    public void setMedicationId(int medicationId) {
        this.medicationId = medicationId;
    }
    public int getAnimalId() {
        return animalId;
    }
    public void setAnimalId(int animalId) {
        this.animalId = animalId;
    }
    public String getMedicationName() {
        return medicationName;
    }
    public void setMedicationName(String medicationName) {
        this.medicationName = medicationName;
    }
    public String getDosage() {
        return dosage;
    }
    public void setDosage(String dosage) {
        this.dosage = dosage;
    }
    public String getFrequency() {
        return frequency;
    }
    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }
    public LocalDate getStartDate() {
        return startDate;
    }
    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }
    public LocalDate getEndDate() {
        return endDate;
    }
    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }
    public String getPrescribedBy() {
        return prescribedBy;
    }
    public void setPrescribedBy(String prescribedBy) {
        this.prescribedBy = prescribedBy;
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

    //Methods

    public static boolean createMedication(Medication [] medications, Medication medication, Animals animal){
        //	Προσθήκη φαρμακευτικής αγωγής
        if(medications==null || medication==null){
            return false;
        }
        for(int i=0; i<medications.length; i++){
            if( medications[i]==null){
                medications[i]=medication;
                return true;
            }
        }
        return false;
    }
    public static Medication findMedicationById(Medication [] medications, Medication medication, Animals animal){
        //	Αναζήτηση με ID

        if(medications == null || medication ==null){
            return medication;
        }
        for(int i=0; i<medications.length; i++){
            if(medications[i]!=null && medications[i].getAnimalId()== medication.getAnimalId()){
                return medications[i];
            }
        }

        	return null;
    }
    public static Medication updateMedication(Medication [] medications, Medication medication, Animals animal){
        //Ενημέρωση στοιχείων

        if(medications == null || medication== null){
            return null;
        }
        for(int i=0; i<medications.length; i++){
        if(medications[i]!=null && medications[i].getAnimalId()== medication.getAnimalId()){
            if(medications[i].getMedicationName()!=null){
                medications[i].setMedicationName(medications[i].getMedicationName());
            }
            if(medications[i].getDosage()!=null){
               medications[i].setDosage(medications[i].getDosage());
            }
            if(medications[i].getNotes()!=null){
               medications[i].setNotes(medications[i].getNotes());
            }
            if(medications[i].getStatus()!=null){
                medications[i].setStatus(medications[i].getStatus());
            }
            if(medications[i].getFrequency()!=null){
                medications[i].setFrequency(medications[i].getFrequency());
            }
            if(medications[i]!=null){
                medications[i].setEndDate(medications[i].getEndDate());
            }
            if(medications[i]!=null){
                medications[i].setStartDate(medications[i].getStartDate());
            }
            if(medications[i]!=null){
                medications[i].setPrescribedBy(medications[i].getPrescribedBy());
            }
            return medications[i];
        }
        }
        return null;
    }
    public static boolean deleteMedication(Medication [] medications, Medication medication, Animals animal){return false;}	//Διαγραφή εγγραφής

    public static 	List<Medication> getAllMedications(Medication [] medications, Medication medication, Animals animal, List<Medication> newMedication) {//	Όλες οι αγωγές
        if(newMedication==null){
            newMedication = new ArrayList<>();
        }
        if(medications==null){
            return  newMedication;
        }
        for(int i=0; i<medications.length; i++){
            if(medications[i]!=null){
                newMedication.add(medications[i]);
            }
        }
        return  newMedication;
    }
    public static 	List<Medication> getMedicationsByAnimal(Medication [] medications, Medication medication, Animals animal, List<Medication> newMedication) {
        //	Αγωγές συγκεκριμένου ζώου
        if(newMedication==null){
            newMedication = new ArrayList<>();
        }
        if(medications==null){
            return  newMedication;
        }
        for(int i=0; i<medications.length; i++) {
            if (medications[i] != null && medications[i].animalId == medication.animalId) {
                newMedication.add(medications[i]);
            }
        }
        return newMedication;
    }


    public static int countMedications(Medication [] medications, Medication medication, Animals animal){return 0;}	//	Συνολικός αριθμός
    public static int countMedicationsByAnimal(Medication [] medications, Medication medication, Animals animal){return 0;}	//Πλήθος ανά ζώο
    public static List<Medication> findMedicationByName(Medication [] medications, Medication medication, Animals animal){return null;}	//	Αναζήτηση με όνομα
    public static boolean completeMedication(Medication [] medications, Medication medication, Animals animal){return false;}		//Ολοκλήρωση αγωγής
    public static boolean cancelMedication(Medication [] medications, Medication medication, Animals animal){return false;}		//Ακύρωση αγωγής
    public static List<Medication> getActiveMedications(Medication [] medications, Medication medication, Animals animal){ return null;}
    public static boolean isValidMedication(Medication [] medications, Medication medication, Animals animal){return false;}//Βασικός έλεγχος δεδομένων
}




