import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/model/option/create_option_request.dart';
import 'package:coursera/domain/model/testStage/create_test_stage_request.dart';
import 'package:coursera/domain/model/testStage/testStageType.dart';
import 'package:coursera/presentation/screens/create_lesson/bottom_sheet/bloc/test_edit_bloc.dart';
import 'package:coursera/presentation/screens/create_lesson/dialog/create_option_dialog.dart';
import 'package:coursera/presentation/screens/create_lesson/dialog/create_test_stage_dialog.dart';
import 'package:coursera/presentation/screens/create_lesson/widgets/create_test_stage_card.dart';
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
  late final VoidCallback _routerListener;

  Future<void> addTestStage(int testId) async {
    await showDialog(
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

  Future<void> addOption(int testId, int testStageId) async {
    await showDialog(
        context: context,
        builder: (context) {
          return CreateOptionDialog(onCreate: (String option, bool isCorrect) {
            context.read<TestEditBloc>().addOption(
                testId,
                CreateOptionRequest(
                    option: option,
                    testStageId: testStageId,
                    isCorrect: isCorrect));
          });
        });
  }

  void loadTest() {
    if (!mounted) return;
    context.read<TestEditBloc>().loadTest(widget.id, widget.lessonId);
  }

  @override
  void initState() {
    super.initState();
    _routerListener = () => loadTest();
    context.router.navigationHistory.addListener(_routerListener);
    loadTest();
  }

  @override
  void dispose() {
    if (mounted) {
      context.router.navigationHistory.removeListener(_routerListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      return CreateTestStageCard(
                        testStage: state.test.testStages[index],
                        onEdit: () {},
                        onDelete: () => context
                            .read<TestEditBloc>()
                            .deleteTestStage(state.test.testStages[index].id),
                        onAddOption: () => addOption(
                            state.test.id, state.test.testStages[index].id),
                        onDeleteOption: (int id) {
                          context.read<TestEditBloc>().deleteOption(
                              testStageId: state.test.testStages[index].id,
                              optionId: id);
                        },
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
    );
  }
}
