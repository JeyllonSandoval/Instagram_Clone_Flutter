import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerr {
  Future<File> uploadImage(String source) async {
    final picker = ImagePicker();
    XFile? pickedFile;
    
    if (source == 'gallery') {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw Exception('No image selected');
    }
  }
}
