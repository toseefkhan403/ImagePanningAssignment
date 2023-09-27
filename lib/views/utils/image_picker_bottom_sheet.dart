import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/local_image_viewmodel.dart';
import 'colors.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final bool changeScreen;

  const ImagePickerBottomSheet({required this.changeScreen, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconButton(Icons.photo_camera, "Camera", context),
          const SizedBox(
            width: 40,
          ),
          iconButton(Icons.photo_rounded, "Gallery", context),
        ],
      ),
    );
  }

  Widget iconButton(IconData iconData, String title, BuildContext context) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 35),
        child: InkWell(
          onTap: () => onIconPressed(context, title),
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
              const SizedBox(
                height: 2,
              ),
              Text(title),
            ],
          ),
        ),
      );

  void onIconPressed(BuildContext context, String title) async {
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
