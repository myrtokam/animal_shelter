package Model.Health;

import java.time.LocalDate;
import java.time.LocalDateTime;


public class MedicalCondition {

    Animals[] animals = new Animals[100000000];
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
    private String newNotes;
    private MedicalCondition[] medicalCondition = new MedicalCondition[100000000];

    public MedicalCondition(MedicalCondition[] medicalCondition) {
        this.medicalCondition = medicalCondition;
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
    package Model.Health;

import java.time.LocalDate;
import java.time.LocalDateTime;

    public class MedicalCondition {

        // Primary Key
        private long conditionID;

        // Foreign Keys
        private Long animalId;
        private Long organizationId;
        private Long veterinarianId;
        private Long medicalRecordId;
        private Long recordedByUserId;

        // Basic condition information
        private String conditionName;
        private String description;
        private String status;
        private String conditionCode;
        private String diagnosisStatus;
        private Boolean chronic;
        private String notes;

        // Dates
        private LocalDate diagnosisDate;
        private LocalDate onsetDate;
        private LocalDateTime resolvedAt;
        private LocalDateTime observedAt;

        // Clinical information
        private String clinicalContext;
        private String clinicalPriority;
        private String clinicalFindings;
        private String clinicalAssessment;
        private String clinicalRecommendations;
        private String clinicalReviewStatus;
        private String clinicalSource;

        // Follow-up
        private Boolean followupRequired;
        private LocalDateTime followupAt;

        // Medical documentation
        private LocalDateTime veterinarySignoffAt;
        private String medicalEvidenceRef;
        private String medicalCaseReference;

        // Audit information
        private String recordReference;
        private String recordSource;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;


        // ==========================================
        // CONSTRUCTORS
        // ==========================================

        public MedicalCondition() {
        }

        public MedicalCondition(
                long conditionID,
                Long animalId,
                String conditionName,
                String description,
                String status,
                LocalDate diagnosisDate,
                Boolean chronic,
                String notes
        ) {
            this.conditionID = conditionID;
            this.animalId = animalId;
            this.conditionName = conditionName;
            this.description = description;
            this.status = status;
            this.diagnosisDate = diagnosisDate;
            this.chronic = chronic;
            this.notes = notes;
        }


        // ==========================================
        // GETTERS AND SETTERS
        // ==========================================

        public long getConditionID() {
            return conditionID;
        }

        public void setConditionID(long conditionID) {
            this.conditionID = conditionID;
        }

        public Long getAnimalId() {
            return animalId;
        }

        public void setAnimalId(Long animalId) {
            this.animalId = animalId;
        }

        public Long getOrganizationId() {
            return organizationId;
        }

        public void setOrganizationId(Long organizationId) {
            this.organizationId = organizationId;
        }

        public Long getVeterinarianId() {
            return veterinarianId;
        }

        public void setVeterinarianId(Long veterinarianId) {
            this.veterinarianId = veterinarianId;
        }

        public Long getMedicalRecordId() {
            return medicalRecordId;
        }

        public void setMedicalRecordId(Long medicalRecordId) {
            this.medicalRecordId = medicalRecordId;
        }

        public Long getRecordedByUserId() {
            return recordedByUserId;
        }

        public void setRecordedByUserId(Long recordedByUserId) {
            this.recordedByUserId = recordedByUserId;
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

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getConditionCode() {
            return conditionCode;
        }

        public void setConditionCode(String conditionCode) {
            this.conditionCode = conditionCode;
        }

        public String getDiagnosisStatus() {
            return diagnosisStatus;
        }

        public void setDiagnosisStatus(String diagnosisStatus) {
            this.diagnosisStatus = diagnosisStatus;
        }

        public Boolean getChronic() {
            return chronic;
        }

        public String getNotes() {
            return notes;
        }

        public void setNotes(String notes) {
            this.notes = notes;
        }

        public LocalDate getDiagnosisDate() {
            return diagnosisDate;
        }

        public void setDiagnosisDate(LocalDate diagnosisDate) {
            this.diagnosisDate = diagnosisDate;
        }

        public LocalDate getOnsetDate() {
            return onsetDate;
        }

        public void setOnsetDate(LocalDate onsetDate) {
            this.onsetDate = onsetDate;
        }

        public LocalDateTime getResolvedAt() {
            return resolvedAt;
        }

        public void setResolvedAt(LocalDateTime resolvedAt) {
            this.resolvedAt = resolvedAt;
        }

        public LocalDateTime getObservedAt() {
            return observedAt;
        }

        public void setObservedAt(LocalDateTime observedAt) {
            this.observedAt = observedAt;
        }

        public String getClinicalContext() {
            return clinicalContext;
        }

        public void setClinicalContext(String clinicalContext) {
            this.clinicalContext = clinicalContext;
        }

        public String getClinicalPriority() {
            return clinicalPriority;
        }

        public void setClinicalPriority(String clinicalPriority) {
            this.clinicalPriority = clinicalPriority;
        }

        public String getClinicalFindings() {
            return clinicalFindings;
        }

        public void setClinicalFindings(String clinicalFindings) {
            this.clinicalFindings = clinicalFindings;
        }

        public String getClinicalAssessment() {
            return clinicalAssessment;
        }

        public void setClinicalAssessment(String clinicalAssessment) {
            this.clinicalAssessment = clinicalAssessment;
        }

        public String getClinicalRecommendations() {
            return clinicalRecommendations;
        }

        public void setClinicalRecommendations(
                String clinicalRecommendations
        ) {
            this.clinicalRecommendations = clinicalRecommendations;
        }

        public String getClinicalReviewStatus() {
            return clinicalReviewStatus;
        }

        public void setClinicalReviewStatus(
                String clinicalReviewStatus
        ) {
            this.clinicalReviewStatus = clinicalReviewStatus;
        }

        public String getClinicalSource() {
            return clinicalSource;
        }

        public void setClinicalSource(String clinicalSource) {
            this.clinicalSource = clinicalSource;
        }

        public Boolean getFollowupRequired() {
            return followupRequired;
        }

        public void setFollowupRequired(Boolean followupRequired) {
            this.followupRequired = followupRequired;
        }

        public LocalDateTime getFollowupAt() {
            return followupAt;
        }

        public void setFollowupAt(LocalDateTime followupAt) {
            this.followupAt = followupAt;
        }

        public LocalDateTime getVeterinarySignoffAt() {
            return veterinarySignoffAt;
        }

        public void setVeterinarySignoffAt(
                LocalDateTime veterinarySignoffAt
        ) {
            this.veterinarySignoffAt = veterinarySignoffAt;
        }

        public String getMedicalEvidenceRef() {
            return medicalEvidenceRef;
        }

        public void setMedicalEvidenceRef(String medicalEvidenceRef) {
            this.medicalEvidenceRef = medicalEvidenceRef;
        }

        public String getMedicalCaseReference() {
            return medicalCaseReference;
        }

        public void setMedicalCaseReference(
                String medicalCaseReference
        ) {
            this.medicalCaseReference = medicalCaseReference;
        }

        public String getRecordReference() {
            return recordReference;
        }

        public void setRecordReference(String recordReference) {
            this.recordReference = recordReference;
        }

        public String getRecordSource() {
            return recordSource;
        }

        public void setRecordSource(String recordSource) {
            this.recordSource = recordSource;
        }

        public LocalDateTime getCreatedAt() {
            return createdAt;
        }

        public void setCreatedAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
        }

        public LocalDateTime getUpdatedAt() {
            return updatedAt;
        }

        public void setUpdatedAt(LocalDateTime updatedAt) {
            this.updatedAt = updatedAt;
        }

        public boolean isActive() {
            return "ACTIVE".equalsIgnoreCase(status);
        }


        // ==========================================
        // HELPER METHODS
        // ==========================================

        public boolean isResolved() {
            return "RESOLVED".equalsIgnoreCase(status);
        }

        public boolean isChronic() {
            return Boolean.TRUE.equals(chronic);
        }

        public void setChronic(Boolean chronic) {
            this.chronic = chronic;
        }

        public boolean isChronicityUnknown() {
            return chronic == null;
        }

        public boolean isRemission() {
            return "REMISSION".equalsIgnoreCase(status);
        }

        public boolean isRecurrent() {
            return "RECURRENT".equalsIgnoreCase(status);
        }

        public boolean isConfirmed() {
            return "CONFIRMED".equalsIgnoreCase(diagnosisStatus);
        }

        public boolean isSuspected() {
            return "SUSPECTED".equalsIgnoreCase(diagnosisStatus);
        }

        public boolean isRuledOut() {
            return "RULED_OUT".equalsIgnoreCase(diagnosisStatus);
        }

        public boolean isRoutine() {
            return "ROUTINE".equalsIgnoreCase(clinicalPriority);
        }

        public boolean isUrgent() {
            return "URGENT".equalsIgnoreCase(clinicalPriority);
        }

        public boolean isEmergency() {
            return "EMERGENCY".equalsIgnoreCase(clinicalPriority)
                    || "CRITICAL".equalsIgnoreCase(clinicalPriority);
        }

        public boolean isCritical() {
            return "CRITICAL".equalsIgnoreCase(clinicalPriority);
        }

        public boolean requiresFollowup() {
            return Boolean.TRUE.equals(followupRequired);
        }

        public boolean isFollowupOverdue() {
            return requiresFollowup()
                    && followupAt != null
                    && followupAt.isBefore(LocalDateTime.now());
        }

        public boolean isSignedOff() {
            return veterinarySignoffAt != null;
        }

        public boolean hasMedicalEvidence() {
            return medicalEvidenceRef != null
                    && !medicalEvidenceRef.isBlank();
        }

        @Override
        public String toString() {
            return "MedicalCondition{" +
                    "conditionID=" + conditionID +
                    ", animalId=" + animalId +
                    ", conditionName='" + conditionName + '\'' +
                    ", status='" + status + '\'' +
                    ", diagnosisStatus='" + diagnosisStatus + '\'' +
                    ", chronic=" + chronic +
                    ", clinicalPriority='" + clinicalPriority + '\'' +
                    ", diagnosisDate=" + diagnosisDate +
                    '}';
        }
    }
}
