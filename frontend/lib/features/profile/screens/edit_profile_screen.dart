import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../services/avatar_service.dart';
import '../models/profile_model.dart';
import '../providers/profile_provider.dart';
import '../services/profile_service.dart'; // TODO: adjust path if different

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;
  late final TextEditingController _collegeController;
  late final TextEditingController _courseController;
  late final TextEditingController _semesterController;

  ProfileModel? _profile;

  @override
  void initState() {
    super.initState();

    final profile = Provider.of<ProfileProvider>(
      context,
      listen: false,
    ).profile;

    _profile = profile;

    _fullNameController = TextEditingController(text: profile?.fullName ?? "");
    _usernameController = TextEditingController(text: profile?.username ?? "");
    _bioController = TextEditingController(text: profile?.bio ?? "");
    _collegeController = TextEditingController(text: profile?.college ?? "");
    _courseController = TextEditingController(text: profile?.course ?? "");
    _semesterController = TextEditingController(text: profile?.semester ?? "");
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _collegeController.dispose();
    _courseController.dispose();
    _semesterController.dispose();
    super.dispose();
  }

  Future<void> _changeAvatar() async {
    final source = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF182135),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text(
                  "Gallery",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(context, "gallery"),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text(
                  "Camera",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(context, "camera"),
              ),
            ],
          ),
        );
      },
    );

    if (source == null) return;

    File? image;

    if (source == "gallery") {
      image = await AvatarService.instance.pickFromGallery();
    } else {
      image = await AvatarService.instance.pickFromCamera();
    }

    if (image == null) return;

    try {
      final url = await AvatarService.instance.uploadAvatar(image);

      final provider = context.read<ProfileProvider>();

      final success = await provider.updateAvatar(url);

      if (!mounted) return;

      if (success) {
        setState(() {
          _profile = provider.profile;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile picture updated."),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  //-----------------------------------
  // Save profile logic
  //-----------------------------------
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProfileProvider>();
    final currentProfile = provider.profile;

    if (currentProfile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Unable to load profile.")));
      return;
    }

    // Check username availability (only if changed)
    final newUsername = _usernameController.text.trim();

    if (newUsername.isNotEmpty && newUsername != currentProfile.username) {
      final exists = await ProfileService().usernameExists(newUsername);

      if (exists) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username already exists."),
            backgroundColor: Colors.red,
          ),
        );

        return;
      }
    }

    final updatedProfile = currentProfile.copyWith(
      fullName: _fullNameController.text.trim(),
      username: newUsername.isEmpty ? null : newUsername,
      bio: _bioController.text.trim(),
      college: _collegeController.text.trim(),
      course: _courseController.text.trim(),
      semester: _semesterController.text.trim(),
    );

    final success = await provider.updateProfile(updatedProfile);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile updated successfully."),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to update profile."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1120),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //-----------------------------------
                // Avatar
                //-----------------------------------
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: const Color(0xFF7C5CFF),
                        backgroundImage: _profile?.avatarUrl != null
                            ? NetworkImage(_profile!.avatarUrl!)
                            : null,
                        child: _profile?.avatarUrl == null
                            ? const Icon(
                                Icons.person,
                                size: 55,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: _changeAvatar,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7C5CFF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                const Center(
                  child: Text(
                    "Tap camera to change profile picture",
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                ),

                const SizedBox(height: 36),

                //-----------------------------------
                // Form fields
                //-----------------------------------
                _buildTextField(
                  controller: _fullNameController,
                  label: "Full Name",
                  hint: "Enter your full name",
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Full name is required";
                    }
                    if (value.trim().length < 3) {
                      return "Name is too short";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _usernameController,
                  label: "Username",
                  hint: "Choose a username",
                  icon: Icons.alternate_email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    if (value.contains(" ")) {
                      return "Username cannot contain spaces";
                    }
                    if (value.length < 3) {
                      return "Minimum 3 characters";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _bioController,
                  label: "Bio",
                  hint: "Tell us about yourself",
                  icon: Icons.edit_note,
                  maxLines: 4,
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _collegeController,
                  label: "College",
                  hint: "Your college",
                  icon: Icons.school_outlined,
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _courseController,
                  label: "Course",
                  hint: "Your course",
                  icon: Icons.menu_book_outlined,
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _semesterController,
                  label: "Semester",
                  hint: "Current semester",
                  icon: Icons.calendar_today_outlined,
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C5CFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: provider.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Save Changes",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //-----------------------------------
  // Reusable text field widget
  //-----------------------------------
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            prefixIcon: Icon(icon, color: Colors.white70),
            filled: true,
            fillColor: const Color(0xFF182135),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFF7C5CFF)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
