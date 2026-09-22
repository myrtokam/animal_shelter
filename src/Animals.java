import java.sql.Date;
import java.util.Scanner;

public class Animals {
    private int animalId;
    private String microchipNumber;
    private String name;
    private int speciesId;
    private int breedId;
    private String sex_id;
    private Date date_of_birth;
    private Date estimated_birth_date;
    private String color;
    private double weight;
    private int status_id;
    private boolean sterilized;
    private Date sterilization_date;
    private Date intake_date;
    private Date found_date;
    private Date death_date;
    private Date created_at;
    private Date updated_at; 
    private String description;
    private String AnimalStatus;

    public static void searchAnimal(Animals[] animalsArray, String name) {
        for (int i = 0; i < animalsArray.length; i++) {

            if (animalsArray[i].getName().equals(name)) {
                System.out.println(animalsArray[i]);
            }
        }
    }
    private Boolean special_needs;

    static Scanner sc = new Scanner(System.in);
    Animals[] animalsArray = new Animals[10000];

    public static boolean registerAnimal(Animals animals) {
        return false;
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

    public static int countAnimals(Animals animals, int speciesId) {
        if (Animals.getAllAnimals(Animals[]Animals)

        {

        }
    }

    public static int countAnimalsBySpecies() {
        return 0;
    }

    public static int countSterilizedAnimals(Animals animals) {
        return 0;
    }

    public static void indHeaviestAnimal(Animals animals) {
    }

    public String getAnimalById(String[] animalsArray, String animalId) {

        for (int i = 0; i < animalsArray.length; i++) {
            if (!animalsArray[i].contains(animalId)) {
                return null;
            }
            return animalId;
        }
        return animalId;
    }

    public static double calculateAverageWeight(Animals animals) {
        return 0;
    }

    public static Animals getAllAnimals(Animals[] animals) {
        for (int i = 0; i <= animals.length; i++) {
            if (animals[i] != null) {
                return animals[i];
            } else {
                System.out.println("Δεν υπάρχουν διαθέσιμες καταγραφές...!");
            }
        }

        return getAllAnimals(animals);

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
