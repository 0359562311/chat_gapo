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
                        .map((e) => InkWell(
                            onTap: () {
                              controller.setTag(e);
                            },
                            child: Text(e.displayName ?? "haha")))
                        .toList(),
                  ),
                ),
                visible: controller.suggestions.isNotEmpty,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: controller.textEditingController,
            ),
          )
        ],
      ),
    );
  }
}
