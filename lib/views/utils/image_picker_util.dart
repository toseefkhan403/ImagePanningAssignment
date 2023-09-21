import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_panning_assignment/viewmodels/local_image_viewmodel.dart';
import 'package:image_panning_assignment/views/utils/colors.dart';
import 'package:provider/provider.dart';

class ImagePickerUtil {
  static void showPickImageBottomSheet(context, {bool changeScreen = true}) {
    showModalBottomSheet(
      context: context,
      builder: (c) => Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconButton(Icons.photo_camera, "Camera", context, changeScreen),
            const SizedBox(
              width: 40,
            ),
            iconButton(Icons.photo_rounded, "Gallery", context, changeScreen),
          ],
        ),
      ),
    );
  }

  static Widget iconButton(IconData iconData, String title,
          BuildContext context, bool changeScreen) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: InkWell(
          onTap: () => onIconPressed(context, title, changeScreen),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  iconData,
                  color: Colors.red,
                ),
              ),
              Text(title),
            ],
          ),
        ),
      );

  static void onIconPressed(
      BuildContext context, String title, bool changeScreen) async {
    final localImgProvider = context.read<LocalImageViewModel>();
    bool isImgReady =
        await localImgProvider.pickImageAndEdit(title == "Camera");

    if (!isImgReady) {
      Fluttertoast.showToast(
        msg: "Please select an image",
      );
    } else {
      Navigator.pop(context);
      if (changeScreen) {
        Navigator.of(context).pushNamed('/uploadPage');
      }
    }
  }
}
