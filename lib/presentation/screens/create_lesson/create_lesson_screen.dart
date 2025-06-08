import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:coursera/presentation/screens/create_lesson/bloc/create_lesson_bloc.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

@RoutePage()
class CreateLessonScreen extends StatefulWidget {
  const CreateLessonScreen({super.key, this.id, required this.courseId});
  final int courseId;
  final int? id;

  @override
  State<CreateLessonScreen> createState() => _CreateLessonScreenState();
}

class _CreateLessonScreenState extends State<CreateLessonScreen> {
  final QuillController _controller = QuillController.basic();
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _editorFocusNode = FocusNode();

  String title = "";
  String lecture = "";
  bool _isInitialized = false;

  final GlobalKey<FormState> _titleKey = GlobalKey();
  final GlobalKey<FormState> _lectureKey = GlobalKey();

  void updateTexts(String? t, String? d) {
    if (!mounted) return;
    
    setState(() {
      if (t != null) title = t;
      if (d != null) lecture = d;
    });
  }

  void loadCourse() {
    context.read<CreateLessonBloc>().loadLesson(widget.id);
  }

  void save({required String title, required String lecture}) {
    context.read<CreateLessonBloc>().update(
        courseId: widget.courseId,
        lessonId: widget.id,
        title: title,
        lecture: lecture);
  }

  @override
  void didUpdateWidget(covariant CreateLessonScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.id != oldWidget.id) {
      loadCourse();
    }
  }

  @override
  void initState() {
    super.initState();
    loadCourse();
    
    _titleController.addListener(() {
      if (_isInitialized) {
        updateTexts(_titleController.text, null);
      }
    });

    _controller.document.changes.listen((event) {
      if (_isInitialized) {
        updateTexts(null, _controller.document.toString());
      }
    });

    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) {
        _editorFocusNode.requestFocus();
      }
    });

    _editorFocusNode.addListener(() {
      if (!_editorFocusNode.hasFocus) {
        _titleFocusNode.requestFocus();
      }
    });

    context.router.addListener(() {
      loadCourse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _titleFocusNode.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateLessonBloc, CreateLessonState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              appBar: AppBar(
                actions: [
                  QuillToolbarFontFamilyButton(
                    options: QuillToolbarFontFamilyButtonOptions(
                        labelOverflow: TextOverflow.ellipsis),
                    controller: _controller,
                  ),
                  QuillToolbarFontSizeButton(
                    controller: _controller,
                  ),
                  QuillToolbarHistoryButton(
                    isUndo: true,
                    controller: _controller,
                  ),
                  QuillToolbarHistoryButton(
                    isUndo: false,
                    controller: _controller,
                  ),
                ],
              ),
              floatingActionButton: Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FloatingActionButton(
                    heroTag: "attachment",
                    onPressed: () {},
                    child: Icon(Iconsax.document_upload),
                  ),
                  FloatingActionButton(
                    heroTag: "add_test",
                    onPressed: () {},
                    child: Icon(Iconsax.teacher),
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  spacing: 2,
                  children: [
                    QuillToolbarColorButton(
                      controller: _controller,
                      isBackground: false,
                    ),
                    QuillToolbarColorButton(
                      controller: _controller,
                      isBackground: true,
                    ),
                    Container(
                      width: 1,
                      height: 16,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      color: Colors.black45,
                    ),
                    QuillToolbarToggleStyleButton(
                      attribute: Attribute.codeBlock,
                      controller: _controller,
                    ),
                    QuillToolbarToggleStyleButton(
                      attribute: Attribute.blockQuote,
                      controller: _controller,
                    ),
                    QuillToolbarLinkStyleButton(
                      controller: _controller,
                    ),
                    Container(
                      width: 1,
                      height: 16,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      color: Colors.black45,
                    ),
                    if (state is CreateLessonLoadedState)
                      IconButton.outlined(
                        onPressed: (state.lesson?.title != title ||
                                state.lesson?.lecture != lecture)
                            ? () {
                                save(
                                    title: _titleController.text,
                                    lecture: _controller.document.toString());
                              }
                            : null,
                        icon: Icon(
                          Iconsax.external_drive,
                          size: 32,
                        ),
                        style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusGeometry.circular(12))),
                      ),
                    if (state is! CreateLessonLoadedState)
                      LoadingAnimationWidget.inkDrop(
                          color: AppColors.primaryColor, size: 32)
                  ],
                ),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        spacing: 2,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Row(
                                spacing: 2,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: QuillToolbarClearFormatButton(
                                        controller: _controller),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: QuillToolbarToggleStyleButton(
                                      attribute: Attribute.ol,
                                      controller: _controller,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: QuillToolbarToggleStyleButton(
                                      attribute: Attribute.ul,
                                      controller: _controller,
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            width: 1,
                            height: 16,
                            color: Colors.black45,
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                spacing: 2,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: QuillToolbarToggleStyleButton(
                                      attribute: Attribute.bold,
                                      controller: _controller,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: QuillToolbarToggleStyleButton(
                                      attribute: Attribute.italic,
                                      controller: _controller,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: QuillToolbarToggleStyleButton(
                                      attribute: Attribute.underline,
                                      controller: _controller,
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            width: 1,
                            height: 16,
                            color: Colors.black45,
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 2,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: QuillToolbarToggleStyleButton(
                                      attribute: Attribute.leftAlignment,
                                      controller: _controller,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: QuillToolbarToggleStyleButton(
                                      attribute: Attribute.centerAlignment,
                                      controller: _controller,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: QuillToolbarToggleStyleButton(
                                      attribute: Attribute.rightAlignment,
                                      controller: _controller,
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsGeometry.all(8),
                        child: TextField(
                          key: _titleKey,
                          focusNode: _titleFocusNode,
                          autofocus: false,
                          controller: _titleController,
                          decoration: InputDecoration(hint: Text("Название")),
                        )),
                    Expanded(
                      child: QuillEditor.basic(
                        key: _lectureKey,
                        controller: _controller,
                        focusNode: _editorFocusNode,
                        config: QuillEditorConfig(
                            expands: true,
                            autoFocus: false,
                            padding: EdgeInsetsGeometry.only(
                                right: 16, left: 16, top: 8, bottom: 32)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (state is CreateLessonLoadingState ||
                state is CreateLessonInitialState)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black12,
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primaryColor, size: 32),
                ),
              ),
          ],
        );
      },
      listener: (BuildContext context, CreateLessonState state) {
        if (state is CreateLessonLoadedState) {
          if (!_isInitialized) {
            _isInitialized = true;
            _titleController.text = state.lesson?.title ?? '';
            final lecture = state.lesson?.lecture;
            if (lecture != null && lecture.isNotEmpty) {
              _controller.document = Document.fromJson(
                  jsonDecode(lecture) as List<dynamic>);
            }
          }
          updateTexts(state.lesson?.title, state.lesson?.lecture);
        }
      },
    );
  }
}
