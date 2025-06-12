import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:coursera/presentation/screens/lesson_info/bloc/lesson_info_bloc.dart';
import 'package:coursera/presentation/screens/student_test/student_test_screen.dart';
import 'package:coursera/router/app_router.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

@RoutePage()
class LessonInfoScreen extends StatefulWidget {
  const LessonInfoScreen({super.key, required this.id});

  final int id;

  @override
  State<LessonInfoScreen> createState() => _LessonInfoScreenState();
}

class _LessonInfoScreenState extends State<LessonInfoScreen> {
  final QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initController(String lecture) {
    try {
      final json = Document.fromJson(jsonDecode(lecture));
      _controller.document = json;
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    _controller.readOnly = true;
    context.read<LessonInfoBloc>().loadLesson(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LessonInfoBloc, LessonInfoState>(
      builder: (context, state) {
        if (state is LessonInfoLoadedState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.lesson.title),
            ),
            bottomNavigationBar: (state.lesson.test == null &&
                    (state.lesson.test?.testStages.isEmpty ?? true))
                ? SizedBox()
                : BottomAppBar(
                    child: ElevatedButton(
                        child: Text("пройти тест"),
                        onPressed: () => context.pushRoute(StudentTestRoute(
                            lessonId: state.lesson.id,
                            testId: state.lesson.test!.id))),
                  ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 16.0, left: 16.0, top: 8.0),
                    child: QuillEditor.basic(
                      controller: _controller,
                      config: const QuillEditorConfig(
                        scrollable: true,
                        autoFocus: false,
                        expands: true,
                        showCursor: false,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.primaryColor, size: 32),
          ),
        );
      },
      listener: (BuildContext context, LessonInfoState state) {
        if (state is LessonInfoLoadedState) {
          initController(state.lesson.lecture ?? "");
        }
      },
    );
  }
}
