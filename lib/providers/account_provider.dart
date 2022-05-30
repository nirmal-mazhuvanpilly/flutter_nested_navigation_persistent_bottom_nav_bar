import 'package:flutter/cupertino.dart';
import 'package:flutter_test_application/models/account_model.dart';
import 'package:flutter_test_application/services/locators.dart';
import 'package:flutter_test_application/utils/db_helper.dart';
import 'package:flutter_test_application/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';

class AccountProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final db = getIt<DbHelper>();

  Account? account;
  String? image;

  Future<void> pickImageFromGallery() async {
    final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      final String stringImage =
          await Helpers.base64String(await _image.readAsBytes());
      image = stringImage;
      db.uploadImage(image: image);
      notifyListeners();
    }
    await getAccountData();
  }

  Future<void> getAccountData() async {
    account = await db.getAccountData();
    notifyListeners();
  }
}
