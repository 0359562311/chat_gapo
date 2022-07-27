import 'package:base_flutter/screens/rich_input/rich_input_controller.dart';
import 'package:base_flutter/theme/colors.dart';
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
          Expanded(
            child: Obx(() => Visibility(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.suggestions.value
                        .map((e) => InkWell(
                            onTap: () {
                              controller.setTag(e);
                            },
                            child: Text(e.displayName ?? "haha")))
                        .toList(),
                  ),
                  visible: controller.suggestions.isNotEmpty,
                )),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller.textEditingController,
              maxLength: 5000,
              textInputAction: TextInputAction.newline,
              maxLines: null,
            ),
          )
        ],
      ),
    );
  }
}
