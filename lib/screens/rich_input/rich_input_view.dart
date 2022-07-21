import 'package:base_flutter/screens/rich_input/rich_input_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RichInputViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RichInputController());
  }
}

class RichInputView extends GetView<RichInputController> {
  const RichInputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Visibility(
                child: Container(
                  child: Column(
                    children: controller.suggestions.value
                        .map((e) => Text(e.displayName ?? "haha"))
                        .toList(),
                  ),
                ),
                visible: controller.suggestions.isNotEmpty,
              )),
          TextField(
            controller: controller.textEditingController,
            onChanged: (text) {
              controller.onChange(text);
            },
          )
        ],
      ),
    );
  }
}
