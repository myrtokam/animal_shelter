
package Model;

public class AnimalRegistration {

    // Καταχωρίζει ένα νέο ζώο στο array.
    public static boolean registerAnimal(Animals animal, Animals[] animals) {

        if (animal == null || animals == null) {
            return false;
        }

        // Έλεγχος αν υπάρχει ήδη ζώο με το ίδιο ID.
        if (isAnimalRegistered(animals, animal.getAnimalId())) {
            return false;
        }

        // Έλεγχος διπλοεγγραφής με microchip.
        String microchip = animal.getMicrochipNumber();

        if (microchip != null &&
                findAnimalByMicrochip(animals, microchip) != null) {
            return false;
        }

        // Εύρεση της πρώτης κενής θέσης.
        for (int i = 0; i < animals.length; i++) {

            if (animals[i] == null) {
                animals[i] = animal;
                return true;
            }
        }

        return false;
    }

    // Αναζητά ζώο με βάση το ID.
    public static Animals findAnimalById(Animals[] animals, long animalId) {

        if (animals == null) {
            return null;
        }

        for (Animals animal : animals) {

            if (animal != null &&
                    animal.getAnimalId() == animalId) {

                return animal;
            }
        }

        return null;
    }

    // Αναζητά ζώο με βάση το microchip.
    public static Animals findAnimalByMicrochip(Animals[] animals, String microchipNumber) {

        if (animals == null || microchipNumber == null) {
            return null;
        }

        for (Animals animal : animals) {

            if (animal != null &&
                    microchipNumber.equals(animal.getMicrochipNumber())) {

                return animal;
            }
        }

        return null;
    }

    // Ενημερώνει τα στοιχεία ενός υπάρχοντος ζώου.
    public static boolean updateAnimalDetails(Animals updatedAnimal, Animals[] animals) {

        if (updatedAnimal == null || animals == null) {
            return false;
        }

        Animals existingAnimal = findAnimalById(animals, updatedAnimal.getAnimalId());

        if (existingAnimal == null) {
            return false;
        }

        if (updatedAnimal.getName() != null) {
            existingAnimal.setName(updatedAnimal.getName());
        }

        if (updatedAnimal.getColor() != null) {
            existingAnimal.setColor(updatedAnimal.getColor());
        }

        if (updatedAnimal.getMicrochipNumber() != null) {

            Animals animalWithMicrochip = findAnimalByMicrochip(animals, updatedAnimal.getMicrochipNumber());

            // Δεν επιτρέπεται το ίδιο microchip σε διαφορετικά ζώα.
            if (animalWithMicrochip != null && animalWithMicrochip != existingAnimal) {
                return false;
            }

            existingAnimal.setMicrochipNumber(updatedAnimal.getMicrochipNumber());
        }

        if (updatedAnimal.getSpecialNeedsSummary() != null) {
            existingAnimal.setSpecialNeedsSummary(
                    updatedAnimal.getSpecialNeedsSummary()
            );
        }

        if (updatedAnimal.getDescription() != null) {
            existingAnimal.setDescription(updatedAnimal.getDescription());
        }

        return true;
    }

    // Ελέγχει αν υπάρχει ήδη ζώο με συγκεκριμένο ID.
    public static boolean isAnimalRegistered(Animals[] animals, long animalId) {

        return findAnimalById(animals, animalId) != null;
    }

    // Μετρά τα καταχωρισμένα ζώα.
    public static int countRegisteredAnimals(Animals[] animals) {

        if (animals == null) {
            return 0;
        }

        int count = 0;

        for (Animals animal : animals) {

            if (animal != null) {
                count++;
            }
        }

        return count;
    }
}
