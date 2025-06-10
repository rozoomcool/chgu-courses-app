import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/model/testStage/create_test_stage_request.dart';
import 'package:coursera/domain/model/testStage/testStageType.dart';
import 'package:coursera/presentation/screens/create_lesson/bottom_sheet/bloc/test_edit_bloc.dart';
import 'package:coursera/presentation/screens/create_lesson/dialog/create_test_stage_dialog.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TestEditBottomSheet extends StatefulWidget {
  const TestEditBottomSheet({super.key, this.id, required this.lessonId});

  final int? id;
  final int lessonId;

  @override
  State<TestEditBottomSheet> createState() => _TestEditBottomSheetState();
}

class _TestEditBottomSheetState extends State<TestEditBottomSheet> {
  Future<void> addTestStage(int testId) async {
    showDialog(
        context: context,
        builder: (context) {
          return CreateTestStageDialog(
            testId: testId,
            onOk: (String question, TestStageType type) {
              context.read<TestEditBloc>().addTestStage(CreateTestStageRequest(
                  testId: testId, type: type, question: question));
            },
          );
        });
  }

  void loadTest() {
    context.read<TestEditBloc>().loadTest(widget.id, widget.lessonId);
  }

  @override
  void initState() {
    super.initState();
    context.router.navigationHistory.addListener(() => loadTest());
    loadTest();
  }

  @override
  void dispose() {
    context.router.navigationHistory.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      builder: (context) => SafeArea(
        child: BlocConsumer<TestEditBloc, TestEditState>(
          builder: (context, state) {
            if (state is TestEditLoadedState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TextButton.icon(
                      onPressed: () => addTestStage(state.test.id),
                      label: const Text("Добавить вопрос"),
                      icon: const Icon(Iconsax.add),
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.test.testStages.length,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.test.testStages[index].question),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.primaryColor, size: 32),
              );
            }
          },
          listener: (BuildContext context, TestEditState state) {
            if (state is TestEditErrorState) {
              loadTest();
            }
          },
        ),
      ),
      onClosing: () {},
    );
  }
}
