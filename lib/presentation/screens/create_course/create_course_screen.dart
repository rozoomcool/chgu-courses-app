import 'dart:typed_data';

import 'package:auto_route/annotations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  Uint8List? _file = null;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final Uint8List file = await (await _imagePicker.pickImage(source: ImageSource.gallery))!.readAsBytes();
    setState(() {
      _file = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создание курса"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              InkWell(
                onTap: _pickImage,
                borderRadius: BorderRadius.circular(12),
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    dashPattern: [5, 3],
                      radius: Radius.circular(12)),
                  child: SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: Center(
                      child: _file == null
                          ? Text(
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
                                      image: MemoryImage(_file!))),
                            ),
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(label: Text("Название")),
              ),
              TextField(
                controller: _descriptionController,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(label: Text("Описание")),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Создать",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
