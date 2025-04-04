import 'package:flutter/material.dart';

class MyStack {
  List<String> stack = [];

  void push(String x) {
    stack.add(x);
  }

  void pop() {
    stack.removeLast();
  }

  String top() {
    return stack.last;
  }

  String getMin() {
    return stack.reduce((value, element) => value.compareTo(element) < 0 ? value : element);
  }

  void removeElement(String x) {
    stack.remove(x);
  }
}
