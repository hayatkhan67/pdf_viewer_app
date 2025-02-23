import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pdf_viewer_app/services/shared_prefs_service/shared_prefs_service.dart';

ValueNotifier<int> counter = ValueNotifier<int>(0); // ValueListenable object

initializeData() {
  log(Prefs().getCounter().toString());
  counter.value = Prefs().getCounter();
}

setData() {
  counter.value++;
  Prefs().setCounter(counter.value);
}
