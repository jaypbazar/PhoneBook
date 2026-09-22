import 'PhoneBook.dart';
import 'dart:io';

main() {
  PhoneBook phoneBook = PhoneBook();
  // int? index;

  phoneBook.populateSampleContacts();
  // index = phoneBook.displayContacts();
  // phoneBook.viewContactDetails(index - 1);

  stdout.write("Enter the name of the contact to search: ");
  phoneBook.findByName(stdin.readLineSync() ?? "");
}