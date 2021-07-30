import 'package:flutter/material.dart';

class TextFieldPadrao extends StatelessWidget {
  final Function(String mensagem) onChanged;
  final String titulo, value;
  final bool obscureText;
  const TextFieldPadrao(
      {Key key,
      this.onChanged,
      this.titulo,
      this.obscureText = false,
      this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 7), child: Text("$titulo")),
              visible: titulo?.isNotEmpty ?? false),
          Container(
              height: 50,
              child: TextField(
                  controller: TextEditingController(text: value ?? ""),
                  obscureText: obscureText,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Type here",
                      fillColor: Colors.white70)))
        ]);
  }
}
