class Student{
  int controlum;
  String name;
  String lastname;
  String surname;
  String matri;
  String mail;
  String tel;
  Student(this.controlum, this.name, this.surname, this.lastname, this.matri, this.mail, this.tel);
  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{
      'controlum':controlum,
      'name':name,
      'lastname':lastname,
      'surname':surname,
      'matri':matri,
      'mail':mail,
      'tel':tel
    };
    return map;
  }
  Student.fromMap(Map<String,dynamic> map){
    controlum=map['controlum'];
    name=map['name'];
    surname=map['lastname'];
    lastname=map['surname'];
    matri=map['matri'];
    mail=map['mail'];
    tel=map['tel'];
  }
}