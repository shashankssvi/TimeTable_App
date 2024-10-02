import 'package:app2/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Hod extends StatelessWidget {
  const Hod({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Teacherview(),
    );
  }
}

class Teacherview extends StatefulWidget {
  const Teacherview({super.key});

  @override
  State<Teacherview> createState() => _TeacherviewState();
}

class _TeacherviewState extends State<Teacherview> {
  getwday(int a){
    Map<int,String> map1 = {1:"Mon",2:"Tue",3:"Wed",4:"Thu",5:"Fri",6:"Sat",0:"Sun"};
    return map1[a];
  }
  
  int btnvalue=0;

  @override
  void initState() {
    chang1();
    super.initState();
  }

  chang1(){
    setState(() {
      c0 = Colors.white;
       c1 = Colors.white;
       c2 = Colors.white;
       c3 = Colors.white;
      btnvalue==0?c0=Colors.green:btnvalue==1?c1=Colors.green:btnvalue==2?c2=Colors.green:c3=Colors.green;
    });
  }
  Color ?c0;
  Color ?c1;
  Color ?c2;
  Color ?c3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOD"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: c0,
              child: InkWell(
                onTap: (){
                  setState(() {
                    btnvalue=0;

                    chang1();
                  });
                },
                child: const Text("V0",),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: c1,
              child: InkWell(
                onTap: (){
                  setState(() {
                    btnvalue=1;

                    chang1();
                  });
                },
                child: const Text("V1",),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: c2,
              child: InkWell(
                onTap: (){
                  setState(() {
                    btnvalue=2;

                    chang1();
                  });
                },
                child: const Text("V2",),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: c3,
              child: InkWell(
                onTap: (){
                  setState(() {
                    btnvalue=3;

                    chang1();
                  });
                },
                child: const Text("V3",),
              ),
            ),
          )
        ],
      ),
      body: btnvalue==1?FutureBuilder(future: Utils.getdetailsforHODbyteacher(), builder: (context,AsyncSnapshot<dynamic> snapshot){
        if (snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasError){
          return Center(child: Text("${snapshot.error}"),);
        }
        else if(snapshot.hasData){
          List<List<dynamic>> data = snapshot.data;
          return ListView.builder(itemCount: data.length,itemBuilder: (context,index2){
            List<dynamic> alldata = [];
            List<dynamic> ndays=[];
            int wday1 = DateTime.now().weekday;
            for (int i=wday1;i<wday1+7;i++){
              ndays.add(i%7);
            }
            alldata=[];
            for (int i=0;i<ndays.length;i++){
              alldata.add(data[index2].where((value)=> value["dayOfWeek"]==getwday(ndays[i])).toList());
            }
            return Column(
              children: [
                Container(
                  child: Text("${data[index2][0]["teacher"]}",style: const TextStyle(fontSize: 28),),
                ),
                ListView.builder(physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount:alldata.length,itemBuilder: (context,index1){
                  List<dynamic> data2 = alldata[index1];
                  var dd = DateFormat("EEEE").format(DateTime.now().add(Duration(days: index1)));
                  return Column(
                    children: [
                      data2.isEmpty?Container():Container(
                        child: Text(dd,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color.fromRGBO(0, 0, 0, 0.5)),),
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
                }),
              ],
            );
          });
        }
        return const Text("data");
      }):btnvalue==0?
      FutureBuilder(future: Utils.getdetailsforHOD("CS"), builder: (context,AsyncSnapshot<dynamic> snapshot){
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
      }):btnvalue==2?
      FutureBuilder(future: Utils.getdetailsforHODbysubject(), builder: (context,AsyncSnapshot<dynamic> snapshot){
        if (snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasError){
          return Center(child: Text("${snapshot.error}"),);
        }
        else if(snapshot.hasData){
          List<List<dynamic>> data = snapshot.data;
          return ListView.builder(itemCount: data.length,itemBuilder: (context,index2){
            List<dynamic> alldata = [];
            List<dynamic> ndays=[];
            int wday1 = DateTime.now().weekday;
            for (int i=wday1;i<wday1+7;i++){
              ndays.add(i%7);
            }
            alldata=[];
            for (int i=0;i<ndays.length;i++){
              alldata.add(data[index2].where((value)=> value["dayOfWeek"]==getwday(ndays[i])).toList());
            }
            return Column(
              children: [
                Container(
                  child: Text("${data[index2][0]["subject"]}",style: const TextStyle(fontSize: 28),),
                ),
                ListView.builder(physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount:alldata.length,itemBuilder: (context,index1){
                  List<dynamic> data2 = alldata[index1];
                  var dd = DateFormat("EEEE").format(DateTime.now().add(Duration(days: index1)));
                  return Column(
                    children: [
                      data2.isEmpty?Container():Container(
                        child: Text(dd,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color.fromRGBO(0, 0, 0, 0.5)),),
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
                }),
              ],
            );
          });
        }
        return const Text("data");
      }):
      FutureBuilder(future: Utils.getdetailsforHODbyroomno(), builder: (context,AsyncSnapshot<dynamic> snapshot){
        if (snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasError){
          return Center(child: Text("${snapshot.error}"),);
        }
        else if(snapshot.hasData){
          List<List<dynamic>> data = snapshot.data;
          return ListView.builder(itemCount: data.length,itemBuilder: (context,index2){
            List<dynamic> alldata = [];
            List<dynamic> ndays=[];
            int wday1 = DateTime.now().weekday;
            for (int i=wday1;i<wday1+7;i++){
              ndays.add(i%7);
            }
            alldata=[];
            for (int i=0;i<ndays.length;i++){
              alldata.add(data[index2].where((value)=> value["dayOfWeek"]==getwday(ndays[i])).toList());
            }
            return Column(
              children: [
                Container(
                  child: Text("${data[index2][0]["roomNo"]}",style: const TextStyle(fontSize: 28),),
                ),
                ListView.builder(physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount:alldata.length,itemBuilder: (context,index1){
                  List<dynamic> data2 = alldata[index1];
                  var dd = DateFormat("EEEE").format(DateTime.now().add(Duration(days: index1)));
                  return Column(
                    children: [
                      data2.isEmpty?Container():Container(
                        child: Text(dd,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color.fromRGBO(0, 0, 0, 0.5)),),
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
                }),
              ],
            );
          });
        }
        return const Text("data");
      }),
    );
  }
}
