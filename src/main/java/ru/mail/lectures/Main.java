package ru.mail.lectures;

import org.flywaydb.core.Flyway;

import java.util.NoSuchElementException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        String url="";
        String user="";
        String password="";
        try (Scanner scanner = new Scanner(System.in)) {
            System.out.println("Enter DataBase URL");
            url = scanner.nextLine();
            System.out.println("Enter user name");
            user = scanner.nextLine();
            System.out.println("Enter password");
            password=scanner.nextLine();
        } catch (IllegalStateException | NoSuchElementException e) {
            System.out.println(e);
        }

        final Flyway flyway=Flyway.configure().dataSource(url,user ,password )
                .locations("db")
                .load();
        flyway.clean();
        flyway.migrate();
    }
}
