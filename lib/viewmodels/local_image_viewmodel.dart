import 'dart:typed_data';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class LocalImageViewModel extends ChangeNotifier {
  String? _imgPath;

  String? get imgPath => _imgPath;

  void setImagePath(String imgPath) {
    _imgPath = imgPath;
    notifyListeners();
  }

  Future<bool> pickImageAndEdit(bool isCamera) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedImage != null) {
      CroppedFile? editedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Edit Photo',
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ],
      );

      if(editedFile != null) {
        setImagePath(editedFile.path);
        return true;
      }
    }

    return false;
  }

  Future<String> savePannedImage(GlobalKey repaintKey) async {
    RenderRepaintBoundary boundary =
    repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? uint8List = byteData?.buffer.asUint8List();

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/edited_image.png';

    File imageFile = File(filePath);
    await imageFile.writeAsBytes(uint8List!);

    print(filePath);

    return imageFile.path;
  }
}