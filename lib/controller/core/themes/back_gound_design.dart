import 'package:flutter/material.dart';

class Blue extends StatelessWidget {
  const Blue({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 250,
            width: 120,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 23, 44, 202),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200), topLeft: Radius.circular(200))),
          ),
        ],
      ),
    );
  }
}

class Purple extends StatelessWidget {
  const Purple({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: 120,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 149, 9, 149),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(200), topRight: Radius.circular(200))),
          ),
        ],
      ),
    );
  }
}
