import 'dart:typed_data';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:coursera/presentation/screens/create_course/bloc/create_course_bloc.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  XFile? _file;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  bool get _isFormValid =>
      _file != null &&
      _titleController.text.isNotEmpty &&
      _descriptionController.text.isNotEmpty;

  Future<void> _pickImage() async {
    final file = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 1500,
        imageQuality: 70);
    setState(() {
      _file = file;
    });
  }

  void _createCourse() {
    if (!_isFormValid) return;

    // Создаем временный файл из байтов
    final tempFile = File(_file!.path);
    debugPrint("|||| " + tempFile.uri.toString());

    context.read<CreateCourseBloc>().createCourse(
          file: tempFile,
          title: _titleController.text,
          description: _descriptionController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCourseBloc, CreateCourseState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Создание курса"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: _pickImage,
                    borderRadius: BorderRadius.circular(12),
                    child: DottedBorder(
                      options: const RoundedRectDottedBorderOptions(
                          dashPattern: [5, 3], radius: Radius.circular(12)),
                      child: Container(
                        color: AppColors.backgroundColor,
                        width: double.infinity,
                        height: 150,
                        child: Center(
                          child: _file == null
                              ? const Text(
                                  'Выберите обложку курса',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(File(_file!.path)))),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(label: Text("Название")),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите название курса';
                      }
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionController,
                    minLines: 3,
                    maxLines: null,
                    decoration: const InputDecoration(label: Text("Описание")),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите описание курса';
                      }
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isFormValid ? _createCourse : null,
                      child: Text(
                        "Создать",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
