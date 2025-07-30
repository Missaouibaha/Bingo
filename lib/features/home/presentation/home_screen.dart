import 'package:bingo_firebase_example/core/theming/colors_manager.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/float_btn_add_note.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/home_app_bar.dart';
import 'package:bingo_firebase_example/features/home/presentation/widgets/notes/note_list_widget.dart';
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
      appBar: HomeAppBar(),
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [NoteListWidget(), FloatBtnAddNote()],
        ),
      ),
    );
  }
}
