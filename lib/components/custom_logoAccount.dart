// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppablecard/images.dart';

class CustomLogoAccount extends StatelessWidget {
  const CustomLogoAccount({
    Key? key,
    required this.namePerson,
    required this.emailPerson,
    required this.imagePerson,
  }) : super(key: key);
  final String namePerson;
  final String emailPerson;
  final String imagePerson;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          alignment: Alignment.topLeft,
          child: CircleAvatar(
            maxRadius: 60,
            child: CachedNetworkImage(
              imageUrl: '${ImagesUrls.usersImage}$imagePerson',
              placeholder: (context, url) => const Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                height: 30.0,
                width: 30.0,
              )),
              errorWidget: (context, url, error) => Center(
                child: Text('$error'),
              ),
              fit: BoxFit.fitHeight,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namePerson,
                  style: const TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 26.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  emailPerson,
                  style: const TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
