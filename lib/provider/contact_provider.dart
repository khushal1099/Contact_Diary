import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../modal/contact_modal.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];
  int cIndex = 0;
  ImagePicker picker = ImagePicker();
  XFile? xFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  GlobalKey<FormState> fk = GlobalKey<FormState>();
  bool isEdit1 = false;
  bool isEdit2 = false;


  void stepperContinue() {
    if (cIndex < 1) {
      cIndex++;
    }
    notifyListeners();
  }

  void stepperCancel() {
    if (cIndex > 0) {
      cIndex--;
    }
    notifyListeners();
  }

  void stepperTapped() {
    notifyListeners();
  }

  void stepperCamera() {
    picker.pickImage(source: ImageSource.camera).then((value) {
      xFile = value;
      notifyListeners();
    });
  }

  void stepperGallery() {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      xFile = value;
      notifyListeners();
    });
  }

void addcontact(ContactModel contact) {
    contactList.add(contact);
    notifyListeners();
  }

  void remove(int i) {
    contactList.removeAt(i);
    notifyListeners();
  }
  void editContact(int index,ContactModel contact)
  {
    contactList[index]=contact;
    notifyListeners();
  }

  void reset() {
    nameController.clear();
    contactController.clear();
    xFile=null;
    cIndex=0;
  }

}
