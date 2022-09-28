import 'package:flutter/material.dart';
import 'package:quizu/utils/constants.dart';
import 'package:quizu/utils/networkutils.dart';
import 'package:quizu/screens/main/main.dart';

class NameScreen extends StatefulWidget {
  static String id = 'name_screen';

  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  String _name = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                child: const Text(
                  'QuizU',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 50,
                      color: Colors.white
                  ),
                )
            ),

            Container(
                padding: EdgeInsets.only(left: 35,right: 35,
                  top: MediaQuery.of(context).size.height * 0.2,),
                child: Column(
                  children: [
                    Text('Enter Your Name'),
                    SizedBox(height: 10,),
                    TextField(
                      onChanged: (text){
                        _name = text;
                      },
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 25),
                      cursorColor: grey,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: kBorder,
                        focusedBorder: kFocusBorder,
                        errorBorder: kErrorBorder,
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: (){
                        postName(_name);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        foregroundColor: MaterialStateProperty.all<Color>(grey),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)
                            )
                        ),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  void postName(String name) {
     NetworkUtils().postName(name);
     Navigator.pushNamedAndRemoveUntil(context, MainPage.id,(e) => false);
  }
}




