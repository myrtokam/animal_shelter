
package Model.Health;

import java.time.LocalDateTime;

public class Appoitment_types {

    // IDENTIFICATION

    private long appointmentTypeId;

    private String name;
    private String description;
    private String status;


    // AUDIT INFORMATION

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Long recordedByUserId;
    private Long verifiedByUserId;

    private LocalDateTime verifiedAt;
    private LocalDateTime reviewDueAt;

    private String recordReference;
    private String recordSource;


    // CONSTRUCTORS

    public Appoitment_types() {
    }

    public Appoitment_types(
            long appointmentTypeId,
            String name,
            String description,
            String status) {

        this.appointmentTypeId = appointmentTypeId;
        this.name = name;
        this.description = description;
        this.status = status;
    }


    // GETTERS AND SETTERS

    public long getAppointmentTypeId() {
        return appointmentTypeId;
    }

    public void setAppointmentTypeId(long appointmentTypeId) {
        this.appointmentTypeId = appointmentTypeId;
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

    public Long getRecordedByUserId() {
        return recordedByUserId;
    }

    public void setRecordedByUserId(Long recordedByUserId) {
        this.recordedByUserId = recordedByUserId;
    }

    public Long getVerifiedByUserId() {
        return verifiedByUserId;
    }

    public void setVerifiedByUserId(Long verifiedByUserId) {
        this.verifiedByUserId = verifiedByUserId;
    }

    public LocalDateTime getVerifiedAt() {
        return verifiedAt;
    }

    public void setVerifiedAt(LocalDateTime verifiedAt) {
        this.verifiedAt = verifiedAt;
    }

    public LocalDateTime getReviewDueAt() {
        return reviewDueAt;
    }

    public void setReviewDueAt(LocalDateTime reviewDueAt) {
        this.reviewDueAt = reviewDueAt;
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


    // BUSINESS LOGIC

    public boolean isActive() {
        return "ACTIVE".equalsIgnoreCase(status);
    }

    public boolean isInactive() {
        return "INACTIVE".equalsIgnoreCase(status);
    }

    public boolean isVerified() {
        return verifiedByUserId != null
                && verifiedAt != null;
    }

    public boolean isValidType() {
        return name != null && !name.isBlank();
    }


    // TO STRING

    @Override
    public String toString() {

        return appointmentTypeId + " | "
                + name + " | "
                + description + " | "
                + status;
    }
}
