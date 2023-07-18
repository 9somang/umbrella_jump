import 'package:doodle_dash/game/umbrella_jump.dart';
import 'package:doodle_dash/game/widgets/widgets.dart';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class NameOverlay extends StatefulWidget {
  NameOverlay(this.game, {super.key});

  final Game game;

  @override
  State<NameOverlay> createState() => _NameOverlayState();
}

TextEditingController namecontroller = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
bool myenabled = true;

class _NameOverlayState extends State<NameOverlay> {
  @override
  Widget build(BuildContext context) {
    UmbrellaJump game = widget.game as UmbrellaJump;

    return Scaffold(
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 300,
                height: 300,
                image: AssetImage(
                  'assets/images/game/umbrellajump.png',
                ),
              ),
              WhiteSpace(height: 35),
              Text(
                'Umbrella Jump',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name :',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    width: 250,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: namecontroller,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Your Name!!!!!!!!!!!";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    game.gameManager.insertedName(namecontroller.text);
                    game.outName();
                    print(namecontroller.text);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Let\'s go',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
