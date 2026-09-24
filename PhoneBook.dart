import 'dart:math';

import 'Contact.dart';

class PhoneBook {
  /// A class to manage a phone book with a list of contacts.
  /// 
  /// Attribute:
  /// _contacts: A list of Contact objects representing the contacts in the phone book.
  /// 
  /// Methods:
  /// - generateUniqueId(): Generates a unique ID for a new contact.
  /// - getContactsCount(): Returns the number of contacts in the phone book.
  /// - addContact(): Adds a new contact to the phone book.
  /// - displayContacts(): Displays a list of all contacts in the phone book.
  /// - viewContactDetails(): Displays the details of a specific contact.
  /// - getCurrentContactName(): Returns the name of a contact at a given index.
  /// - updateContact(): Updates the details of a specific contact.
  /// - removeContact(): Removes a contact from the phone book.
  /// - findByName(): Searches for contacts by name and displays the results.
  /// - findByNickName(): Searches for contacts by nickname and displays the results.

  List<Contact>? _contacts;

  /// Generates a unique ID for a new contact by combining the current timestamp and a random number.
  String generateUniqueId() {
    final int randomNum = Random().nextInt(1000);
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    
    return "U-" + timestamp.toString() + "-" + randomNum.toString();
  }

  /// Returns the number of contacts in the phone book.
  int getContactsCount() {
    return _contacts?.length ?? 0;
  }

  /// Adds a new contact to the phone book with the provided details.
  /// Returns true if the contact was added successfully, false otherwise.
  bool addContact({required String name, required String phoneNumber, String? nickname, String? secondaryPhoneNumber, String? email, String? notes}) {
    try {
      Contact newContact = Contact();
      newContact.id = generateUniqueId();
      newContact.name = name;
      newContact.phoneNumber = phoneNumber;
      newContact.nickname = nickname;
      newContact.secondaryPhoneNumber = secondaryPhoneNumber;
      newContact.email = email;
      newContact.notes = notes;

      _contacts ??= [];
      _contacts!.add(newContact);
      return true;
    }
    catch (e) {
      print("Error adding contact: $e");
      return false;
    }
  }

  /// Displays a list of all contacts in the phone book.
  displayContacts() {
    if (_contacts == null || _contacts!.isEmpty) {
      print("No contacts available.");
      return 0;
    }

    print("\n=================== Contact List ===================");
    for (var contact in _contacts!) {
      print("${_contacts!.indexOf(contact)+1}. ${contact.name} - ${contact.phoneNumber}");
    }
    print("====================================================");
  }

  /// Displays the details of a specific contact.
  viewContactDetails(int index) {
    Contact contact = _contacts![index];
    print("\n=================== Contact Details ===================");
    print("Name: \t\t\t\t${contact.name}");
    print("Phone Number: \t\t\t${contact.phoneNumber}");
    print("Nickname: \t\t\t${contact.nickname ?? 'N/A'}");
    print("Secondary Phone Number: \t${contact.secondaryPhoneNumber ?? 'N/A'}");
    print("Email: \t\t\t\t${contact.email ?? 'N/A'}");
    print("Notes: \t\t\t\t${contact.notes ?? 'N/A'}");
    print("======================================================");
  }

  /// Returns the name of a contact at a given index. If the index is invalid, returns an error message.
  String getCurrentContactName(int index) {
    if (_contacts == null || index < 0 || index >= _contacts!.length) {
      return "Invalid contact index.";
    }
    return _contacts![index].name;
  }

  /// Updates the details of a specific contact at the given index.
  /// Returns true if the contact was updated successfully, false otherwise.
  bool updateContact({required int index, String? name, String? phoneNumber, String? nickname, String? secondaryPhoneNumber, String? email, String? notes}) {
    if (_contacts == null || index < 0 || index >= _contacts!.length) {
      print("Invalid contact index.");
      return false;
    }

    Contact contact = _contacts![index];
    if (name != null) contact.name = name;
    if (phoneNumber != null) contact.phoneNumber = phoneNumber;
    if (nickname != null) contact.nickname = nickname;
    if (secondaryPhoneNumber != null) contact.secondaryPhoneNumber = secondaryPhoneNumber;
    if (email != null) contact.email = email;
    if (notes != null) contact.notes = notes;

    return true;
  }

  /// Removes a contact from the phone book at the given index.
  /// Returns true if the contact was removed successfully, false otherwise.
  bool removeContact(int index) {
    if (_contacts == null || index < 0 || index >= _contacts!.length) {
      print("Invalid contact index.");
      return false;
    }

    _contacts!.removeAt(index);

    return true;
  }

  /// Searches for contacts by name and displays the results.
  findByName(String name) {
    if (name.isEmpty) {
      print("No name entered. Returning to main menu.");
      return;
    }
    
    if (_contacts == null || _contacts!.isEmpty) {
      print("No contacts available.");
      return;
    }

    List<Contact> foundContacts = _contacts!.where((contact) => contact.name.toLowerCase().contains(name.toLowerCase())).toList();

    if (foundContacts.isEmpty) {
      print("No contacts found with the name '$name'.");
      return;
    }

    print("\n=================== Search Results ===================");
    for (var contact in foundContacts) {
      print("${_contacts!.indexOf(contact)+1}. ${contact.name} - ${contact.phoneNumber}");
    }
    print("======================================================\n");
  }

  /// Searches for contacts by nickname and displays the results.
  findByNickName(String nickname) {    
    if (nickname.isEmpty) {
      print("No name entered. Returning to main menu.");
      return;
    }

    if (_contacts == null || _contacts!.isEmpty) {
      print("No contacts available.");
      return;
    }

    List<Contact> foundContacts = _contacts!.where((contact) => contact.nickname != null && contact.nickname!.toLowerCase().contains(nickname.toLowerCase())).toList();

    if (foundContacts.isEmpty) {
      print("No contacts found with the nickname '$nickname'.");
      return;
    }
    
    print("\n=================== Search Results ===================");
    for (var contact in foundContacts) {
      print("${_contacts!.indexOf(contact)+1}. ${contact.name} - ${contact.phoneNumber}");
    }
    print("======================================================\n");
  }

  /// Sample method to populate the phone book with some initial contacts for testing purposes. 
  /// NOTE: Delete this method after implementing data persistence.
  void populateSampleContacts() {
    final List<Map<String, String>> samples = [
      {
        'name': 'John Doe',
        'phoneNumber': '+1-555-0198',
        'nickname': 'Johnny',
        'email': 'john.doe@example.com',
        'notes': 'Colleague from work.',
      },
      {
        'name': 'Jane Smith',
        'phoneNumber': '+1-555-0143',
        'email': 'jane.smith@example.com',
      },
      {
        'name': 'Bob Johnson',
        'phoneNumber': '+1-555-0177',
        'secondaryPhoneNumber': '+1-555-0178',
        'notes': 'Landlord.',
      },
      {
        'name': 'Alice Williams',
        'phoneNumber': '+1-555-0122',
        'nickname': 'Al',
        'email': 'alice.w@example.com',
      },
      {
        'name': 'Charlie Brown',
        'phoneNumber': '+1-555-0155',
        'notes': 'Gym buddy.',
      },
    ];

    for (var sample in samples) {
      addContact(
        name: sample['name']!,
        phoneNumber: sample['phoneNumber']!,
        nickname: sample['nickname'],
        secondaryPhoneNumber: sample['secondaryPhoneNumber'],
        email: sample['email'],
        notes: sample['notes'],
      );
    }
  }
}
