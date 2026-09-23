import 'dart:io';

import 'PhoneBook.dart';
import 'InputHandler.dart';

main() {
  PhoneBook phoneBook = PhoneBook();
  phoneBook.populateSampleContacts();

  String? choice;
  
  while (true) {
    stdout.write('\x1B[2J\x1B[H'); // clear the console screen

    print("=================== Welcome to the Phone Book Application ==================");
    print("0. Exit");
    print("1. Display all contacts");
    print("2. View contact details");
    print("3. Add a new contact");
    print("4. Search for a contact by name");
    print("5. Search for a contact by nickname");
  
    stdout.write("What would you like to do? (choose a number): ");
    choice = stdin.readLineSync();
  
    switch (choice) {
      case '0':
        print("\nExiting the application. Goodbye!\n");
        exit(0);
      case '1':
        phoneBook.displayContacts();
        break;
      case '2':
        phoneBook.displayContacts();

        int index = int.parse(getUserInput(
            prompt: "\nEnter the count number of the contact to view details (or 0 to exit): ", 
            isValid: (input) => input != null && int.tryParse(input) != null) ?? "0"
        )-1;
        
        if (index == -1) {
          print("\nExiting contact details view.");
          break;
        }
        phoneBook.viewContactDetails(index);

        choice = getUserInput(
          prompt: "\nWould you like to edit this contact? (y/n): ",
          isValid: (input) => input != null && (input.toLowerCase() == 'y' || input.toLowerCase() == 'n'),
          errorMessage: "Please enter 'y' or 'n'."
        );

        if (choice != null && choice.toLowerCase() == 'y') {
          String? name = getUserInput(
            prompt: "Enter the new name of the contact (or press Enter to keep it unchanged): ",
            isValid: (input) => input == null || input.isNotEmpty
          );

          String? phoneNumber = getUserInput(
            prompt: "Enter the new phone number of the contact (or press Enter to keep it unchanged): ",
            isValid: (input) => input == null || (input.isNotEmpty && input.contains(RegExp(r'^\+?[0-9\s\-\(\)]+$'))),
            errorMessage: "Please enter a valid phone number."
          );

          String? nickname = getUserInput(
            prompt: "Enter the new nickname of the contact (or press Enter to keep it unchanged): ",
            isValid: (input) => input == null || input.isNotEmpty
          );

          String? secondaryPhoneNumber = getUserInput(
            prompt: "Enter the new secondary phone number of the contact (or press Enter to keep it unchanged): ",
            isValid: (input) => input == null || (input.isNotEmpty && input.contains(RegExp(r'^\+?[0-9\s\-\(\)]+$'))),
            errorMessage: "Please enter a valid phone number."
          );

          String? email = getUserInput(
            prompt: "Enter the new email of the contact (or press Enter to keep it unchanged): ",
            isValid: (input) => input == null || (input.isNotEmpty && input.contains(RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'))),
            errorMessage: "Please enter a valid email."
          );

          String? notes = getUserInput(
            prompt: "Enter any new notes for the contact (or press Enter to keep it unchanged): ",
            isValid: (input) => input == null || input.isNotEmpty
          );
      
          if (phoneBook.updateContact(index: index, name: name, phoneNumber: phoneNumber, nickname: nickname, secondaryPhoneNumber: secondaryPhoneNumber, email: email, notes: notes)) {
            print("Contact updated successfully.");
          } 
          else {
            print("Failed to update contact.");
          }
        }
        break;
      case '3':
        String name = getUserInput(
          prompt: "Enter the name of the new contact: ",
          isValid: (input) => input != null,
          errorMessage: "Name cannot be empty."
        ) ?? "";
        
        String phoneNumber = getUserInput(
          prompt: "Enter the phone number of the new contact: ",
          isValid: (input) => input != null && input.isNotEmpty && input.contains(RegExp(r'^\+?[0-9\s\-\(\)]+$')),
          errorMessage: "Please enter a valid phone number."
        ) ?? "";
        
        String? nickname = getUserInput(
          prompt: "Enter the nickname of the new contact (optional): ",
          isValid: (input) => input == null || input.isNotEmpty
        );
        
        String? secondaryPhoneNumber = getUserInput(
          prompt: "Enter the secondary phone number of the new contact (optional): ",
          isValid: (input) => input == null || (input.isNotEmpty && input.contains(RegExp(r'^\+?[0-9\s\-\(\)]+$'))),
          errorMessage: "Please enter a valid phone number."
        );
        
        String? email = getUserInput(
          prompt: "Enter the email of the new contact (optional): ",
          isValid: (input) => input == null || (input.isNotEmpty && input.contains(RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'))),
          errorMessage: "Please enter a valid email."
        );
        
        String? notes = getUserInput(
          prompt: "Enter any notes for the new contact (optional): ",
          isValid: (input) => input == null || input.isNotEmpty
        );

        if (phoneBook.addContact(name: name, phoneNumber: phoneNumber, nickname: nickname, secondaryPhoneNumber: secondaryPhoneNumber, email: email, notes: notes)){
          print("Contact added successfully!");
        } else {
          print("Failed to add contact.");
        }
        break;
      case '4':
        stdout.write("Enter the name of the contact to search: ");
        phoneBook.findByName(stdin.readLineSync() ?? "");
        break;
      case '5':
        stdout.write("Enter the nickname of the contact to search: ");
        phoneBook.findByNickName(stdin.readLineSync() ?? "");
        break;
      default:
        print("\nInvalid choice. Please select a valid option.");
    }

    stdout.write('\nPress [Enter] to continue...');
    stdin.readLineSync(); // Wait for user input before clearing the screen and showing the menu again
  }
}