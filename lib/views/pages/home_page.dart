import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_panning_assignment/views/utils/colors.dart';
import 'package:image_panning_assignment/views/utils/image_picker_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change design",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Container(
        color: AppColors.white,
        child: Column(
          children: [
            uploadPictureButton(context),
          ],
        ),
      ),
    );
  }

  Widget uploadPictureButton(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (c) => const ImagePickerBottomSheet(changeScreen: true),
          ),
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Image.asset('assets/images/magicIcon1.png'),
                ),
                Text("Upload picture",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: AppColors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 26),
                  child: Image.asset('assets/images/magicIcon2.png'),
                ),
              ],
            ),
          ),
        ),
      );
}
