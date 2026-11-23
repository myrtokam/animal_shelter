
package Model.Health;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Medication {

    // Medication information
    private long medicationId;
    private String medicationName;
    private String activeIngredient;
    private String form;
    private String strength;

    // Animal medication information
    private Long animalId;
    private String dosage;
    private String frequency;
    private LocalDate startDate;
    private LocalDate endDate;
    private String prescribedBy;
    private String status;
    private String notes;

    // Schedule information
    private Long medicationScheduleId;
    private LocalDateTime scheduledAt;
    private BigDecimal scheduledDoseAmount;
    private String doseUnit;

    // Administration information
    private Long medicationAdministrationId;
    private LocalDateTime administeredAt;
    private BigDecimal administeredDoseAmount;
    private String administrationOutcome;

    // Administration details
    private Long administrationDetailId;
    private BigDecimal actualDose;
    private Long dosageUnitId;
    private Long administrationRouteId;
    private String batchNumber;
    private String administeredByName;
    private String missedReason;
    private String adverseEventNotes;

    // Audit information
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Empty constructor
    public Medication() {
    }

    // Constructor for medication catalog
    public Medication(long medicationId,
                      String medicationName,
                      String activeIngredient,
                      String form,
                      String strength) {

        setMedicationId(medicationId);
        setMedicationName(medicationName);
        this.activeIngredient = activeIngredient;
        this.form = form;
        this.strength = strength;
    }

    // Constructor for an animal medication
    public Medication(long medicationId,
                      Long animalId,
                      String medicationName,
                      String dosage,
                      String frequency,
                      LocalDate startDate,
                      LocalDate endDate,
                      String prescribedBy,
                      String status,
                      String notes) {

        setMedicationId(medicationId);
        this.animalId = animalId;
        setMedicationName(medicationName);
        this.dosage = dosage;
        this.frequency = frequency;
        setStartDate(startDate);
        setEndDate(endDate);
        this.prescribedBy = prescribedBy;
        this.status = status;
        this.notes = notes;
    }

    // Getters and setters

    public long getMedicationId() {
        return medicationId;
    }

    public void setMedicationId(long medicationId) {
        if (medicationId < 0) {
            throw new IllegalArgumentException(
                    "Medication ID cannot be negative"
            );
        }
        this.medicationId = medicationId;
    }

    public String getMedicationName() {
        return medicationName;
    }

    public void setMedicationName(String medicationName) {
        if (medicationName == null ||
                medicationName.isBlank()) {
            throw new IllegalArgumentException(
                    "Medication name is required"
            );
        }
        this.medicationName = medicationName;
    }

    public String getActiveIngredient() {
        return activeIngredient;
    }

    public void setActiveIngredient(String activeIngredient) {
        this.activeIngredient = activeIngredient;
    }

    public String getForm() {
        return form;
    }

    public void setForm(String form) {
        this.form = form;
    }

    public String getStrength() {
        return strength;
    }

    public void setStrength(String strength) {
        this.strength = strength;
    }

    public Long getAnimalId() {
        return animalId;
    }

    public void setAnimalId(Long animalId) {
        this.animalId = animalId;
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
        if (startDate != null &&
                endDate != null &&
                startDate.isAfter(endDate)) {
            throw new IllegalArgumentException(
                    "Start date cannot be after end date"
            );
        }
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        if (endDate != null &&
                startDate != null &&
                endDate.isBefore(startDate)) {
            throw new IllegalArgumentException(
                    "End date cannot be before start date"
            );
        }
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

    public Long getMedicationScheduleId() {
        return medicationScheduleId;
    }

    public void setMedicationScheduleId(Long medicationScheduleId) {
        this.medicationScheduleId = medicationScheduleId;
    }

    public LocalDateTime getScheduledAt() {
        return scheduledAt;
    }

    public void setScheduledAt(LocalDateTime scheduledAt) {
        this.scheduledAt = scheduledAt;
    }

    public BigDecimal getScheduledDoseAmount() {
        return scheduledDoseAmount;
    }

    public void setScheduledDoseAmount(BigDecimal scheduledDoseAmount) {
        validateDose(scheduledDoseAmount);
        this.scheduledDoseAmount = scheduledDoseAmount;
    }

    public String getDoseUnit() {
        return doseUnit;
    }

    public void setDoseUnit(String doseUnit) {
        this.doseUnit = doseUnit;
    }

    public Long getMedicationAdministrationId() {
        return medicationAdministrationId;
    }

    public void setMedicationAdministrationId(
            Long medicationAdministrationId) {
        this.medicationAdministrationId = medicationAdministrationId;
    }

    public LocalDateTime getAdministeredAt() {
        return administeredAt;
    }

    public void setAdministeredAt(LocalDateTime administeredAt) {
        this.administeredAt = administeredAt;
    }

    public BigDecimal getAdministeredDoseAmount() {
        return administeredDoseAmount;
    }

    public void setAdministeredDoseAmount(
            BigDecimal administeredDoseAmount) {
        validateDose(administeredDoseAmount);
        this.administeredDoseAmount = administeredDoseAmount;
    }

    public String getAdministrationOutcome() {
        return administrationOutcome;
    }

    public void setAdministrationOutcome(
            String administrationOutcome) {
        this.administrationOutcome = administrationOutcome;
    }

    public Long getAdministrationDetailId() {
        return administrationDetailId;
    }

    public void setAdministrationDetailId(
            Long administrationDetailId) {
        this.administrationDetailId = administrationDetailId;
    }

    public BigDecimal getActualDose() {
        return actualDose;
    }

    public void setActualDose(BigDecimal actualDose) {
        validateDose(actualDose);
        this.actualDose = actualDose;
    }

    public Long getDosageUnitId() {
        return dosageUnitId;
    }

    public void setDosageUnitId(Long dosageUnitId) {
        this.dosageUnitId = dosageUnitId;
    }

    public Long getAdministrationRouteId() {
        return administrationRouteId;
    }

    public void setAdministrationRouteId(
            Long administrationRouteId) {
        this.administrationRouteId = administrationRouteId;
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }

    public String getAdministeredByName() {
        return administeredByName;
    }

    public void setAdministeredByName(String administeredByName) {
        this.administeredByName = administeredByName;
    }

    public String getMissedReason() {
        return missedReason;
    }

    public void setMissedReason(String missedReason) {
        this.missedReason = missedReason;
    }

    public String getAdverseEventNotes() {
        return adverseEventNotes;
    }

    public void setAdverseEventNotes(String adverseEventNotes) {
        this.adverseEventNotes = adverseEventNotes;
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

    // Business methods

    public boolean isActive() {
        return "ACTIVE".equalsIgnoreCase(status);
    }

    public boolean isCompleted() {
        return "COMPLETED".equalsIgnoreCase(status);
    }

    public boolean isCancelled() {
        return "CANCELLED".equalsIgnoreCase(status);
    }

    public boolean hasValidDates() {
        return startDate != null &&
                (endDate == null ||
                        !endDate.isBefore(startDate));
    }

    public boolean isScheduled() {
        return scheduledAt != null;
    }

    public boolean hasBeenAdministered() {
        return administeredAt != null;
    }

    public boolean hasAdverseEvent() {
        return adverseEventNotes != null &&
                !adverseEventNotes.isBlank();
    }

    public void completeMedication() {
        if (isCancelled()) {
            throw new IllegalStateException(
                    "A cancelled medication course cannot be completed"
            );
        }

        if (isCompleted()) {
            throw new IllegalStateException(
                    "Medication course is already completed"
            );
        }

        this.status = "COMPLETED";
        this.endDate = LocalDate.now();
        this.updatedAt = LocalDateTime.now();
    }

    public void cancelMedication() {
        if (isCompleted()) {
            throw new IllegalStateException(
                    "A completed medication course cannot be cancelled"
            );
        }

        if (isCancelled()) {
            throw new IllegalStateException(
                    "Medication course is already cancelled"
            );
        }

        this.status = "CANCELLED";
        this.updatedAt = LocalDateTime.now();
    }

    public boolean isValidMedication() {
        return medicationName != null &&
                !medicationName.isBlank() &&
                medicationId >= 0;
    }

    private void validateDose(BigDecimal dose) {
        if (dose != null && dose.signum() < 0) {
            throw new IllegalArgumentException(
                    "Dose cannot be negative"
            );
        }
    }
}
