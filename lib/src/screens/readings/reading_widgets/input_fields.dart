import 'package:flutter/material.dart';

List<Map<String, dynamic>> inputFields = [
  {
    'labelText': 'Name',
    'prefixIcon': Icons.person,
    'validator': (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
      return null;
    },
    'onSaved': (value) {
      // do something with the value
    },
  },
  {
    'labelText': 'Email',
    'prefixIcon': Icons.mail,
    'validator': (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Please enter a valid email';
      }
      return null;
    },
    'onSaved': (value) {
      // do something with the value
    },
  },
];
