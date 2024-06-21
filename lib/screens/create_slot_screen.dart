import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class CreateSlotScreen extends StatefulWidget {
  @override
  _AddSlotsFormState createState() => _AddSlotsFormState();
}

class _AddSlotsFormState extends State<CreateSlotScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _matchTitleController = TextEditingController();
  final TextEditingController _matchDateController = TextEditingController();
  List<TextEditingController> _teamControllers = [];

  @override
  void initState() {
    super.initState();
    _addTeamField(); // Initialize with one team field
  }

  void _addTeamField() {
    if (_teamControllers.length < 25) {
      setState(() {
        _teamControllers.add(TextEditingController());
      });
    } else {
      Fluttertoast.showToast(msg: "You can only add up to 25 teams.");
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final List<String> teams =
        _teamControllers.map((controller) => controller.text).toList();
    if (teams.contains('')) {
      Fluttertoast.showToast(msg: "Please fill out all team fields.");
      return;
    }

    final formData = {
      'organizationName': _organizationNameController.text,
      'matchTitle': _matchTitleController.text,
      'matchDate': _matchDateController.text,
      'teams': teams,
    };

    try {
      final response = await http.post(
        Uri.parse("https://tournatracks.onrender.com/api/auth/slots"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Slots successfully created!");
        _formKey.currentState!.reset();
        setState(() {
          _teamControllers.clear();
          _addTeamField(); // Reinitialize with one team field
        });
      } else {
        throw Exception("Failed to create slots.");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Failed to create slots. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 19, 20, 21),
              Color.fromARGB(255, 20, 26, 28),
              Color.fromARGB(255, 12, 20, 24)
            ],
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Create Slots for Teams",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _organizationNameController,
                    decoration: InputDecoration(
                      labelText: "Organization Name",
                      labelStyle: TextStyle(color: Colors.orange),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the organization name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _matchTitleController,
                    decoration: InputDecoration(
                      labelText: "Match Title",
                      labelStyle: TextStyle(color: Colors.orange),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the match title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _matchDateController,
                    decoration: InputDecoration(
                      labelText: "Match Date",
                      labelStyle: TextStyle(color: Colors.orange),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the match date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Enter Team Names",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    child: Scrollbar(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _teamControllers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: TextFormField(
                              controller: _teamControllers[index],
                              decoration: InputDecoration(
                                labelText: "Team ${index + 1}",
                                labelStyle: TextStyle(color: Colors.orange),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the team name';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addTeamField,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Add Team",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Create Slots",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _organizationNameController.dispose();
    _matchTitleController.dispose();
    _matchDateController.dispose();
    _teamControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
