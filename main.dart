import 'PhoneBook.dart';
import 'dart:io';

main() {
  PhoneBook phoneBook = PhoneBook();
  phoneBook.populateSampleContacts();

  String? choice;
  
  
  while (true) {
    stdout.write('\x1B[2J\x1B[H'); // clear the console screen

    print("=================== Welcome to the Phone Book Application ==================");
    print("1. Display all contacts");
    print("2. View contact details");
    print("3. Search for a contact by name");
    print("4. Exit");
  
    stdout.write("What would you like to do? (choose a number): ");
    choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        phoneBook.displayContacts();
        break;
      case '2':
        phoneBook.displayContacts();
        phoneBook.viewContactDetails();
        break;
      case '3':
        stdout.write("Enter the name of the contact to search: ");
        phoneBook.findByName(stdin.readLineSync() ?? "");
        break;
      case '4':
        print("Exiting the application. Goodbye!");
        exit(0);
      default:
        print("Invalid choice. Please select a valid option.");
    }

    stdout.write('Press [Enter] to continue...');
    stdin.readLineSync();
  }
}