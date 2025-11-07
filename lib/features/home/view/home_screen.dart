import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "My Notes",
                style: getTextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () => controller.signOut(context),
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// Profile Section
                  ProfileSection(
                    name: controller.userName,
                    email: controller.userEmail,
                    photoUrl: controller.userPhoto,
                    joinedDate: joined,
                  ),

                  const SizedBox(height: 24),

                  /// Add Note
                  NoteInputField(
                    controller: controller.noteController,
                    onSend: controller.addNote,
                  ),

                  const SizedBox(height: 24),

                  /// Notes List
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
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

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              "No notes added yet.",
                              style: getTextStyle(),
                            ),
                          );
                        }

                        final notes = snapshot.data!.docs;

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
          );
        },
      ),
    );
  }
}
