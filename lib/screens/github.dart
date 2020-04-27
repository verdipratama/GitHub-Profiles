import 'package:flutter/material.dart';
import 'package:github_info/screens/profile.dart';

class MyGitHub extends StatefulWidget {
  @override
  _MyGitHubState createState() => _MyGitHubState();
}

class _MyGitHubState extends State<MyGitHub> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();

  void dispose(){
    _userController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(
                            flex: 3,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            //width: MediaQuery.of(context).size.height/4,
                            child: Image.asset('assets/images/GitHub.jpg'),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Text(
                            "GitHub",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 40,
                              letterSpacing: 1,
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                        ],
                      ),
                    ),
                    //lower part

                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 12),
                      alignment: Alignment.center,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white30,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 5),
                                  child: TextFormField(
                                    controller: _userController,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                      ),
                                      fillColor: Colors.red,
                                      hintText: "\tGitHub Username",
                                      hintStyle: TextStyle(
                                          color: Colors.white30,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'This field can not be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 30,
                              ),
                              alignment: Alignment.center,
                              child: RaisedButton(
                                color: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    print(_userController.text);
                                    return Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyProfile(_userController.text),
                                      ),
                                    );
                                  }
                                  return null;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Search",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 29,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
