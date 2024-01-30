import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/bloc/user/user_bloc.dart';
import 'package:textfield_tags/textfield_tags.dart';

class FormInterest extends StatefulWidget {
  const FormInterest({Key? key}) : super(key: key);
  @override
  _FormInterest createState() => _FormInterest();
}

class _FormInterest extends State<FormInterest> {
  late List<String>? interests;

  final List<String> tags = [];
  final TextEditingController tagController = TextEditingController();
  late double _distanceToField;
  late TextfieldTagsController _controller;

  @override
  void didChangeDependencies() {
    interests = ModalRoute.of(context)!.settings.arguments as List<String>?;
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

  saveProfile() {
    BlocProvider.of<UserBloc>(context)
        .add(UpdateInterestEvent(interests: _controller.getTags));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              Navigator.pop(context);
            } else if (state is ProfileFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Stack(
            children: [
              // background
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF09141A),
                      Color(0xFF0D1C22),
                      Color(0xFF1F4247)
                    ],
                  ),
                ),
              ),
              // header
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leadingWidth: 100,
                  leading: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.chevron_left, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => {saveProfile()},
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4599DB),
                            fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),

              // Form interest
              Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 18),
                        child: Text(
                          'Tell everyone about yourself',
                          style: TextStyle(
                            color: Color(0xFF93773E),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            decorationColor: Color(0xFF93773E),
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 18),
                        child: Text(
                          'What interest you?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFieldTags(
                        textfieldTagsController: _controller,
                        initialTags: interests,
                        textSeparators: const [' ', ','],
                        letterCase: LetterCase.normal,
                        inputfieldBuilder:
                            (context, tec, fn, error, onChanged, onSubmitted) {
                          return ((context, sc, tags, onTagDelete) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: tec,
                                focusNode: fn,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  isDense: true,
                                  fillColor: Color(0xff1a252a),
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff1a252a),
                                      width: 3.0,
                                    ),
                                  ),
                                  errorText: error,
                                  prefixIconConstraints: BoxConstraints(
                                      maxWidth: _distanceToField * 0.74),
                                  prefixIcon: tags.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Wrap(
                                              spacing:
                                                  5.0, // Set the spacing between tags
                                              runSpacing:
                                                  5.0, // Set the run spacing (vertical spacing between lines)
                                              children: tags.map((String tag) {
                                                return IntrinsicWidth(
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 0.06),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20.0),
                                                      ),
                                                      // color: Color(0xff1a252a),
                                                    ),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          child: Text(
                                                            tag,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 4.0),
                                                        InkWell(
                                                          child: const Icon(
                                                            Icons.close,
                                                            size: 14.0,
                                                            color: Colors.white,
                                                          ),
                                                          onTap: () {
                                                            onTagDelete(tag);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList()),
                                        )
                                      : null,
                                ),
                                onChanged: onChanged,
                                onSubmitted: onSubmitted,
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
