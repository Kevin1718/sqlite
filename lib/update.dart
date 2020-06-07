import 'crud_operations.dart';
import 'student.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<Update> {

  Future<List<Student>> Studentss;
  TextEditingController contr1 = TextEditingController();
  TextEditingController contr2 = TextEditingController();
  TextEditingController contr3 = TextEditingController();
  TextEditingController contr4 = TextEditingController();
  TextEditingController contr5 = TextEditingController();
  TextEditingController contr6 = TextEditingController();
  String name;
  String lastname;
  String surname;
  String mail;
  String tel;
  String matri;
  int currentUserId;
  String valor;
  int opcion;
  String descriptive_text = "Campo";
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

  //select
  void refreshList() {
    setState(() {
      Studentss = dbHelper.getStudents();
    });
  }

  void cleanData() {
    contr1.text = "";
    contr2.text = "";
    contr3.text = "";
    contr4.text = "";
    contr5.text = "";
    contr6.text = "";
  }

  void updateData(){
    print("Opcion");
    print(opcion);
    if (formkey.currentState.validate()) {
      formkey.currentState.save();

      if (opcion==1) {
        Student stu = Student(currentUserId, valor, surname, lastname, mail, tel, matri);
        dbHelper.update(stu);
      }

      else if (opcion==2) {
        Student stu = Student(currentUserId, valor, surname, lastname, mail, tel, matri);
        dbHelper.update(stu);
      }

      else if (opcion==3) {
        Student stu = Student(currentUserId, valor, surname, lastname, mail, tel, matri);
        dbHelper.update(stu);
      }

      else if (opcion==4) {
        Student stu = Student(currentUserId, valor, surname, lastname, mail, tel, matri);
        dbHelper.update(stu);
      }

      else if (opcion==5) {
        Student stu = Student(currentUserId, valor, surname, lastname, mail, tel, matri);
        dbHelper.update(stu);
      }

      else if (opcion==6) {
        Student stu = Student(currentUserId, valor, surname, lastname, mail, tel, matri);
        dbHelper.update(stu);
      }
      cleanData();
      refreshList();
    }
  }

  void insertData() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      {
        Student stu = Student(null, name, surname, lastname, mail, tel, matri);
        dbHelper.insert(stu);
      }
      cleanData();
      refreshList();
    }
  }


  Widget form() {
    return Form(
      key: formkey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new SizedBox(height: 50.0),
            TextFormField(
              controller: contr1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: descriptive_text),
              validator: (val) => val.length == 0 ? 'Ingresar dato' : null,
              onSaved: (val) => valor = val,
            ),
            SizedBox(height: 30,),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blueAccent),
                  ),
                  onPressed: updateData,

                  child: Text('Actualizar datos alumno'),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    cleanData();
                    refreshList();
                  },
                  child: Text("Cancelar"),
                ),
              ],
            )
          ],
        ),
      ),
    );
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
            label: Text("Direccion de correo"),
          ),
          DataColumn(
            label: Text("Numero de telefono"),
          ),
        ],
        rows: Studentss.map((student) =>
            DataRow(cells: [

              DataCell(Text(student.name.toString().toUpperCase()), onTap: () {
                setState(() {

                  descriptive_text = "Nombre";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname = student.surname;
                  lastname = student.lastname;
                  tel =student.tel;
                  mail = student.mail;
                  matri = student.matri;
                  opcion=1;
                });
                contr1.text = student.name;
              }),

              DataCell(Text(student.lastname.toString().toUpperCase()), onTap: () {
                setState(() {

                  descriptive_text = "Primer apellido";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname = student.surname;
                  lastname = student.lastname;
                  tel =student.tel;
                  mail = student.mail;
                  matri = student.matri;
                  opcion=2;
                });
                contr2.text= student.surname;
              }),

              DataCell(Text(student.lastname.toString().toUpperCase()), onTap: () {
                setState(() {
                  descriptive_text = "Segundo apellido";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname = student.surname;
                  lastname = student.lastname;
                  tel =student.tel;
                  mail = student.mail;
                  matri = student.matri;
                  opcion=3;
                });
                contr3.text= student.lastname;
              }),

              DataCell(Text(student.matri.toString().toUpperCase()), onTap: () {
                setState(() {
                  descriptive_text = "Matricula";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname = student.surname;
                  lastname = student.lastname;
                  tel =student.tel;
                  mail = student.mail;
                  matri = student.matri;
                  opcion=4;
                });
                contr6.text = student.matri;
              }),
              DataCell(Text(student.mail.toString().toUpperCase()), onTap: () {
                setState(() {

                  descriptive_text = "Correo";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname = student.surname;
                  lastname = student.lastname;
                  tel =student.tel;
                  mail = student.mail;
                  matri = student.matri;
                  opcion=4;
                });
                contr4.text = student.mail;
              }),
              DataCell(Text(student.tel.toString().toUpperCase()), onTap: () {
                setState(() {
                  descriptive_text = "Numero de telefono";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname = student.surname;
                  lastname= student.lastname;
                  tel =student.tel;
                  mail = student.mail;
                  matri = student.matri;
                  opcion=4;
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
            return Text("No data founded!");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Text('Actualizar Datos'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}