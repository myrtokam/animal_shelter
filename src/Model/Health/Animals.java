package Model.Health;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Animals {

    private long animalId;
    private String microchipNumber;
    private String name;
    private long speciesId;
    private long breedId;
    private long organizationId;
    private String sex;
    private boolean sterilized;
    private LocalDate dateOfBirth;
    private LocalDate estimatedBirthDate;
    private String color;
    private double weight;
    private LocalDate sterilizationDate;
    private LocalDate intakeDate;
    private LocalDate foundDate;
    private LocalDate deathDate;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String description;
    private String specialNeedsSummary;


    public Animals() {
    }

    public Animals(String name, long speciesId, long breedId, long organizationId, String sex) {

        this.name = name;
        this.speciesId = speciesId;
        this.breedId = breedId;
        this.organizationId = organizationId;
        this.sex = sex;
    }

    public static int countAnimalsBySpecies(Animals[] animals, long speciesId) {

        int count = 0;

        for (Animals animal : animals) {
            if (animal != null &&
                    animal.getSpeciesId() == speciesId) {
                count++;
            }
        }

        return count;
    }

    public static int countSterilizedAnimals(Animals[] animals) {
        int count = 0;

        for (Animals animal : animals) {
            if (animal != null && animal.isSterilized()) {
                count++;
            }
        }

        return count;
    }

    public static Animals findHeaviestAnimal(Animals[] animals) {

        Animals heaviest = null;

        for (Animals animal : animals) {

            if (animal == null) {
                continue;
            }

            if (heaviest == null ||
                    animal.getWeight() > heaviest.getWeight()) {

                heaviest = animal;
            }
        }

        return heaviest;
    }

    public static Animals searchAnimal(Animals[] animals, String name) {

        if (name == null) {
            return null;
        }

        for (Animals animal : animals) {

            if (animal != null &&
                    name.equalsIgnoreCase(animal.getName())) {

                return animal;
            }
        }

        return null;
    }

    public static boolean registerAnimal(Animals animal, Animals[] animalsArray) {

        if (animal == null) {
            return false;
        }

        for (int i = 0; i < animalsArray.length; i++) {

            if (animalsArray[i] == null) {
                animalsArray[i] = animal;
                return true;
            }
        }

        return false;
    }

    public static boolean updateAnimal(double weight, String name, Animals[] animalsArray) {

        Animals animal = searchAnimal(animalsArray, name);

        if (animal == null) {
            return false;
        }

        animal.setWeight(weight);
        return true;
    }

    public static int countAnimals(Animals[] animals) {

        int count = 0;

        for (Animals animal : animals) {
            if (animal != null) {
                count++;
            }
        }

        return count;
    }

    public static Animals getAnimalById(Animals[] animals, long animalId) {

        for (Animals animal : animals) {
            if (animal != null &&
                    animal.getAnimalId() == animalId) {

                return animal;
            }
        }
        return null;
    }

    public static double calculateAverageWeight(Animals[] animals) {

        double sum = 0;
        int count = 0;

        for (Animals animal : animals) {

            if (animal != null) {
                sum += animal.getWeight();
                count++;
            }
        }

        if (count == 0) {
            return 0;
        }

        return sum / count;
    }

    public long getAnimalId() {
        return animalId;
    }

    public void setAnimalId(long animalId) {
        this.animalId = animalId;
    }

    public String getMicrochipNumber() {
        return microchipNumber;
    }

    public void setMicrochipNumber(String microchipNumber) {
        this.microchipNumber = microchipNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getSpeciesId() {
        return speciesId;
    }

    public void setSpeciesId(long speciesId) {
        this.speciesId = speciesId;
    }

    public long getBreedId() {
        return breedId;
    }

    public void setBreedId(long breedId) {
        this.breedId = breedId;
    }

    public long getOrganizationId() {
        return organizationId;
    }

    public void setOrganizationId(long organizationId) {
        this.organizationId = organizationId;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public boolean isSterilized() {
        return sterilized;
    }

    public void setSterilized(boolean sterilized) {
        this.sterilized = sterilized;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public LocalDate getEstimatedBirthDate() {
        return estimatedBirthDate;
    }

    public void setEstimatedBirthDate(LocalDate estimatedBirthDate) {
        this.estimatedBirthDate = estimatedBirthDate;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public LocalDate getSterilizationDate() {
        return sterilizationDate;
    }

    public void setSterilizationDate(LocalDate sterilizationDate) {
        this.sterilizationDate = sterilizationDate;
    }

    public LocalDate getIntakeDate() {
        return intakeDate;
    }

    public void setIntakeDate(LocalDate intakeDate) {
        this.intakeDate = intakeDate;
    }

    public LocalDate getFoundDate() {
        return foundDate;
    }

    public void setFoundDate(LocalDate foundDate) {
        this.foundDate = foundDate;
    }

    public LocalDate getDeathDate() {
        return deathDate;
    }

    public void setDeathDate(LocalDate deathDate) {
        this.deathDate = deathDate;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSpecialNeedsSummary() {
        return specialNeedsSummary;
    }

    public void setSpecialNeedsSummary(String specialNeedsSummary) {
        this.specialNeedsSummary = specialNeedsSummary;
    }

}
