import 'package:flutter/material.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> membersList = [
      'Anshuman', 'Aryaman', 'Indra', 'Twashta', 'Dhatu', 'Parjanya', 'Pusha', 'Bhag',
      'Mitra', 'Varuna', 'Vivaswana', 'Vishnu','Vasu' ,'Aap', 'Dhruva', 'Soma', 'Dhar',
      'Anil', 'Anal', 'Pratyusha', 'Prabhasa', 'Shambhu', 'Pinaki', 'Girish', 'Sthanu',
      'Bharga', 'Bhava', 'Sadashiva', 'Shiva', 'Hara', 'Sharva', 'Kapali'
    ];
    return  Scaffold(
      appBar: AppBar(
        title: Text('Group Members'),

      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){},),

      body: ListView.builder(
          itemCount: membersList.length,
          itemBuilder:(BuildContextcontext,index){
            return Card(

              elevation: 15,
              child: ListTile(
                minVerticalPadding: 30,


                    leading:CircleAvatar(
                      foregroundImage: NetworkImage('https://images.unsplash.com/photo-1691335799851-ea2799a51ff0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60'),
                      backgroundColor: Colors.grey,
                    ),

                    title:Text(membersList[index]),
                subtitle: Text('Admin'),

                ),
              );




          } ),
    );

  }
}
