import 'dart:io';
import 'package:contact_diary/provider/contact_provider.dart';
import 'package:contact_diary/view/contact_save.dart';
import 'package:contact_diary/view/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contacts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Settings();
                    },
                  ),
                );
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (BuildContext context, contactprovider, child) {
          return contactprovider.contactList.isNotEmpty ?
          ListView.builder(
            itemCount: contactprovider.contactList.length,
            itemBuilder: (context, index) {
              var contactModel = contactprovider.contactList[index];
              return Stack(
                children: [
                  ListTile(
                    title: Text(contactModel.name ?? ""),
                    leading: CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: contactModel.xFile != null
                          ? FileImage(
                              File(contactModel.xFile!.path ?? ""),
                            )
                          : null,
                      child: contactModel.xFile == null
                          ? Icon(
                              Icons.person, // Replace with your desired icon
                              size: 48,
                            )
                          : null,
                    ),
                    minVerticalPadding: 20,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contactModel.number ?? ""),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            var uri = Uri.parse(
                                "tel:+91${contactModel.number ?? ""}");

                            launchUrl(uri);
                          },
                          icon: Icon(Icons.call),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 65,
                    top: 17,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: TextButton(
                              onPressed: () {
                                Provider.of<ContactProvider>(context,
                                        listen: false)
                                    .remove(index);
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContactSave(
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Edit",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: TextButton(
                              onPressed: () {
                                Share.share(contactModel.number ?? "");
                              },
                              child: Text(
                                "Share",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            value: 3,
                          ),
                        ],
                        icon: Icon(Icons.more_vert),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              );
            },
          )
              :
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 200,
                ),
                Text("Add Contact",style: TextStyle(fontSize: 40),)
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactSave(),
            ),
          );
        },
      ),
    );
  }
}
