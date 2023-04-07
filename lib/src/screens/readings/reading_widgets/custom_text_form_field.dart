import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        labelText: labelText,
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}









// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;

//   CustomTextField({required this.hintText, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
// }

// Usage
// CustomTextField(
//   hintText: 'Enter your name',
//   controller: TextEditingController(),
// ),


/* ------------------------------- Example Two ------------------------------ */
// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   final bool obscureText;
//   final TextInputType keyboardType;
//   final TextInputAction textInputAction;
//   final Function(String)? onChanged;

//   CustomTextField({
//     required this.hintText,
//     required this.controller,
//     this.obscureText = false,
//     this.keyboardType = TextInputType.text,
//     this.textInputAction = TextInputAction.done,
//     this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       textInputAction: textInputAction,
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
// }


/* ---------------------------------- Usage --------------------------------- */
// class MyForm extends StatefulWidget {
//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           CustomTextField(
//             hintText: 'Enter your name',
//             controller: _nameController,
//             onChanged: (value) {
//               setState(() {});
//             },
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 // Form is valid, do something with the data
//                 String name = _nameController.text;
//                 // ...
//               }
//             },
//             child: Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
// }
