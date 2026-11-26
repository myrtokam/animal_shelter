package Model.Health;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class MedicalCondition {

    private long conditionID;     // PRIMARY KEY
    private Long animalId;  // FOREIGN KEY
    private Long organizationId;// FOREIGN KEY
    private Long veterinarianId;// FOREIGN KEY
    private Long medicalRecordId;// FOREIGN KEY
    private Long recordedByUserId;// FOREIGN KEY
    private String conditionName;// BASIC CONDITION INFORMATION
    private String description; // BASIC CONDITION INFORMATION
    private String status;// BASIC CONDITION INFORMATION
    private String conditionCode;// BASIC CONDITION INFORMATION
    private String diagnosisStatus;// BASIC CONDITION INFORMATION
    private Boolean chronic;// BASIC CONDITION INFORMATION
    private String notes;// BASIC CONDITION INFORMATION
    private LocalDate diagnosisDate; // DATE
    private LocalDate onsetDate;  // DATE
    private LocalDateTime resolvedAt;  // DATE
    private LocalDateTime observedAt;  // DATE
    private String clinicalContext;   // CLINICAL INFORMATION
    private String clinicalPriority;   // CLINICAL INFORMATION
    private String clinicalFindings;   // CLINICAL INFORMATION
    private String clinicalAssessment;   // CLINICAL INFORMATION
    private String clinicalRecommendations;   // CLINICAL INFORMATION
    private String clinicalReviewStatus;   // CLINICAL INFORMATION
    private String clinicalSource;   // CLINICAL INFORMATION
    private Boolean followupRequired; // FOLLOW-UP INFORMATION
    private LocalDateTime followupAt;// FOLLOW-UP INFORMATION
    private LocalDateTime veterinarySignoffAt;   // MEDICAL DOCUMENTATION
    private String medicalEvidenceRef;   // MEDICAL DOCUMENTATION
    private String medicalCaseReference;   // MEDICAL DOCUMENTATION
    private String recordReference;  // AUDIT INFORMATION
    private String recordSource;  // AUDIT INFORMATION
    private LocalDateTime createdAt;  // AUDIT INFORMATION
    private LocalDateTime updatedAt;  // AUDIT INFORMATION


    // CONSTRUCTORS
    public MedicalCondition() {
    }

    public MedicalCondition(long conditionID, Long animalId, String conditionName, String description, String status, LocalDate diagnosisDate, Boolean chronic, String notes) {
        this.conditionID = conditionID;
        this.animalId = animalId;
        this.conditionName = conditionName;
        this.description = description;
        this.status = status;
        this.diagnosisDate = diagnosisDate;
        this.chronic = chronic;
        this.notes = notes;
    }


    // GETTERS AND SETTERS
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

    public void setClinicalRecommendations(String clinicalRecommendations) {
        this.clinicalRecommendations = clinicalRecommendations;
    }

    public String getClinicalReviewStatus() {
        return clinicalReviewStatus;
    }

    public void setClinicalReviewStatus(String clinicalReviewStatus) {
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

    public void setVeterinarySignoffAt(LocalDateTime veterinarySignoffAt) {
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

    public void setMedicalCaseReference(String medicalCaseReference) {
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

    // CONDITION STATUS
    public boolean isActive() {
        return "ACTIVE".equalsIgnoreCase(status);
    }

    public boolean isResolved() {
        return "RESOLVED".equalsIgnoreCase(status);
    }

    public boolean isRemission() {
        return "REMISSION".equalsIgnoreCase(status);
    }

    public boolean isRecurrent() {
        return "RECURRENT".equalsIgnoreCase(status);
    }

    public boolean isPending() {
        return "PENDING".equalsIgnoreCase(status);
    }

    public boolean isCompleted() {
        return "COMPLETED".equalsIgnoreCase(status);
    }

    public boolean isInReview() {
        return "IN_REVIEW".equalsIgnoreCase(status);
    }

    // CHRONIC CONDITION
    public boolean isChronic() {
        return Boolean.TRUE.equals(chronic);
    }

    public void setChronic(Boolean chronic) {
        this.chronic = chronic;
    }

    public boolean isChronicityUnknown() {
        return chronic == null;
    }

    // DIAGNOSIS STATUS METHODS
    public boolean isConfirmed() {
        return "CONFIRMED".equalsIgnoreCase(diagnosisStatus);
    }

    public boolean isSuspected() {
        return "SUSPECTED".equalsIgnoreCase(diagnosisStatus);
    }

    public boolean isRuledOut() {
        return "RULED_OUT".equalsIgnoreCase(diagnosisStatus);
    }


    // CLINICAL PRIORITY
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


    // FOLLOW-UP METHODS
    public boolean requiresFollowup() {
        return Boolean.TRUE.equals(followupRequired);
    }

    public boolean isFollowupOverdue() {
        return requiresFollowup()
                && followupAt != null
                && followupAt.isBefore(LocalDateTime.now());
    }


    // MEDICAL DOCUMENTATION METHODS
    public boolean isSignedOff() {
        return veterinarySignoffAt != null;
    }

    public boolean hasMedicalEvidence() {
        return medicalEvidenceRef != null
                && !medicalEvidenceRef.isBlank();
    }


    // TO STRING
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
