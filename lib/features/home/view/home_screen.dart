import '../model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mamma/features/home/widgets/notes_list.dart';
import 'package:pet_mamma/features/home/widgets/profile_section.dart';
import 'package:provider/provider.dart';
import 'package:pet_mamma/core/common/styles/global_text_style.dart';
import '../controller/home_controller.dart';
import '../widgets/note_input_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, controller, _) {
          final joined = controller.createdAt != null
              ? "${controller.createdAt!.day}-${controller.createdAt!.month}-${controller.createdAt!.year}"
              : "N/A";

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Top Header
                    Row(
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "My Notes",
                              style: getTextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () => controller.signOut(context),
                              icon: Icon(
                                Icons.logout_rounded,
                                color: Colors.redAccent,
                                size: 26.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    /// Profile Section
                    Center(
                      child: ProfileSection(
                        name: controller.userName,
                        email: controller.userEmail,
                        photoUrl: controller.userPhoto,
                        joinedDate: joined,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    /// Add Note Input
                    NoteInputField(
                      controller: controller.noteController,
                      onSend: controller.addNote,
                    ),

                    SizedBox(height: 24.h),

                    /// Notes List
                    Expanded(
                      child: StreamBuilder<List<NoteModel>>(
                        stream: controller.userNotes,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                "Unable to load notes. Try again.",
                                style: getTextStyle(),
                              ),
                            );
                          }

                          final notes = snapshot.data ?? [];
                          if (notes.isEmpty) {
                            return Center(
                              child: Text(
                                "No notes added yet.",
                                style: getTextStyle(),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              return NotesList(
                                note: notes[index],
                                onDelete: () =>
                                    controller.deleteNote(notes[index].id),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
