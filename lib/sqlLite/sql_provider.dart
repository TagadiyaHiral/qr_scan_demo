import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider
{
  DBProvider._();
  static final DBProvider db=DBProvider._();
}
Database? remainder;

Future<Database?>get initdatabase async{
  if(remainder!=null)
  {
    return remainder;
  }
  remainder=await initDB();
  return remainder;
}

initDB()async{
  Directory documentsDirectory=await getApplicationDocumentsDirectory();
  String  path=join(documentsDirectory.path,"userdata.db");

  return await openDatabase(path,version: 1,onOpen: (db){},
      onCreate:(Database db,int version)async{
        await db.execute("CREATE TABLE UserQR("
            "id INTEGER PRIMARY KEY AUTOINCREMENT ,"
            "name TEXT,"
            "date TEXT" ")");
        print("Create database");
      });
}

Rmd remaifromJson(String str)
{
  final jsonData=json.decode(str);
  return Rmd.fromMap(jsonData);

}
String remaiToJson(Rmd data)
{
  final dm=data.toMap();
  return json.encode(dm);
}
class Rmd
{
  int id;
  String name;
  String date;

  static final columns=["id","name","date"];

  Rmd({
    required this.id,
    required this.name,
    required this.date,

  });

  factory Rmd.fromMap(Map<dynamic,dynamic>json)=>Rmd
    (id: json["id"],
      name: json["name"],
      date: json["date"],

    );

  Map<String,dynamic>toMap()=>{
    "id":id,
    "name":name,
    "date":date,
  };
}

