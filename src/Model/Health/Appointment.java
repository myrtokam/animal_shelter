
package Model.Health;

import java.time.LocalDateTime;

public class Appointment {

    // IDENTIFICATION

    private long appointmentId;
    private Long organizationId;
    private Long animalId;
    private Long appointmentTypeId;
    private Long veterinarianId;


    // APPOINTMENT CLASSIFICATION

    private String appointmentTypeName;
    private String appointmentTypeDescription;
    private String bookingType;
    private String triageLevel;
    private String status;


    // DATE AND TIME

    private LocalDateTime startsAt;
    private LocalDateTime endsAt;
    private LocalDateTime serviceDatetime;
    private LocalDateTime checkinAt;
    private LocalDateTime checkoutAt;
    private LocalDateTime followupDueAt;


    // CLINICAL INFORMATION

    private String appointmentReason;
    private String clientInstructions;
    private String serviceOutcome;
    private String cancellationReason;
    private String notes;


    // RECORD INFORMATION

    private String billingReference;
    private String recordReference;
    private String recordSource;


    // AUDIT INFORMATION

    private Long recordedByUserId;
    private Long verifiedByUserId;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime verifiedAt;
    private LocalDateTime reviewDueAt;


    // CONSTRUCTORS

    public Appointment() {
    }

    public Appointment(
            long appointmentId,
            Long animalId,
            Long appointmentTypeId,
            Long veterinarianId,
            LocalDateTime startsAt,
            LocalDateTime endsAt,
            String bookingType,
            String triageLevel,
            String status) {

        this.appointmentId = appointmentId;
        this.animalId = animalId;
        this.appointmentTypeId = appointmentTypeId;
        this.veterinarianId = veterinarianId;
        this.startsAt = startsAt;
        this.endsAt = endsAt;
        this.bookingType = bookingType;
        this.triageLevel = triageLevel;
        this.status = status;
    }


    // LEGACY CONSTRUCTOR

    public Appointment(
            long appointmentId,
            LocalDateTime startsAt,
            LocalDateTime endsAt,
            String status,
            Long organizationId,
            Long animalId,
            Long appointmentTypeId,
            Long veterinarianId,
            LocalDateTime serviceDatetime,
            LocalDateTime checkinAt,
            LocalDateTime checkoutAt,
            String triageLevel,
            String appointmentReason,
            String clientInstructions,
            String serviceOutcome,
            LocalDateTime followupDueAt,
            String cancellationReason,
            LocalDateTime appointmentDate,
            String reason,
            String notes) {

        this.appointmentId = appointmentId;
        this.startsAt = startsAt != null
                ? startsAt : appointmentDate;
        this.endsAt = endsAt;
        this.status = status;
        this.organizationId = organizationId;
        this.animalId = animalId;
        this.appointmentTypeId = appointmentTypeId;
        this.veterinarianId = veterinarianId;
        this.serviceDatetime = serviceDatetime;
        this.checkinAt = checkinAt;
        this.checkoutAt = checkoutAt;
        this.triageLevel = triageLevel;
        this.appointmentReason = appointmentReason != null
                ? appointmentReason : reason;
        this.clientInstructions = clientInstructions;
        this.serviceOutcome = serviceOutcome;
        this.followupDueAt = followupDueAt;
        this.cancellationReason = cancellationReason;
        this.notes = notes;
    }


    // GETTERS AND SETTERS

