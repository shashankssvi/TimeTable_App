import 'package:app2/hod.dart';
import 'package:app2/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Main2 extends StatelessWidget {
  const Main2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Api1(),
    );
  }
}

class Api1 extends StatefulWidget {
  const Api1({super.key});

  @override
  State<Api1> createState() => _Api1State();
}

class _Api1State extends State<Api1> {

  Future<dynamic> ?future;
  
  getwday(int a){
    Map<int,String> map1 = {1:"Mon",2:"Tue",3:"Wed",4:"Thu",5:"Fri",6:"Sat",0:"Sun"};
    return map1[a];
  }

  static List<String> course = ["CS","EC"];
  static List<int> years = [2,3];
  static List<String> college =["4MW","4PS"];
  static List<String> section =["B","A"];
  static List<String> role =["student","teacher","HOD","principal"];

  String d1 = college.first;
  int d3 = years.first;
  String d2 = course.first;
  String d4 = section.first;
  String d5 = role.first;

  @override
  void initState() {
    future = Utils.getdetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api"),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Teacherview()));
          }, child: const Text("V1",style: TextStyle(fontSize: 18,),)),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Teacherview()));
          }, child: const Text("V2",style: TextStyle(fontSize: 18,),))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 100,
            ),
            DropdownButton(
              value: d1,
                items: college.map<DropdownMenuItem<String>>((value){
              return DropdownMenuItem(value: value,child: Text(value),);
            }).toList(), onChanged: (values){
              setState(() {
                d1=values!;
              });
            }),
            DropdownButton(
                value: d2,
                items: course.map<DropdownMenuItem<String>>((value){
                  return DropdownMenuItem(value: value,child: Text(value),);
                }).toList(), onChanged: (values){
              setState(() {
                d2=values!;
              });
            }),
            DropdownButton(
                value: d3,
                items: years.map<DropdownMenuItem<int>>((value){
                  return DropdownMenuItem(value: value,child: Text("$value"),);
                }).toList(), onChanged: (values){
              setState(() {
                d3=values!;
              });
            }),
            DropdownButton(
                value: d4,
                items: section.map<DropdownMenuItem<String>>((value){
              return DropdownMenuItem(value: value,child: Text(value),
              );
            }).toList(),
                onChanged: (value){
                  setState(() {
                    d4=value!;
                  });
            }),
            DropdownButton(
              value: d5,
                items: role.map<DropdownMenuItem<String>>((value){
                  return DropdownMenuItem(value: value,child: Text(value),);
                }).toList(),
                onChanged: (values){
                  setState(() {
                    d5 =values!;
                  });
                }),
            TextButton(onPressed: (){
              setState(() {
                print(d3);
                if (d5==role[1]){
                  future=Utils.getdetailsbyteachern("Mr Kuthyar");
                }
                else if (d5==role[2]){
                  future=Utils.getdetailsforHOD(d2);
                }
                else if (d5==role[3]){
                  future=Utils.getdetailsforprincipalbyperiod();
                }
                else{
                  future=Utils.getdetailsbyyercou(d3, d2, d1, d4);
                }
              });
            }, child: const Text("filter"))
          ],
        )
      ),
      body: d5==role[3]?
      FutureBuilder(future: Utils.getdetailsforprincipalbyperiod(), builder: (context,AsyncSnapshot<dynamic> snapshot){
        if (snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasError){
          return Center(child: Text("${snapshot.error}"),);
        }
        else if(snapshot.hasData){
          List<List<dynamic>> data = snapshot.data;
          return ListView.builder(itemCount: data.length,itemBuilder: (context,index){

            return Card(
              child: Text("${data[index]}"),
            );
          });
        }
        return const Text("data");
      }):
      FutureBuilder(future: future, builder: (context,AsyncSnapshot<dynamic> snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircleAvatar(),);
        }
        else if(snapshot.hasError){
          return Center(child: Text("${snapshot.error}"),);
        }
        else if(snapshot.hasData){
          List<dynamic> alldata = [];
          List<dynamic> data = snapshot.data;
          List<dynamic> ndays=[];
          int wday1 = DateTime.now().weekday;
          for (int i=wday1;i<wday1+7;i++){
            ndays.add(i%7);
          }
          alldata=[];
          for (int i=0;i<ndays.length;i++){
            alldata.add(data.where((value)=> value["dayOfWeek"]==getwday(ndays[i])).toList());
          }
          return ListView.builder(shrinkWrap: true,itemCount:alldata.length,itemBuilder: (context,index1){
            var data2 = alldata[index1];
            return Column(
              children: [
                Container(
                  child: Text(DateFormat("EEEE").format(DateTime.now().add(Duration(days: index1))),style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                ),
                ListView.builder(physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: data2.length,itemBuilder: (context,index){
                  var data1 = data2[index];
                  return ListTile(
                    title: Text("${data1["subject"]}     ${data1["course"]} ${data1["year"]} ${data1["section"]} "),
                    subtitle: Text("${data1["teacher"]}"),
                    leading: Text("${data1["periodNo"]}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    trailing: Text("${data1["roomNo"]}"),
                  );
                }),
              ],
            );
          });
        }
        return const Center(child: Text("No content found"));
      }),
    );
  }
}
