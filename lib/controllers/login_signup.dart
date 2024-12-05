import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSignupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isPasswordVisible = false.obs; // Reactive password visibility state

  late TabController tabController;

  @override
  void onInit() {
    // Initialize the TabController with a valid TickerProvider
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    // Dispose the TabController when the controller is destroyed
    tabController.dispose();
    super.onClose();
  }
}
