import 'PhoneBook.dart';

main() {
  PhoneBook phoneBook = PhoneBook();
  int? index;

  phoneBook.populateSampleContacts();
  index = phoneBook.displayContacts();
  phoneBook.viewContactDetails(index - 1);
}