import 'dart:math';
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
      return;
    }

    for (var contact in _contacts!) {
      print("${_contacts!.indexOf(contact)+1}. ${contact.name} - ${contact.phoneNumber}");
    }
  }

  void populateSampleContacts() {
    final List<Map<String, String>> samples = [
      {
        'name': 'John Doe',
        'phoneNumber': '+1-555-0198',
        'nickname': 'Johnny',
        'email': 'john.doe@example.com',
        'notes': 'Colleague from work.'
      },
      {
        'name': 'Jane Smith',
        'phoneNumber': '+1-555-0143',
        'email': 'jane.smith@example.com'
      },
      {
        'name': 'Bob Johnson',
        'phoneNumber': '+1-555-0177',
        'secondaryPhoneNumber': '+1-555-0178',
        'notes': 'Landlord.'
      },
      {
        'name': 'Alice Williams',
        'phoneNumber': '+1-555-0122',
        'nickname': 'Al',
        'email': 'alice.w@example.com'
      },
      {
        'name': 'Charlie Brown',
        'phoneNumber': '+1-555-0155',
        'notes': 'Gym buddy.'
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
