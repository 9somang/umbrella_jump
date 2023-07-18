import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class RankOverlay extends StatefulWidget {
  const RankOverlay(this.game, {super.key});

  final Game game;

  @override
  State<RankOverlay> createState() => _RankOverlayState();
}

class _RankOverlayState extends State<RankOverlay> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          color: Theme.of(context).colorScheme.background,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 600,
                minWidth: 500,
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 70),
                      Text(
                        'Rank',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 30),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                              width: 500,
                              height: 600,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('ranks')
                                    .orderBy("score", descending: true)
                                    .orderBy("level", descending: true)
                                    .limit(10)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        final DocumentSnapshot
                                            documentSnapshot =
                                            snapshot.data!.docs[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1, vertical: 6),
                                          child: Card(
                                            child: ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${index + 1}위' +
                                                        '\n' +
                                                        documentSnapshot[
                                                            'name'],
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              subtitle: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Score : ' +
                                                        documentSnapshot[
                                                                'score']
                                                            .toString(),
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text(
                                                    'Map Level : ' +
                                                        documentSnapshot[
                                                                'level']
                                                            .toString(),
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return CircularProgressIndicator();
                                },
                              )),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'close',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
