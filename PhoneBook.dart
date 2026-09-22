import 'dart:math';
import 'dart:io';
import 'Contact.dart';

class PhoneBook {
  List<Contact>? _contacts;

  String generateUniqueId() {
    final int randomNum = Random().nextInt(1000);
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    
    return "U-" + timestamp.toString() + "-" + randomNum.toString();
  }

  addContact({required String name, required String phoneNumber, String? nickname, String? secondaryPhoneNumber, String? email, String? notes}) {
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
  }

  displayContacts() {
    if (_contacts == null || _contacts!.isEmpty) {
      print("No contacts available.");
      return 0;
    }

    print("\n=================== Contact List ===================");
    for (var contact in _contacts!) {
      print("${_contacts!.indexOf(contact)+1}. ${contact.name} - ${contact.phoneNumber}");
    }
    print("====================================================\n");
  }

  viewContactDetails() {
    stdout.write("Enter the count number of the contact to view details (or 0 to exit): ");
    int index = int.parse(stdin.readLineSync() ?? "0")-1;

    if (_contacts == null || index < 0 || index >= _contacts!.length) {
      print("Invalid contact index.");
      return;
    }

    Contact contact = _contacts![index];
    print("\n=================== Contact Details ===================");
    print("Name: \t\t\t\t${contact.name}");
    print("Phone Number: \t\t\t${contact.phoneNumber}");
    print("Nickname: \t\t\t${contact.nickname ?? 'N/A'}");
    print("Secondary Phone Number: \t${contact.secondaryPhoneNumber ?? 'N/A'}");
    print("Email: \t\t\t\t${contact.email ?? 'N/A'}");
    print("Notes: \t\t\t\t${contact.notes ?? 'N/A'}");
    print("======================================================\n");
  }

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
