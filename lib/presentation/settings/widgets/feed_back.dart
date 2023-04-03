
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:musician/controller/core/themes/back_gound_design.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';
import 'package:musician/presentation/widgets/back_drop_widget.dart';

class FeedBack extends StatelessWidget {
  FeedBack({super.key});

  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          const Blue(),
          const Purple(),
          const BackdropWidget(),
          SafeArea(
            child: SizedBox(
                height: double.infinity,
                child: ListView(
                  children: [
                    ListTile(
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 28,
                          color: Colors.white38,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: const Text(
                        'Feedback',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                          width: double.infinity,
                          height: 600,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextFormField(
                                    controller: nameController,
                                    style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500),
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.account_circle_outlined,
                                        color: componentsColor,
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      hintText: 'Name',
                                      filled: true,
                                      fillColor: Colors.deepPurple[50],
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Name";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  TextFormField(
                                    controller: subjectController,
                                    style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.subject_rounded,
                                        color: componentsColor,
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      hintText: 'Subject',
                                      filled: true,
                                      fillColor: Colors.deepPurple[50],
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Subject";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.email,
                                        color: componentsColor,
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      hintText: 'Email',
                                      filled: true,
                                      fillColor: Colors.deepPurple[50],
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Email";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  TextFormField(
                                    controller: messageController,
                                    style: TextStyle(color: componentsColor, fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.message,
                                        color: componentsColor,
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      hintText: 'Message',
                                      filled: true,
                                      fillColor: Colors.deepPurple[50],
                                    ),
                                    maxLines: 8,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Message";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          sendEmail();
                                          formKey.currentState!.reset();
                                          var mailSended = SnackBar(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            backgroundColor: componentsColor,
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              'Mail Send',
                                              style: TextStyle(color: Colors.deepPurple[50]),
                                              textAlign: TextAlign.center,
                                            ),
                                            duration: const Duration(seconds: 1),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(mailSended);
                                        }
                                      },
                                      child: const Text('Send Mail'))
                                ],
                              ),
                            ),
                          )),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  Future sendEmail() async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_qlhc0hq";
    const templateId = "template_h4j8uqx";
    const userId = "naRFjgTLJMUrigc3g";
    final response = await http.post(url,
        headers: {'origin': 'http://localhost', 'Content-Type': 'application/json'},
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "user_name": nameController.text,
            "user_subject": subjectController.text,
            "user_message": messageController.text,
            "user_email": emailController.text
          }
        }));
    return response.statusCode;
  }
}
