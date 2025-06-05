import 'package:auto_route/auto_route.dart';
import 'package:coursera/presentation/screens/create_lesson/bloc/create_lesson_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:iconsax/iconsax.dart';

@RoutePage()
class CreateLessonScreen extends StatefulWidget {
  const CreateLessonScreen({super.key});

  @override
  State<CreateLessonScreen> createState() => _CreateLessonScreenState();
}

class _CreateLessonScreenState extends State<CreateLessonScreen> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLessonBloc, CreateLessonState>(
        builder: (context, state) {
      return Scaffold(
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
              QuillToolbarClipboardButton(
                  controller: _controller,
                  clipboardAction: ClipboardAction.copy),
              QuillToolbarClipboardButton(
                  controller: _controller,
                  clipboardAction: ClipboardAction.paste)
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
              // QuillSimpleToolbar(
              //   controller: _controller,
              //   config: const QuillSimpleToolbarConfig(
              //       showSearchButton: false, showDirection: true),
              // ),
              Padding(
                  padding: EdgeInsetsGeometry.all(8),
                  child: TextField(
                    decoration: InputDecoration(hint: Text("Название")),
                  )),
              Expanded(
                child: QuillEditor.basic(
                  controller: _controller,
                  config: const QuillEditorConfig(
                      expands: true,
                      autoFocus: true,
                      padding: EdgeInsetsGeometry.only(
                          right: 16, left: 16, top: 8, bottom: 32)),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