    public long getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(long appointmentId) {
        this.appointmentId = appointmentId;
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

    public Long getAppointmentTypeId() {
        return appointmentTypeId;
    }

    public void setAppointmentTypeId(Long appointmentTypeId) {
        this.appointmentTypeId = appointmentTypeId;
    }

    public Long getVeterinarianId() {
        return veterinarianId;
    }

    public void setVeterinarianId(Long veterinarianId) {
        this.veterinarianId = veterinarianId;
    }

    public String getAppointmentTypeName() {
        return appointmentTypeName;
    }

    public void setAppointmentTypeName(String appointmentTypeName) {
        this.appointmentTypeName = appointmentTypeName;
    }

    public String getAppointmentTypeDescription() {
        return appointmentTypeDescription;
    }

    public void setAppointmentTypeDescription(
            String appointmentTypeDescription) {

        this.appointmentTypeDescription =
                appointmentTypeDescription;
    }

    public String getBookingType() {
        return bookingType;
    }

    public void setBookingType(String bookingType) {
        this.bookingType = bookingType;
    }

    public String getTriageLevel() {
        return triageLevel;
    }

    public void setTriageLevel(String triageLevel) {
        this.triageLevel = triageLevel;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getStartsAt() {
        return startsAt;
    }

    public void setStartsAt(LocalDateTime startsAt) {
        this.startsAt = startsAt;
    }

    public LocalDateTime getEndsAt() {
        return endsAt;
    }

    public void setEndsAt(LocalDateTime endsAt) {
        this.endsAt = endsAt;
    }

    public LocalDateTime getServiceDatetime() {
        return serviceDatetime;
    }

    public void setServiceDatetime(
            LocalDateTime serviceDatetime) {

        this.serviceDatetime = serviceDatetime;
    }

    public LocalDateTime getCheckinAt() {
        return checkinAt;
    }

    public void setCheckinAt(LocalDateTime checkinAt) {
        this.checkinAt = checkinAt;
    }

    public LocalDateTime getCheckoutAt() {
        return checkoutAt;
    }

    public void setCheckoutAt(LocalDateTime checkoutAt) {
        this.checkoutAt = checkoutAt;
    }

    public LocalDateTime getFollowupDueAt() {
        return followupDueAt;
    }

    public void setFollowupDueAt(LocalDateTime followupDueAt) {
        this.followupDueAt = followupDueAt;
    }

    public String getAppointmentReason() {
        return appointmentReason;
    }

    public void setAppointmentReason(String appointmentReason) {
        this.appointmentReason = appointmentReason;
    }

    public String getClientInstructions() {
        return clientInstructions;
    }

    public void setClientInstructions(String clientInstructions) {
        this.clientInstructions = clientInstructions;
    }

    public String getServiceOutcome() {
        return serviceOutcome;
    }

    public void setServiceOutcome(String serviceOutcome) {
        this.serviceOutcome = serviceOutcome;
    }

    public String getCancellationReason() {
        return cancellationReason;
    }

    public void setCancellationReason(String cancellationReason) {
        this.cancellationReason = cancellationReason;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getBillingReference() {
        return billingReference;
    }

    public void setBillingReference(String billingReference) {
        this.billingReference = billingReference;
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


    // BACKWARD COMPATIBILITY

    public LocalDateTime getAppointmentDate() {
        return startsAt;
    }

    public void setAppointmentDate(LocalDateTime appointmentDate) {
        this.startsAt = appointmentDate;
    }

    public String getReason() {
        return appointmentReason;
    }

    public void setReason(String reason) {
        this.appointmentReason = reason;
    }


    // BOOKING TYPE METHODS

    public boolean isScheduled() {
        return "SCHEDULED".equalsIgnoreCase(bookingType);
    }

    public boolean isWalkIn() {
        return "WALK_IN".equalsIgnoreCase(bookingType);
    }

    public boolean isUnscheduled() {
        return "UNSCHEDULED".equalsIgnoreCase(bookingType);
    }


    // TRIAGE METHODS

    public boolean isRoutine() {
        return "ROUTINE".equalsIgnoreCase(triageLevel);
    }

    public boolean isUrgent() {
        return "URGENT".equalsIgnoreCase(triageLevel);
    }

    public boolean isEmergency() {
        return "EMERGENCY".equalsIgnoreCase(triageLevel)
                || "CRITICAL".equalsIgnoreCase(triageLevel);
    }

    public boolean isCritical() {
        return "CRITICAL".equalsIgnoreCase(triageLevel);
    }


    // STATUS METHODS

    public boolean isPending() {
        return "PENDING".equalsIgnoreCase(status);
    }

    public boolean isCompleted() {
        return "COMPLETED".equalsIgnoreCase(status);
    }

    public boolean isCancelled() {
        return "CANCELLED".equalsIgnoreCase(status);
    }

    public boolean isActive() {
        return "ACTIVE".equalsIgnoreCase(status);
    }

    public boolean isInReview() {
        return "IN_REVIEW".equalsIgnoreCase(status);
    }

    public boolean hasScheduledStatus() {
        return "SCHEDULED".equalsIgnoreCase(status);
    }


    // APPOINTMENT TYPE METHODS

    public boolean isGeneralConsultation() {
        return "General Consultation"
                .equalsIgnoreCase(appointmentTypeName);
    }

    public boolean isSurgery() {
        return "Surgery".equalsIgnoreCase(appointmentTypeName);
    }

    public boolean isHospitalization() {
        return "Hospitalization"
                .equalsIgnoreCase(appointmentTypeName);
    }

    public boolean isFollowUp() {
        return "Follow-up Examination"
                .equalsIgnoreCase(appointmentTypeName);
    }

    public boolean isVaccination() {
        return "Vaccination"
                .equalsIgnoreCase(appointmentTypeName);
    }

    public boolean isSterilization() {
        return "Sterilization"
                .equalsIgnoreCase(appointmentTypeName);
    }

    public boolean isDiagnosticExamination() {
        return "Diagnostic Examination"
                .equalsIgnoreCase(appointmentTypeName);
    }

    public boolean isEmergencySurgery() {
        return isSurgery() && isEmergency();
    }

    public boolean isScheduledSurgery() {
        return isSurgery() && isScheduled();
    }


    // VALIDATION METHODS

    public boolean hasValidDates() {
        return startsAt != null
                && endsAt != null
                && endsAt.isAfter(startsAt);
    }

    public boolean hasCheckedIn() {
        return checkinAt != null;
    }

    public boolean hasCheckedOut() {
        return checkoutAt != null;
    }

    public boolean requiresFollowUp() {
        return followupDueAt != null;
    }

    public boolean isFollowUpOverdue() {
        return followupDueAt != null
                && followupDueAt.isBefore(LocalDateTime.now());
    }

    public boolean isVerified() {
        return verifiedByUserId != null
                && verifiedAt != null;
    }


    // TO STRING

    @Override
    public String toString() {

        return "Appointment ID: " + appointmentId
                + " | Animal ID: " + animalId
                + " | Type: " + appointmentTypeName
                + " | Booking: " + bookingType
                + " | Triage: " + triageLevel
                + " | Status: " + status
                + " | Starts: " + startsAt
                + " | Ends: " + endsAt;
    }
}
