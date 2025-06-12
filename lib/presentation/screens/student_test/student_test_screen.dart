import 'package:auto_route/annotations.dart';
import 'package:coursera/presentation/screens/student_test/bloc/student_test_screen_cubit.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:coursera/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

@RoutePage()
class StudentTestScreen extends StatefulWidget {
  final int lessonId;
  final int testId;

  const StudentTestScreen({
    super.key,
    required this.lessonId,
    required this.testId,
  });

  @override
  State<StudentTestScreen> createState() => _StudentTestScreenState();
}

class _StudentTestScreenState extends State<StudentTestScreen> {
  final Dio dio = GetIt.I(); // Initialize Dio with your base options
  Map<int, List<int>> selectedAnswers = {}; // Map<testStageId, List<optionId>>
  bool isSubmitting = false;
  String? resultMessage;

  @override
  void initState() {
    super.initState();
    context.read<StudentTestScreenCubit>().loadTest(widget.testId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentTestScreenCubit, StudentTestScreenState>(
        builder: (context, state) {
      if (state is! StudentTestScreenLoadedState) {
        return Scaffold(
          body: Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: AppColors.primaryColor, size: 32)),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("Проверь себя"),
        ),
        bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            onPressed: submitTest,
            child: const Text('Завершить'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isSubmitting
              ? const Center(child: CircularProgressIndicator())
              : resultMessage != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(resultMessage!,
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Вернуться к уроку'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.test.testStages.length,
                      itemBuilder: (context, index) {
                        final stage = state.test.testStages[index];
                        final options = stage.options;
                        final hasMultipleCorrect = options
                                .where((opt) => opt.isCorrect == true)
                                .length >
                            1;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stage.question,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...options.map((option) {
                                  return hasMultipleCorrect
                                      ? CheckboxListTile(
                                          title: Text(option.option),
                                          value: selectedAnswers[stage.id]
                                                  ?.contains(option.id) ??
                                              false,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (!selectedAnswers
                                                  .containsKey(stage.id)) {
                                                selectedAnswers[stage.id] = [];
                                              }
                                              if (value == true) {
                                                selectedAnswers[stage.id]!
                                                    .add(option.id);
                                              } else {
                                                selectedAnswers[stage.id]!
                                                    .remove(option.id);
                                              }
                                            });
                                          },
                                        )
                                      : RadioListTile<int>(
                                          title: Text(option.option),
                                          value: option.id,
                                          groupValue:
                                              selectedAnswers[stage.id]?.first,
                                          onChanged: (int? value) {
                                            setState(() {
                                              if (value != null) {
                                                selectedAnswers[stage.id] = [
                                                  value
                                                ];
                                              }
                                            });
                                          },
                                        );
                                }),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      );
    });
  }

  Future<void> submitTest() async {
    setState(() {
      isSubmitting = true;
    });

    try {
      final response = await dio.post(
        '$baseUrl/api/v1/tests/submit',
        data: {
          'testId': widget.testId,
          'answers': selectedAnswers.entries
              .map((e) => {
                    'testStageId': e.key,
                    'optionIds': e.value,
                  })
              .toList(),
        },
      );

      setState(() {
        isSubmitting = false;
        resultMessage =
            'Результат: ${response.data['score']}/${response.data['total']}';
      });
    } catch (e) {
      setState(() {
        isSubmitting = false;
        resultMessage = 'Error submitting test: $e';
      });
    }
  }
}
