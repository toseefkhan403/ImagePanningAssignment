import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_panning_assignment/views/utils/colors.dart';
import 'package:image_panning_assignment/views/utils/image_picker_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change design",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: AppColors.white,
        child: Column(
          children: [
            uploadPictureButton(),
          ],
        ),
      ),
    );
  }

  Widget uploadPictureButton() => Padding(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () => ImagePickerUtil.showPickImageBottomSheet(context),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Image.asset('assets/images/magicIcon1.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text("Upload picture",
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            color: AppColors.blue,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Image.asset('assets/images/magicIcon2.png'),
                ),
              ],
            ),
          ),
        ),
      );
}
