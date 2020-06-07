import 'crud_operations.dart';
import 'student.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class select extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<select> {

  Future<List<Student>> Studentss;
  TextEditingController contr1 = TextEditingController();
  TextEditingController contr2 = TextEditingController();
  TextEditingController contr3 = TextEditingController();
  TextEditingController contr4 = TextEditingController();
  TextEditingController contr5 = TextEditingController();
  TextEditingController contr6 = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String name;
  String lastname;
  String surname;
  String mail;
  String tel;
  String matri;
  int currentUserId;
  String valor;
  int opcion;

  final formkey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;



  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }
  void refreshList() {
    setState(() {
      Studentss = dbHelper.busqueda(searchController.text);
    });
  }
  void cleanData() {
    searchController.text = "";
  }


  SingleChildScrollView dataTable(List<Student> Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Nombre"),
          ),
          DataColumn(
            label: Text("Primer apellido"),
          ),
          DataColumn(
            label: Text("Segundo apellido"),
          ),
          DataColumn(
            label: Text("Matricula"),
          ),
          DataColumn(
            label: Text("correo"),
          ),
          DataColumn(
            label: Text("Telefono"),
          ),
        ],
        rows: Studentss.map((student) => DataRow(cells: [



          DataCell(Text(student.name.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            contr1.text = student.name;
          }),

          DataCell(Text(student.surname.toString().toUpperCase()),
              onTap: () {
                setState(() {
                  isUpdating = true;
                  currentUserId = student.controlum;
                });
                contr2.text = student.surname;
              }),


          DataCell(Text(student.lastname.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            contr3.text = student.lastname;
          }),

          DataCell(Text(student.matri.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            contr6.text = student.matri;
          }),
          DataCell(Text(student.mail.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            contr4.text = student.mail;
          }),
          DataCell(Text(student.tel.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            contr5.text = student.tel;
          }),

        ])).toList(),
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Studentss,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("No hay datos!");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return new Scaffold(//new line
      appBar: new AppBar(
        title: isUpdating ? TextField(
            autofocus: true,
            controller: searchController,
            onChanged: (text){
              refreshList();
            })
            : Text("Buscar datos"),
        leading: IconButton(
          icon: Icon(isUpdating ? Icons.done: Icons.search),
          onPressed: (){
            print("En proceso..."+ isUpdating.toString());
            setState(() {
              isUpdating = !isUpdating;
              searchController.text = "";
            });
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            list(),
          ],
        ),
      ),
    );
  }
}