import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Band> bands = [
    Band( id: '1', name: 'Metallica', votes: 5),
    Band( id: '2', name: 'Banda', votes: 5),
    Band( id: '3', name: 'Rock', votes: 5),
    Band( id: '4', name: 'Electronica', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Band Names", 
          style: TextStyle( color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {  
          return _bandTile(bands[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile( Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ){
        print('direction: $direction');
        print('id: ${band.id}');
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.redAccent,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle( color: Colors.white),),
        ),
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text( band.name.substring(0,2)),
              backgroundColor: Colors.blue,
            ),
            title: Text( band.name ),
            trailing: Text('${ band.votes }', style: TextStyle( fontSize: 20.0),),
            onTap: (){
              print(band.name);
            },
          ),
    );
  }

  addNewBand(){

    final textController = new TextEditingController();

    showDialog(
      context: context, 
      builder: ( context ) {
        return AlertDialog(
          title: Text('New band name: '),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              child: Text('Add'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addBandToList(textController.text)
            )
          ],
        );
      }
    );
  }

  void addBandToList( String name){
    if( name.length > 1 ){
      //Podemos agregar
      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}