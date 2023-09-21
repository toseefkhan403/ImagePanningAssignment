import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class HelperWidgets {
  static PreferredSizeWidget customAppBar(BuildContext context, String title) =>
      AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: const EdgeInsets.only(left: 15, top: 3),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      );

  static Widget customButton(String title, Function() fn,
          {bool isRed = true}) =>
      Padding(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: fn,
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: isRed ? Colors.red : Colors.white,
                  border: Border.all(width: 1, color: Colors.red)),
              child: Center(
                  child: Text(title,
                      style: GoogleFonts.mulish(
                        textStyle: TextStyle(
                            color: isRed ? Colors.white : Colors.red,
                            fontSize: 21,
                            fontWeight: FontWeight.w500),
                      )))),
        ),
      );

  static Widget imageViewContainer({required Widget child, DecorationImage? backgroundImage}) =>
      Expanded(
        child: Container(
          // height: 600,
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: backgroundImage,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: child),
        ),
      );

  static Widget dummyDataHeader(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 40),
        child: CircleAvatar(
          radius: 60,
          child: Image.asset("assets/images/placeholder.png"),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          "Alexandra",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
      Text(
        "Stanton",
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.white),
      ),
    ],
  );
}
