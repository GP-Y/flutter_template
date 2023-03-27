import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_template/l10n/generated/l10n.dart';

import 'logic.dart';

class LoginPage extends GetView<LoginLogic> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Stack(children: [
        Column(children: [
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              color: Colors.grey[200],
            ),
          )
        ]),
        Align(
          child: Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            width: double.maxFinite,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildLoginInput(themeData),
          ),
        ),
        Positioned(
          top: 35,
          right: 15,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // LocaleKit().changeLocale();
              S.load(Locale('en'));
              controller.update();
            },
            child: Row(children: [
              const Icon(Icons.repeat, color: Colors.white, size: 18),
              Text(
                S.current.changeLanguage,
                style: const TextStyle(color: Colors.white),
              )
            ]),
          ),
        )
      ]),
    );
  }

  ///输入框及登录按钮
  Widget _buildLoginInput(ThemeData themeData) {
    return Column(children: [
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xffF5F5F5)),
          ),
        ),
        child: TextField(
          controller: controller.account,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")), //只允许输入整数
          ],
          //键盘类型
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: S.current.inputTips(S.current.account),
            hintStyle: themeData.textTheme.caption,
            border: InputBorder.none,
            icon: const Padding(
              padding: EdgeInsets.all(5),
              child:
              Icon(Icons.account_box, color: Color(0xff999999), size: 16),
            ),
          ),
        ),
      ),
      const SizedBox(height: 15),
      GetBuilder(builder: (LoginLogic controller) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xffF5F5F5)),
            ),
          ),
          child: TextField(
            controller: controller.password,
            obscureText: !controller.showPassword,
            inputFormatters: const [
              //FilteringTextInputFormatter.allow(RegExp("[0-9]")), //只允许输入整数
            ],
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: S.current.inputTips(S.current.password),
              hintStyle: themeData.textTheme.caption,
              border: InputBorder.none,
              icon: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.lock, color: Color(0xff999999), size: 16),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () => controller.isShowPassword(),
                  child: Icon(
                    controller.showPassword
                        ? Icons.remove_red_eye_outlined
                        : Icons.hide_source_outlined,
                    size: controller.showPassword ? 20 : 18,
                    color: const Color(0xffDEDEDE),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Text(
              S.current.register,
              style: const TextStyle(fontSize: 12, color: Color(0xff999999)),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              S.current.forgetPassword,
              style: const TextStyle(fontSize: 12, color: Color(0xff999999)),
            ),
          ),
        ],
      ),
      GestureDetector(
        onTap: () => controller.login(),
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(22.5),
          ),
          child: Text(
            S.current.login,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ]);
  }
}
