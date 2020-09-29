import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: _body(context),
    );
  }

  Column _body(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('expos').snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  List<DocumentSnapshot> expos = snapshot.data.documents;
                  return ListView.builder(
                    itemCount: expos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(expos[index].data['local']),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}
