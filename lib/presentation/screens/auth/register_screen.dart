import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/model/auth/register_request.dart';
import 'package:coursera/domain/model/user/user.dart';
import 'package:coursera/domain/state/auth/auth_cubit.dart';
import 'package:coursera/router/app_router.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:coursera/utils/custom_scaffold_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _scaffoldKey = GetIt.I<CustomScaffoldUtil>().key;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleEntityButton = {
    Role.STUDENT: "Студент",
    Role.TEACHER: "Преподаватель"
  };
  Role _role = Role.STUDENT;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SuccessfluRegisteredAuthState) {
          context.replaceRoute(const AuthRoute());
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.primaryColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 52,
                            height: 52,
                            child: SvgPicture.asset("assets/logo.svg")),
                        const SizedBox(
                          width: 16,
                        ),
                        Text("CourseUp",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white))
                      ],
                    ),
                    SizedBox(height: 12,),
                    Text(
                      "Онлайн платформа для обучения",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Регистрация",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                                label: const Text("Логин"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                label: const Text("Пароль"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          // const DropdownMenu(
                          //   dropdownMenuEntries: [
                          //     DropdownMenuEntry(
                          //         value: Role.STUDENT, label: "Ученик"),
                          //     DropdownMenuEntry(
                          //         value: Role.TEACHER, label: "Учитель"),
                          //   ],
                          // ),
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                                color: const Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                spacing: 8,
                                children: [
                                  ..._roleEntityButton.entries.map((e) {
                                    return Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _role = e.key;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          decoration: BoxDecoration(
                                              color: e.key == _role
                                                  ? AppColors.primaryColor
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          duration:
                                              const Duration(milliseconds: 300),
                                          child: Center(
                                              child: Text(
                                            e.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: e.key == _role
                                                        ? Colors.white
                                                        : Colors.black),
                                          )),
                                        ),
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                                  context.read<AuthCubit>().signUp(
                                      RegisterRequest(
                                          email: _usernameController.value.text,
                                          password:
                                              _passwordController.value.text,
                                          role: _role));
                                },
                                child: Text("Зарегистрироваться",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: Colors.white, fontSize: 18)),
                              )),
                          Center(
                            child: TextButton(
                                onPressed: () =>
                                    context.replaceRoute(const AuthRoute()),
                                child: const Text("Уже есть аккаунт? Войти!")),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
