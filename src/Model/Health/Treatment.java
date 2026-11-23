
package Model.Health;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Treatment {

    // Basic information
    private long treatmentId;
    private long animalId;
    private long veterinarianId;
    private long medicalRecordId;
    private long createdByUserId;

    // Treatment details
    private String treatmentName;
    private String treatmentType;
    private String description;
    private String diagnosis;
    private String medication;
    private String dosage;
    private String frequency;
    private String administrationRoute;
    private String instructions;
    private String status;
    private String notes;
    private String outcome;
    private String sideEffects;

    // Dates
    private LocalDate startDate;
    private LocalDate endDate;
    private LocalDate nextReviewDate;
    private LocalDate completedDate;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Cost
    private BigDecimal cost;

    // Empty constructor
    public Treatment() {
    }

    // Constructor
    public Treatment(long treatmentId, long animalId,
                     long veterinarianId, long medicalRecordId,
                     long createdByUserId, String treatmentName,
                     String treatmentType, String description,
                     String diagnosis, String medication,
                     String dosage, String frequency,
                     String administrationRoute, String instructions,
                     String status, String notes, String outcome,
                     String sideEffects, LocalDate startDate,
                     LocalDate endDate, LocalDate nextReviewDate,
                     LocalDate completedDate, LocalDateTime createdAt,
                     LocalDateTime updatedAt, BigDecimal cost) {

        this.treatmentId = treatmentId;
        this.animalId = animalId;
        this.veterinarianId = veterinarianId;
        this.medicalRecordId = medicalRecordId;
        this.createdByUserId = createdByUserId;
        this.treatmentName = treatmentName;
        this.treatmentType = treatmentType;
        this.description = description;
        this.diagnosis = diagnosis;
        this.medication = medication;
        this.dosage = dosage;
        this.frequency = frequency;
        this.administrationRoute = administrationRoute;
        this.instructions = instructions;
        this.status = status;
        this.notes = notes;
        this.outcome = outcome;
        this.sideEffects = sideEffects;
        this.startDate = startDate;
        this.endDate = endDate;
        this.nextReviewDate = nextReviewDate;
        this.completedDate = completedDate;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.cost = cost;
    }

    // Getters and setters

    public long getTreatmentId() {
        return treatmentId;
    }

    public void setTreatmentId(long treatmentId) {
        this.treatmentId = treatmentId;
    }

    public long getAnimalId() {
        return animalId;
    }

    public void setAnimalId(long animalId) {
        this.animalId = animalId;
    }

    public long getVeterinarianId() {
        return veterinarianId;
    }

    public void setVeterinarianId(long veterinarianId) {
        this.veterinarianId = veterinarianId;
    }

    public long getMedicalRecordId() {
        return medicalRecordId;
    }

    public void setMedicalRecordId(long medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }

    public long getCreatedByUserId() {
        return createdByUserId;
    }

    public void setCreatedByUserId(long createdByUserId) {
        this.createdByUserId = createdByUserId;
    }

    public String getTreatmentName() {
        return treatmentName;
    }

    public void setTreatmentName(String treatmentName) {
        this.treatmentName = treatmentName;
    }

    public String getTreatmentType() {
        return treatmentType;
    }

    public void setTreatmentType(String treatmentType) {
        this.treatmentType = treatmentType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getMedication() {
        return medication;
    }

    public void setMedication(String medication) {
        this.medication = medication;
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

    public String getAdministrationRoute() {
        return administrationRoute;
    }

    public void setAdministrationRoute(String administrationRoute) {
        this.administrationRoute = administrationRoute;
    }

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
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

    public String getOutcome() {
        return outcome;
    }

    public void setOutcome(String outcome) {
        this.outcome = outcome;
    }

    public String getSideEffects() {
        return sideEffects;
    }

    public void setSideEffects(String sideEffects) {
        this.sideEffects = sideEffects;
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

    public LocalDate getNextReviewDate() {
        return nextReviewDate;
    }

    public void setNextReviewDate(LocalDate nextReviewDate) {
        this.nextReviewDate = nextReviewDate;
    }

    public LocalDate getCompletedDate() {
        return completedDate;
    }

    public void setCompletedDate(LocalDate completedDate) {
        this.completedDate = completedDate;
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

    public BigDecimal getCost() {
        return cost;
    }

    public void setCost(BigDecimal cost) {
        if (cost != null && cost.signum() < 0) {
            throw new IllegalArgumentException(
                    "Cost cannot be negative");
        }
        this.cost = cost;
    }

    // Business methods

    public boolean isActive() {
        return "ACTIVE".equals(status);
    }

    public boolean isCompleted() {
        return "COMPLETED".equals(status);
    }

    public boolean isCancelled() {
        return "CANCELLED".equals(status);
    }

    public boolean hasValidDates() {
        if (startDate == null) {
            return false;
        }

        return endDate == null || !endDate.isBefore(startDate);
    }

    public boolean needsReview() {
        if (nextReviewDate == null || !isActive()) {
            return false;
        }

        return !nextReviewDate.isAfter(LocalDate.now());
    }

    public void completeTreatment() {
        if (isCancelled()) {
            throw new IllegalStateException(
                    "A cancelled treatment cannot be completed");
        }

        this.status = "COMPLETED";
        this.completedDate = LocalDate.now();
        this.endDate = LocalDate.now();
        this.updatedAt = LocalDateTime.now();
    }

    public void cancelTreatment() {
        if (isCompleted()) {
            throw new IllegalStateException(
                    "A completed treatment cannot be cancelled");
        }

        this.status = "CANCELLED";
        this.updatedAt = LocalDateTime.now();
    }
}
