//import 'dart:html';

//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for custom labeled checkbox.

void main() {
  runApp(WishCreationApp());
}

class WishCreationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishlist',
      theme: ThemeData(
        fontFamily: 'Roboto-Bold',
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 157, 140, 231)),
        useMaterial3: true,
      ),
      home: WishCreationPage(),
    );
  }
}

class WishCreationPage extends StatefulWidget {
  @override
  _WishCreationPageState createState() => _WishCreationPageState();
}

class _WishCreationPageState extends State<WishCreationPage> {
  bool? check = false;
  List<bool> checkboxes = [];
  List<TextEditingController> controllers = [];
  List<DateTime?> dates = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Add your wish"),
            backgroundColor: Color.fromARGB(255, 157, 140, 231)
        ),
        body: ListView.builder(
            itemCount: checkboxes.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: Checkbox(
                  value: checkboxes[index],
                  onChanged: (bool? value) {
                    setState(() {
                      checkboxes[index] = value!;
                    });
                  },
                ),
              
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: controllers[index],
                        decoration: InputDecoration(
                          hintText: 'Add a wish ${index + 1}',
                        ),
                        onEditingComplete: () {
                          _addNewCheckbox();
                        }
                      ),
                      if (dates[index] != null)
                      Text(
                        'Date: ${_formatDateTime(dates[index]!)}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                    
                
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          _selectDate(context, index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          _removeCheckbox(index);
                        },
                      ),
                    ],
                  ),


                  
              );
            },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
              if (controllers.isEmpty || controllers.last.text.isNotEmpty) {
                  _addNewCheckbox();
                }
              },
              tooltip: 'Add an item',
              child: Icon(Icons.add),
              ),
            );
          }
          void _addNewCheckbox(){
            setState(() {
              checkboxes.add(false);
              controllers.add(TextEditingController());
              dates.add(null);
            });
          }

          void _removeCheckbox(int index) {
            setState(() {
              checkboxes.removeAt(index);
              controllers.removeAt(index);
              dates.removeAt(index);
            });
          }

          Future<void> _selectDate(BuildContext context, int index) async {
            final DateTime? picked = await showDatePicker(
              context: context, 
              initialDate: DateTime.now(), 
              firstDate: DateTime(2000), 
              lastDate: DateTime(2101),
            );
            if (picked != null && mounted) {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context, 
                initialTime: TimeOfDay.now()
              );
              if (pickedTime != null && mounted) {
                setState(() {
                  dates[index] = DateTime(
                    picked.year,
                    picked.month,
                    picked.day,
                    pickedTime.hour,
                    pickedTime.minute
                    );
                  });
              }
            }
          }
           String _formatDateTime(DateTime dateTime) {
            final String day = dateTime.day.toString().padLeft(2, '0');
            final String month = dateTime.month.toString().padLeft(2, '0');
            final String year = dateTime.year.toString();
            final String hour = dateTime.hour.toString().padLeft(2, '0');
            final String minute = dateTime.minute.toString().padLeft(2, '0');
            return '$day/$month/$year $hour:$minute';
          }
          
  }

