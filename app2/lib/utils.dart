import 'dart:convert';

import 'package:http/http.dart' as http;
class Utils{
  static getdetails()async{
    var url = Uri.parse("http://139.162.60.69:8080/TimeTable1/getAll");
    try{
      var response = await http.get(url);
      if (response.statusCode==200){
        return jsonDecode(response.body);
      }
    }
    catch(e){
      return "$e";
    }
  }

  static getdetailsbyyercou(year,course, college, section)async{
    var url = Uri.parse("http://139.162.60.69:8080/TimeTable1/getAll");
    List<dynamic> map1 = [];
    try{
      var response = await http.get(url);
      List<dynamic> data = jsonDecode(response.body);
      if (response.statusCode==200){
        map1.addAll(data.where((value)=> value["course"]==course && value["year"]==year && value["cname"]==college && value["section"]==section).toList());
      }
      return map1;
    }
    catch(e){
      return "$e";
    }
  }

  static getdetailsbyteachern(name)async{
    var url = Uri.parse("http://139.162.60.69:8080/TimeTable1/getAll");
    List<dynamic> map1 = [];
    try{
      var response = await http.get(url);
      List<dynamic> data = jsonDecode(response.body);
      if (response.statusCode==200){
        map1.addAll(data.where((value)=> value["teacher"]==name).toList());
      }
      return map1;
    }
    catch(e){
      return "$e";
    }
  }
  
  static getdetailsforHOD(course)async{
    var url = Uri.parse("http://139.162.60.69:8080/TimeTable1/getAll");
    List<dynamic> map1 = [];
    try{
      var response = await http.get(url);
      if (response.statusCode==200){
        List<dynamic> data = jsonDecode(response.body);
        map1.addAll(data.where((value)=> value["course"]==course).toList());
      }
      return map1;
    }
    catch(e){
      return "$e";
    }
  }
  
  static getdetailsforHODbyteacher()async{
    var url = Uri.parse("http://139.162.60.69:8080/TimeTable1/getAll");
    List<List<dynamic>> map1 = [];
    try{
      var response = await http.get(url);
      if (response.statusCode==200){
        List<dynamic> data = jsonDecode(response.body);
        Set<dynamic> set1 = {};
        for(dynamic i in data){
          set1.add(i["teacher"]);
        }
        List<dynamic> tname = set1.toList();
        tname.sort();
        for (int i=0;i<tname.length;i++){
          map1.addAll([data.where((value)=>value["teacher"]==tname[i]).toList()]);
        }
      }
      return map1;
    }
    catch(e){
      return "$e";
    }
  }

  static getdetailsforHODbysubject()async{
    var url = Uri.parse("http://139.162.60.69:8080/TimeTable1/getAll");
    List<List<dynamic>> map1 = [];
    try{
      var response = await http.get(url);
      if (response.statusCode==200){
        List<dynamic> data = jsonDecode(response.body);
        Set<dynamic> set1 = {};
        for(dynamic i in data){
          set1.add(i["subject"]);
        }
        List<dynamic> tname = set1.toList();
        tname.sort();
        for (int i=0;i<tname.length;i++){
          map1.addAll([data.where((value)=>value["subject"]==tname[i]).toList()]);
        }
      }
      return map1;
    }
    catch(e){
      return "$e";
    }
  }

  static getdetailsforHODbyroomno()async{
    var url = Uri.parse("http://139.162.60.69:8080/TimeTable1/getAll");
    List<List<dynamic>> map1 = [];
    try{
      var response = await http.get(url);
      if (response.statusCode==200){
        List<dynamic> data = jsonDecode(response.body);
        Set<dynamic> set1 = {};
        for(dynamic i in data){
          set1.add(i["roomNo"]);
        }
        List<dynamic> tname = set1.toList();
        tname.sort();

        for (int i=0;i<tname.length;i++){
          map1.addAll([data.where((value)=>value["roomNo"]==tname[i]).toList()]);
        }
      }

      return map1;
    }
    catch(e){
      return "$e";
    }
  }



  static getdetailsforprincipalbyperiod()async{
    var url = Uri.parse("http://139.162.60.69:8080/TimeTable1/getAll");
    List<List<dynamic>> map1 = [];
    try{
      var response = await http.get(url);
      if (response.statusCode==200){
        List<dynamic> data = jsonDecode(response.body);
        Set<dynamic> set1 = {};
        for(dynamic i in data){
          set1.add(i["periodNo"]);
        }
        List<dynamic> tname = set1.toList();
        tname.sort();
        for (int j=0;j<data.length;j++){
          for (int i=0;i<tname.length;i++){
            map1.addAll([data.where((value)=>value["periodNo"]==tname[i] && value["dayOfWeek"]=="Mon").toList()]);
          }
        }
      }

      return map1;
    }
    catch(e){
      return "$e";
    }
  }
}