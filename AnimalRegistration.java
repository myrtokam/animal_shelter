public class AnimalRegistration {


    public static boolean registerAnimal(Animals animal, Animals [] animals, int AnimalId) {//Καταχωρίζει ένα νέο ζώο

        if (animal == null || animals == null) {
            return false;
        }

        for (int i = 0; i < animals.length; i++) {

            if (animals[i] == null) {
                animals[i] = animal;
                return true;
            }
        }

        return false;
    }

    public static Animals findAnimalById(Animals animals, Animals[] animal) {
        /*aναζητά ζώο με βάση το ID*/

        for (int i = 0; i < animal.length; i++) {
            if (animal[i] != null && animal[i].getAnimalId() == animals.getAnimalId()) {
                return animal[i];
            }
        }
        return null;
    }

    public static Animals findAnimalByMicrochip(Animals animals, Animals [] animal, int MicrochipNum) {
        //Αναζητά ζώο με βάση το microchip

        for (int i=0; i<animal.length; i++)
        {
            if(animal[i]!=null && animal[i].getMicrochipNumber().equals(animals.getMicrochipNumber()))
            {
                return animal[i];
            }
        }
        return null;
    }

    public static boolean updateAnimalDetails(Animals animals, Animals [] animal, String value) {
        //Ενημερώνει τα στοιχεία ζώου
        for (int i = 0; i < animal.length; i++) {

            if (animal[i] != null &&
                    animal[i].getAnimalId() == animals.getAnimalId()) {

                if (animals.getName() != null) {
                    animal[i].setName(animals.getName());
                }

                if (animals.getColor() != null) {
                    animal[i].setColor(animals.getColor());
                }
                if(animals.getSterilization_date()!=null){
                    animal[i].setSterilized(animals.isSterilized());
                }
                if(animals.getMicrochipNumber()!=null){
                    animal[i].setMicrochipNumber(animals.getMicrochipNumber());
                }
                if(animals.getSpecial_needs()!=null){
                    animal[i].setSpecial_needs(animals.getSpecial_needs());
                }
                if(animals.getDescription()!=null){
                    animal[i].setDescription(animals.getDescription());
                }

                return true;
            }
        }
        return false;
    }

    public static boolean isAnimalRegistered() {
        //Ελέγχει αν υπάρχει ήδη καταχώριση
        return false;
    }

    public static int countRegisteredAnimals(Animals animals, Animals [] animal, String value) {
        //	Μετρά τα καταχωρισμένα ζώα
        int count =0;
        for(int i=0; i<animal.length; i++)
        {
            if(animal[i]!=null){
                count++;
            }
        }
        return count;
    }
}
