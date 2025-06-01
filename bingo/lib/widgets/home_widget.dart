import 'dart:ui';
import 'package:bingo/widgets/custom_main_button_widget.dart';
import 'package:bingo/widgets/theatre_creation_form_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showForm = false;
  final TextEditingController _theatreNameController = TextEditingController();

  void _onCreateTheatre() {
    setState(() {
      _showForm = true;
    });
  }

  void _onJoinTheatre() {
    print('Join theatre clicked');
    // TODO: ajouter logique pour rejoindre un théâtre
  }

  void _onSubmitForm() {
    print('Creating theatre: ${_theatreNameController.text}');
    // TODO: logique pour créer le théâtre
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Theatre "${_theatreNameController.text}" créé !')),
    );
    setState(() {
      _showForm = false;
      _theatreNameController.clear();
    });
  }

  @override
  void dispose() {
    _theatreNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final List<TextEditingController> _bingoControllers =
        List.generate(24, (_) => TextEditingController());

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child:
                Container(color: Colors.black.withAlpha((0.6 * 255).round())),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha((0.7 * 255).round()),
                  borderRadius: BorderRadius.circular(16.0),
                  border:
                      Border.all(color: Colors.redAccent.shade200, width: 2.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.shade200
                          .withAlpha((0.6 * 255).round()),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'CINEMATES',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent.shade200,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _showForm
                        ? TheatreCreationForm(
                            controller: _theatreNameController,
                            onSubmit: _onSubmitForm,
                            onCancel: () {
                              setState(() {
                                _showForm = false;
                                _theatreNameController.clear();
                                for (var c in _bingoControllers) {
                                  c.clear();
                                }
                              });
                            },
                            bingoControllers: _bingoControllers,
                          )
                        : (screenWidth < 500
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CustomMainButton(
                                    text: "Create theatre",
                                    onPressed: _onCreateTheatre,
                                  ),
                                  const SizedBox(height: 16),
                                  CustomMainButton(
                                    text: "Join theatre",
                                    onPressed: _onJoinTheatre,
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomMainButton(
                                    text: "Create theatre",
                                    onPressed: _onCreateTheatre,
                                  ),
                                  const SizedBox(width: 16),
                                  CustomMainButton(
                                    text: "Join theatre",
                                    onPressed: _onJoinTheatre,
                                  ),
                                ],
                              )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
