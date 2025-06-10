import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/presentation/screens/create_course/bloc/create_course_bloc.dart';
import 'package:coursera/router/app_router.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:coursera/utils/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key, this.id});

  final int? id;

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

  void updateFormFromCourse(Course course) {
    setState(() {
      _titleController.text = course.title;
      _descriptionController.text = course.description;
    });
  }

  void _createCourse() {
    if (!_isFormValid) return;

    // Создаем временный файл из байтов
    final tempFile = File(_file!.path);

    context.read<CreateCourseBloc>().createCourse(
          file: tempFile,
          title: _titleController.text,
          description: _descriptionController.text,
        );
  }

  void _updateCourse() {
    if (widget.id == null) return;
    final tempFile = _file == null ? null : File(_file!.path);

    context.read<CreateCourseBloc>().updateCourse(
          file: tempFile,
          title: _titleController.text,
          description: _descriptionController.text,
          id: widget.id!,
        );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      context.read<CreateCourseBloc>().loadCourse(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCourseBloc, CreateCourseState>(
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
                            child: Builder(builder: (context) {
                              if (_file == null &&
                                  state is CreateCourseLoadedState) {
                                return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "$uploadsUrl/${state.course.imageUrl}"))));
                              } else if (_file == null &&
                                  state is! CreateCourseLoadedState) {
                                return const Text(
                                  'Выберите обложку курса',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else {
                                return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                FileImage(File(_file!.path)))));
                              }
                            }),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _titleController,
                      decoration:
                          const InputDecoration(label: Text("Название")),
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
                      decoration:
                          const InputDecoration(label: Text("Описание")),
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
                        onPressed:
                            (state is CreateCourseLoadedState)
                                ? _updateCourse
                                : (_isFormValid &&
                                        state is! CreateCourseLoadedState)
                                    ? _createCourse
                                    : null,
                        child: Text(
                          (state is CreateCourseLoadedState) ? "Обновить" : "Создать",
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
      },
      listener: (BuildContext context, CreateCourseState state) {
        if (state is CreateCourseCreatedState) {
          context.router.replace(CourseInfoRoute(id: state.course.id));
        } else if (state is CreateCourseLoadedState) {
          updateFormFromCourse(state.course);
        } else if (state is CreateCourseUpdatedState) {
          context.maybePop();
        }
      },
    );
  }
}
