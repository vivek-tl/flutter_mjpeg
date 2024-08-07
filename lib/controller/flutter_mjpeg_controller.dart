import 'package:flutter/material.dart';

class FlutterMjpegController {
  MemoryImage? _frame;

  void set setFrame(MemoryImage frame) => _frame = frame;
  MemoryImage? get getFrame => _frame;
}
