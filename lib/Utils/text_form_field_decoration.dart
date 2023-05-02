import 'package:flutter/material.dart';

InputDecoration textFormFieldInputDecoration({
  required BuildContext context,
}) {
  return InputDecoration(
    filled: false,
    fillColor: Colors.white,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 0.8),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 0.8),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 0.8),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 0.8),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 0.8),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    contentPadding: const EdgeInsets.only(bottom: 0.0, left: 10.0, right: 10.0),
    errorStyle: Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: const Color(0xff7e7d7d), fontSize: 14),
    hintStyle: Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: const Color(0xff7e7d7d), fontSize: 14),
    labelStyle: Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: const Color(0xff7e7d7d), fontSize: 14),
  );
}
