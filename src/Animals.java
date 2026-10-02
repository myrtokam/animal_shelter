import java.sql.Date;
import java.text.ParseException;

public class Animals {

    private int animalId;
    private String microchipNumber;
    private String name;
    private int speciesId;
    private int breedId;
    private String sex_id;
    private double heaviestAnimal;
    private boolean sterilized;

    public Animals(boolean sterilizedAnimal) {
        sterilized = sterilizedAnimal;
    }

    public Animals(double heaviestAnimal) {
        this.heaviestAnimal = heaviestAnimal;
    }
    private Date date_of_birth;
    private Date estimated_birth_date;
    private String color;
    private double weight;
    private int status_id;
    private Date sterilization_date;
    private Date intake_date;
    private Date found_date;
    private Date death_date;
    private Date created_at;
    private Date updated_at; 
    private String description;
    private String AnimalStatus;
    private Boolean special_needs;
    Animals[] animalsArray = new Animals[1000000];

    public static int countAnimalsBySpecies(Animals[] animals, int speciesId) {
        int countAnimlas = 0;
        for (int i = 0; i < animals.length; i++) {
            if (animals[i] != null && animals[i].getSpeciesId() == speciesId) {
                countAnimlas++;
            }
        }
        return countAnimlas;
    }

    public static int countSterilizedAnimals(Animals[] animals) {
        int countSterilizedAnimals = 0;
        for (int i = 0; i < animals.length; i++) {
            if (animals[i] != null && animals[i].isSterilized()) {
                countSterilizedAnimals++;
            }
        }
        return countSterilizedAnimals;
    }

    public static String findHeaviestAnimal(Animals[] animals, double weight, String heaviestAninal) {

        for (int i = 0; i < animals.length; i++) {
            if (animals[i] != null) {
                double animalweight = animals[i].getWeight();
                if (animalweight >= weight) {
                    weight = animalweight;
                    heaviestAninal = animals[i].getName();
                }
            }
        }
        return heaviestAninal;
    }

    public static String searchAnimal(Animals[] animals, String name) {

        for (int i = 0; i < animals.length; i++) {
            if (animals[i] != null) {
                if (animals[i].getName().equals(name)) {
                    return name;
                }
            }
        }
        return null;
    }

    public static boolean registerAnimal(Animals animals, Animals[] animalsArray) {

        for (int i = 0; i < animalsArray.length; i++) {
            if (animalsArray[i] == null) {
                animalsArray[i] = animals;
                return true;
            }
        }
        return false;
    }

    public boolean isSterilizedAnimal(Animals animals) {
        return animals.isSterilized();
    }

    public static boolean updateAnimal(double weight, String name, Animals[] animalsArray) {

        for (int i = 0; i < animalsArray.length; i++) {

            if (animalsArray[i] != null) {
                if (animalsArray[i].getName().equals(name)) {
                    animalsArray[i].setWeight(weight);
                    return true;
                }
            }
        }
        return false;
    }

    public static boolean changeAnimalStatus(Animals animals, int status_id) {

        if (status_id >= 1 && status_id <= 31) {
            animals.setStatus_id(status_id);
            return true;

        } else {
            return false;
        }
    }

    public String getAnimalStatus() {
        return AnimalStatus;
    }

    public void setSterilizedAnimal(boolean sterilizedAnimal) {
        sterilized = sterilizedAnimal;
    }

    public void setHeaviestAnimal(double heaviestAnimal) {
        this.heaviestAnimal = heaviestAnimal;
    }

    public int countAnimals(Animals[] animals) {

        int countAnimals = 0;

        for (int i = 0; i < animals.length; i++)
        {
            if (animals[i] != null) {
                countAnimals++;
            }
        }
        return countAnimals;
    }

    public Animals getAnimalById(Animals[] animals, int animalId) {

        for (int i = 0; i < animals.length; i++) {

            if (animals[i] != null &&
                    animals[i].getAnimalId() == animalId) {
                return animals[i];
            }
        }
        return null;
    }

    public static double calculateAverageWeight(Animals[] animals) {

        double avg = 0, counter = 0, sum = 0, weight = 0;

        for (int i = 0; i < animals.length; i++) {

            if (animals[i] != null) {
                counter++;
                weight = animals[i].getWeight();
                sum += weight;
            }
        }

        if (counter == 0) {
            return 0;
        }

        avg = sum / counter;
        return avg;
    }

    public Animals() {
    }

    public int getAnimalId() {
        return this.animalId;
    }

    public void setAnimalId(int animalId) {
        this.animalId = animalId;
    }

    public String getMicrochipNumber() {
        return this.microchipNumber;
    }

    public void setMicrochipNumber(String microchipNumber) {
        this.microchipNumber = microchipNumber;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSpeciesId() {
        return this.speciesId;
    }

    public void setSpeciesId(int speciesId) {
        this.speciesId = speciesId;
    }

    public int getBreedId() {
        return this.breedId;
    }

    public void setBreedId(int breedId) {
        this.breedId = breedId;
    }

    public String getSex_id() {
        return this.sex_id;
    }

    public void setSex_id(String sex_id) {
        this.sex_id = sex_id;
    }

    public Date getDate_of_birth() {
        return this.date_of_birth;
    }

    public void setDate_of_birth(Date date_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    public Date getEstimated_birth_date() {
        return this.estimated_birth_date;
    }

    public void setEstimated_birth_date(Date estimated_birth_date) {
        this.estimated_birth_date = estimated_birth_date;
    }

    public String getColor() {
        return this.color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getWeight() {
        return this.weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }


    public int getStatus_id() {
        return this.status_id;
    }

    public void setStatus_id(int status_id) {
        this.status_id = status_id;
    }

    public boolean isSterilized() {
        return this.sterilized;
    }

    public void setSterilized(boolean sterilized) {
        this.sterilized = sterilized;
    }

    public Date getSterilization_date() {
        return this.sterilization_date;
    }

    public void setSterilization_date(Date sterilization_date) {
        this.sterilization_date = sterilization_date;
    }

    public Date getIntake_date() {
        return this.intake_date;
    }

    public void setIntake_date(Date intake_date) {
        this.intake_date = intake_date;
    }

    public Date getFound_date() {
        return this.found_date;
    }

    public void setFound_date(Date found_date) {
        this.found_date = found_date;
    }

    public Date getDeath_date() {
        return this.death_date;
    }

    public void setDeath_date(Date death_date) {
        this.death_date = death_date;
    }

    public Date getCreated_at() {
        return this.created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdated_at() {
        return this.updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getSpecial_needs() {
        return this.special_needs;
    }

    public void setSpecial_needs(Boolean special_needs) {
        this.special_needs = special_needs;
    }

    public Animals(int animalId, String microchipNumber, String name, int speciesId, int breedId, String sex_id, Date date_of_birth, Date estimated_birth_date, String color, double weight, int status_id, boolean sterilized, Date sterilization_date, Date intake_date, Date found_date, Date death_date, Date created_at, Date updated_at, String description, Boolean special_needs) {
        this.animalId = animalId;
        this.microchipNumber = microchipNumber;
        this.name = name;
        this.speciesId = speciesId;
        this.breedId = breedId;
        this.sex_id = sex_id;
        this.date_of_birth = date_of_birth;
        this.estimated_birth_date = estimated_birth_date;
        this.color = color;
        this.weight = weight;
        this.status_id = status_id;
        this.sterilized = sterilized;
        this.sterilization_date = sterilization_date;
        this.intake_date = intake_date;
        this.found_date = found_date;
        this.death_date = death_date;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.description = description;
        this.special_needs = special_needs;
    }
}
