import 'package:flutter/material.dart';

import 'colors.dart';
import 'helper_widgets.dart';

class DummyDataColumn extends StatelessWidget {
  const DummyDataColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        HelperWidgets.dummyDataHeader(context),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Realtor | VP design",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
        ),
        Text(
          "Bangalore, India",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.white,
              ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dummyIcon(Icons.mail),
            dummyIcon(Icons.call),
            dummyIcon(Icons.location_on),
            dummyIcon(Icons.person_outline),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset("assets/images/ElredLogo.png"),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.overlayColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: 18,
                ),
              ),
              const Text(
                "Profile",
                style: TextStyle(color: AppColors.white),
              )
            ],
          ),
        )
      ],
    );
  }

  dummyIcon(IconData iconData) => Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.overlayColor,
            borderRadius: BorderRadius.circular(10)),
        child: Icon(
          iconData,
          color: AppColors.white,
        ),
      );
}
