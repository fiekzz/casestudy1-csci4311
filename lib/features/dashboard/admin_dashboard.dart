import 'dart:async';

import 'package:casestudy1/utils/api_manager.dart';
// import 'package:casestudy1/utils/models/get_all_staff_Model.dart';
// import 'package:casestudy1/utils/models/get_user_details_model.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({
    super.key,
    required this.userID,
  });

  final String userID;


  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late Future<void> fetchAndSetAllStaff;
  late List<Employee> employees;

  @override
  void initState() {
    super.initState();
    fetchAndSetAllStaff = getStaff();
    employees = [];
  }

  Future<void> getStaff() async {
  try {
    final response = await ApiManager.getAllStaff();

    final data = response.data;

    List<Employee> tempEmployee = [];

    data?.forEach((e) {
      tempEmployee.add(Employee(
          name: e.fullName ?? '',
          hours: e.paymentByWeek
              ?.fold(0, (previousValue, element) => previousValue + (element.totalHours ?? 0))
              .toInt() ??
              0));
    });

    setState(() {
      employees = List.from(tempEmployee);
    });
  } catch (e) {
    print('Error fetching staff data: $e');
    // Handle error gracefully, e.g., show an error message to the user
  }
}

  String selectedEmployee = '';
  TextEditingController hoursController = TextEditingController();

  void addHours(int hours) {
    setState(() {
      final index = employees.indexWhere((employee) => employee.name == selectedEmployee);
      if (index != -1) {
        employees[index].hours += hours;
      }
    });
  }

  void removeHours(int hours) {
    setState(() {
      final index = employees.indexWhere((employee) => employee.name == selectedEmployee);
      if (index != -1) {
        employees[index].hours -= hours;
        if (employees[index].hours < 0) {
          employees[index].hours = 0;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: FutureBuilder<void>(
        future: fetchAndSetAllStaff,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('${employees[index].name}: ${employees[index].hours} hours'),
                        onTap: () {
                          setState(() {
                            selectedEmployee = employees[index].name;
                          });
                        },
                        selected: selectedEmployee == employees[index].name,
                      );
                    },
                  ),
                ),
                if (selectedEmployee.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text('Modify Hours for $selectedEmployee'),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => addHours(1),
                              child: Text('Add 1 Hour'),
                            ),
                            ElevatedButton(
                              onPressed: () => addHours(5),
                              child: Text('Add 5 Hours'),
                            ),
                            ElevatedButton(
                              onPressed: () => removeHours(1),
                              child: Text('Remove 1 Hour'),
                            ),
                            ElevatedButton(
                              onPressed: () => removeHours(5),
                              child: Text('Remove 5 Hours'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}

class Employee {
  final String name;
  int hours;

  Employee({required this.name, required this.hours});
}