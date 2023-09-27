import 'package:flutter/material.dart';
import 'package:image_panning_assignment/views/utils/colors.dart';
import 'package:image_panning_assignment/views/utils/helper_widgets.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/network_image_viewmodel.dart';
import '../utils/dummy_data_widget.dart';

class FinalImageViewPage extends StatefulWidget {
  const FinalImageViewPage({Key? key}) : super(key: key);

  @override
  State<FinalImageViewPage> createState() => _FinalImageViewPageState();
}

class _FinalImageViewPageState extends State<FinalImageViewPage> {
  @override
  void initState() {
    context.read<NetworkImageViewModel>().fetchImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperWidgets.customAppBar(context, "Artist"),
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            Consumer<NetworkImageViewModel>(builder: (BuildContext context,
                NetworkImageViewModel value, Widget? child) {
              return value.image == null
                  ? const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )),
                    )
                  : HelperWidgets.imageViewContainer(
                      child: const DummyDataColumn(),
                      backgroundImage: DecorationImage(
                          image: NetworkImage(value.image!.imageUrl),
                          fit: BoxFit.cover),
                    );
            }),
            HelperWidgets.customButton("Edit Card", () {
              Navigator.of(context).pushNamed('/editImagePage');
            }, isRed: false),
          ],
        ),
      ),
    );
  }
}
