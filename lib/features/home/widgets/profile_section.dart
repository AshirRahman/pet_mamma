import 'package:flutter/material.dart';
import 'package:pet_mamma/core/utils/images_path.dart';
import '../../../core/common/styles/global_text_style.dart';

class ProfileSection extends StatelessWidget {
  final String name;
  final String email;
  final String? photoUrl;
  final String joinedDate;

  const ProfileSection({
    super.key,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.joinedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: photoUrl != null
              ? NetworkImage(photoUrl!)
              : const AssetImage(ImagesPath.profile),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: getTextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(email, style: getTextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          "Joined: $joinedDate",
          style: getTextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
