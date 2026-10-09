//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.

public class Main {
    static void main(String[] args) {
        new DatabaseConnection();
        Animals Animals = new Animals();
        Animals[] animalsArray = new Animals[10000];
        for (int i = 0; i < animalsArray.length; i++) {
            if (animalsArray[i] != null) {
                System.out.println("Δεν υπαρχουν ελεύθερες θέσεις για άλλες καταχωρήσεις...! ");
                break;
            } else {
                continue;
            }
        }
        Animals.setName("Rex");
        Animals.setWeight(25.5F);
        AnimalDAO animalDAO = new AnimalDAO();

    }
}


