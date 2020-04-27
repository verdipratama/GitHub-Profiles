import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:github_info/screens/widgets/error.dart';
import 'package:github_info/screens/widgets/loading.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  final String user;
  MyProfile(this.user);
  @override
  _MyProfileState createState() => _MyProfileState(this.user);
}

class _MyProfileState extends State<MyProfile> {
  final String user;
  _MyProfileState(this.user);
  var data, repo;
  Future<void> makeRequest(myUser) async {
    String url = 'https://api.github.com/users/$myUser';
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      data = jsonDecode(response.body);
    });
    //print(data);
  }

  Future<void> repoRequest(myUser) async {
    String url = 'https://api.github.com/users/$myUser/repos';
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      repo = jsonDecode(response.body);
    });
    print(repo);
    print(repo.length);
  }

  @override
  void initState() {
    makeRequest(user);
    repoRequest(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return MyLoading();
    }
    if (data['message'].toString().compareTo('Not Found') == 0 &&
        data != null) {
      return MyErrorPage();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      AntDesign.github,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            //_myDetails(),
            Expanded(
              child: ListView.builder(
                itemCount: repo == null ? 0 : repo.length+1,
                itemBuilder: (BuildContext context, i) {
                  if (i==0) {
                    return _myDetails();
                  }
                  i-=1;
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Octicons.repo,color: Colors.white,size: 45,),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(repo[i]['name'].toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                                Text(repo[i]['full_name'].toString(),style: TextStyle(color: Colors.white),),
                                SizedBox(height: 10,),
                                Row(children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white24,
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(FontAwesome5Solid.circle,color: Colors.white,size: 10,),
                                        SizedBox(width: 5,),
                                        Text(repo[i]['language'].toString(),style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                  Container(),
                                ],)
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _myDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Container(
                          color: Colors.white10,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                            width: MediaQuery.of(context).size.height / 8,
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: MediaQuery.of(context).size.height / 10,
                            ),
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Image.network(
                          data['avatar_url'],
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 8,
                          width: MediaQuery.of(context).size.height / 8,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        data['name'].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height / 28),
                      ),
                      subtitle: Text(
                        data['login'].toString(),
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: MediaQuery.of(context).size.height / 35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //next line
            data['bio'] == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white12,
                      ),
                      width: MediaQuery.of(context).size.width - 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          data['bio'].toString(),
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  data['blog'].toString().compareTo('') == 0
                      ? Container()
                      : Row(
                          children: [
                            Icon(
                              Icons.link,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              data['blog'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                  data['company'] == null
                      ? Container()
                      : Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              data['company'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                  data['email'] == null
                      ? Container()
                      : Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              data['email'].toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                  data['location'] == null
                      ? Container()
                      : Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              data['location'].toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        data['public_repos'].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "Repositories",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        data['followers'].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        data['following'].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "Following",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
