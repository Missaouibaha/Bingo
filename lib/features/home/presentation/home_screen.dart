import 'package:bingo_firebase_example/core/helper/spacing.dart';
import 'package:bingo_firebase_example/core/theming/app_assets.dart';
import 'package:bingo_firebase_example/core/theming/app_dimensions.dart';
import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/bottom_sheet_add_note.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: ColorsManager.white,
        elevation: 2,
        title: Container(
          width: AppDimensions.width_100,
          alignment: Alignment.centerLeft,

          child: Image.asset(
            AppAssets.bingoTitle,
            color: ColorsManager.darckBlue,
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        actionsPadding: EdgeInsets.all(AppDimensions.padding_10),
        automaticallyImplyLeading: false,
        actions: [
          horizontalSpace(AppDimensions.width_10),
          Icon(
            Icons.person_4_outlined,
            color: ColorsManager.darckBlue,
            size: AppDimensions.width_35,
          ),
        ],
      ),
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(child: Column(children: [
               
              ],
            )),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  0,
                  AppDimensions.padding_10,
                  AppDimensions.verticalPadding_10,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: ColorsManager.white,
                    elevation: 6,
                    padding: EdgeInsets.all(AppDimensions.padding_5),
                  ),
                  onPressed: () {
                    showBottomSheetAddNote();
                  },
                  child: Icon(
                    Icons.add_circle_outline_rounded,
                    color: ColorsManager.darckBlue,
                    size: AppDimensions.width_50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetAddNote() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radius_16),
          topRight: Radius.circular(AppDimensions.radius_16),
        ),
      ),
      builder: (context) {
        return BottomSheetAddNote();
      },
    );
  }
}
