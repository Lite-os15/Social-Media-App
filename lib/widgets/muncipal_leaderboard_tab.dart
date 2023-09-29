import 'package:flutter/material.dart';

class ThirdTab extends StatefulWidget {
  const ThirdTab({super.key});

  @override
  State<ThirdTab> createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  @override
  Widget build(BuildContext context) {
    var list =['Navi Mumbai','Mumbai','Thane','Nashik','Solapur','Pune','Kolhapur','Nagpur','Latur','Sangli'];
    return  Scaffold(

     body: ListView.builder(
         itemCount: 10,
         itemBuilder:(BuildContextcontext,index){
           return Container(
             color: Colors.greenAccent.shade200,
             height: MediaQuery.of(context).size.height * 0.1,
             child: Card(
               // elevation: 20,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text('$index'),
                     const Padding(
                       padding: EdgeInsets.symmetric(horizontal: 12.0),
                       child: CircleAvatar(radius: 25,
                         backgroundImage: NetworkImage('https://images.unsplash.com/photo-1691335799851-ea2799a51ff0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60'),
                       ),
                     ),
                     Text(list[index]),
                   ],
                 ),
               ),

             ),
           );


     } ),
    );

  }
}
