import 'package:app2/main2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  fileread()async{
    var str1 = await rootBundle.loadString('TimeTable/tt1.txt');
    return str1;
  }

  List<dynamic> final1 = [];
  getwday(int a){
    Map<int,String> map1 = {1:"Mon",2:"Tue",3:"Wed",4:"Thu",5:"Fri",6:"Sat",0:"Sun"};
    return map1[a];
  }

  @override
  void initState() {
    fileread();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(""),
      ),
      body: Center(
        child: FutureBuilder(future: fileread(), builder: (context,snapshot){
          if (snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if (snapshot.hasError){
            return Text("${snapshot.error}");
          }
          else if (snapshot.hasData){
            var data = snapshot.data;
            List<String> list1 = data.toString().split("\n");
            List<dynamic> ndays=[];
            int wday1 = DateTime.now().weekday;
            for (int i=wday1;i<wday1+7;i++){
              ndays.add(i%7);
            }
            final1=[];
            list1 = list1.map((line) => line.trim()).toList();
            for (int i=0;i<ndays.length;i++){
              final1.add(list1.where((value)=> value.split(",")[0]==getwday(ndays[i])).toList());
            }
            return ListView.builder(shrinkWrap: true,itemCount: final1.length,itemBuilder: (context,index){
              List<dynamic> split1 = final1[index];
              return Column(
                children: [
                  Container(
                    child: Text(DateFormat("EEEE").format(DateTime.now().add(Duration(days: index))),style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  ),
                  ListView.builder(physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: split1.length,itemBuilder: (context,index1){
                    List<dynamic> list2 = split1[index1].split(",");
                    return Container(
                      child:list2.length>3?ListTile(
                        leading: Text("${list2.elementAtOrNull(2)}",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        trailing: Text("${list2.elementAtOrNull(1)}\n${list2.elementAtOrNull(5)}"),
                        title: Text("${list2.elementAtOrNull(3)}",style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("${list2.elementAtOrNull(4)}"),
                      ):Container(
                        child: ListTile(
                          title: Text("${list2.elementAtOrNull(1)}",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        ),
                      )
                    );
                  }),
                ],
              );
            });
          }
          return const Text("data");
        }),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Api1()));
      },
      child: const Text("API->"),),
    );
  }
}
