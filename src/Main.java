//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.

import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {
        new DatabaseConnection();
        Animals Animals = new Animals();
        Animals.setName("Rex");
        Animals.setWeight((double)25.5F);
        AnimalDAO animalDAO = new AnimalDAO();
    }
}


