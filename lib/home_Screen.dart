import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassCounTEControler = TextEditingController(
      text: '1');
    int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: const Text('Home'),backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,)
    ,

    body: SingleChildScrollView (
        child: Padding(
         padding:const EdgeInsets.all(16.0),
         child:Column(
              children: [
               const Text('Tap Hare To Eat Water'),
                const SizedBox(height: 16,),
                Text('Today\'s water eat : $count'),
                const SizedBox(height: 16,),
                   const SizedBox(height: 24,),
                   Container(
                  decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.amberAccent,width: 8,),
             ),

             child:const Padding(padding:const EdgeInsets.all(24.0),
           child:const Icon(Icons.water_drop_outlined,size: 32,),
          )
          ),
                SizedBox(
                  width: 60,

                 child: TextField(
                  controller: _glassCounTEControler ,
                   textAlign: TextAlign.center ,
                   keyboardType: TextInputType.number,
                ),
            ),
                const SizedBox(height:16),
                Text('History'),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Text('Time'),
                      leading: Text('Time'),
                    );
                  }

                )
        ],
       ),
        )
      ),

    );
  }
}
