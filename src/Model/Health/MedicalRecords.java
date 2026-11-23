
package Model.Health;

import java.time.LocalDateTime;

public class MedicalRecords {

    private long medicalRecordsId;
    private String name;
    private String description;
    private String status;
    private Long organizationId;
    private Long animalId;
    private Long primaryVeterinarianId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime recordOpenedAt;
    private LocalDateTime recordClosedAt;
    private LocalDateTime lastClinicalReviewAt;
    private LocalDateTime veterinarySignoffAt;
    private LocalDateTime observedAt;
    private String clinicalRecordNumber;
    private String clinicalSummary;
    private String activeProblemSummary;
    private String medicationSummary;
    private String allergySummary;
    private String clinicalConfidentialityLevel;
    private String medicalEvidenceRef;
    private String medicalCaseReference;
    private String clinicalContext;
    private String clinicalPriority;


    public MedicalRecords() {
    }

    public MedicalRecords(long medicalRecordsId, String name, String status, Long animalId) {

        this.medicalRecordsId = medicalRecordsId;
        this.name = name;
        this.status = status;
        this.animalId = animalId;
    }

    public long getMedicalRecordsId() {
        return medicalRecordsId;
    }

    public void setMedicalRecordsId(long medicalRecordsId) {
        this.medicalRecordsId = medicalRecordsId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public Long getOrganizationId() {
        return organizationId;
    }

    public void setOrganizationId(Long organizationId) {
        this.organizationId = organizationId;
    }

    public Long getAnimalId() {
        return animalId;
    }

    public void setAnimalId(Long animalId) {
        this.animalId = animalId;
    }

    public Long getPrimaryVeterinarianId() {
        return primaryVeterinarianId;
    }

    public void setPrimaryVeterinarianId(Long primaryVeterinarianId) {
        this.primaryVeterinarianId = primaryVeterinarianId;
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

    public LocalDateTime getRecordOpenedAt() {
        return recordOpenedAt;
    }

    public void setRecordOpenedAt(LocalDateTime recordOpenedAt) {
        this.recordOpenedAt = recordOpenedAt;
    }

    public LocalDateTime getRecordClosedAt() {
        return recordClosedAt;
    }

    public void setRecordClosedAt(LocalDateTime recordClosedAt) {
        this.recordClosedAt = recordClosedAt;
    }

    public LocalDateTime getLastClinicalReviewAt() {
        return lastClinicalReviewAt;
    }

    public void setLastClinicalReviewAt(LocalDateTime lastClinicalReviewAt) {
        this.lastClinicalReviewAt = lastClinicalReviewAt;
    }

    public LocalDateTime getVeterinarySignoffAt() {
        return veterinarySignoffAt;
    }

    public void setVeterinarySignoffAt(LocalDateTime veterinarySignoffAt) {
        this.veterinarySignoffAt = veterinarySignoffAt;
    }

    public LocalDateTime getObservedAt() {
        return observedAt;
    }

    public void setObservedAt(LocalDateTime observedAt) {
        this.observedAt = observedAt;
    }

    public String getClinicalRecordNumber() {
        return clinicalRecordNumber;
    }

    public void setClinicalRecordNumber(String clinicalRecordNumber) {
        this.clinicalRecordNumber = clinicalRecordNumber;
    }

    public String getClinicalSummary() {
        return clinicalSummary;
    }

    public void setClinicalSummary(String clinicalSummary) {
        this.clinicalSummary = clinicalSummary;
    }

    public String getActiveProblemSummary() {
        return activeProblemSummary;
    }

    public void setActiveProblemSummary(String activeProblemSummary) {
        this.activeProblemSummary = activeProblemSummary;
    }

    public String getMedicationSummary() {
        return medicationSummary;
    }

    public void setMedicationSummary(String medicationSummary) {
        this.medicationSummary = medicationSummary;
    }

    public String getAllergySummary() {
        return allergySummary;
    }

    public void setAllergySummary(String allergySummary) {
        this.allergySummary = allergySummary;
    }

    public String getClinicalConfidentialityLevel() {
        return clinicalConfidentialityLevel;
    }

    public void setClinicalConfidentialityLevel(String clinicalConfidentialityLevel) {

        this.clinicalConfidentialityLevel =
                clinicalConfidentialityLevel;
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

    public boolean isClosed() {
        return "CLOSED".equals(status);
    }

    @Override
    public String toString() {
        return "MedicalRecords{" +
                "medicalRecordsId=" + medicalRecordsId + ", name='" + name + '\'' + ", status='" + status + '\'' + ", animalId=" + animalId + '}';
    }
}
