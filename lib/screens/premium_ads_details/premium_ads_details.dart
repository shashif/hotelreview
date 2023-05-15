import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/color_widget.dart';

class PremiumAdsDetails extends StatefulWidget {
  final String imageURL;
  final String description;
  final String phoneNumber;
  final Timestamp timestamp;

  PremiumAdsDetails({
    required this.description,
    required this.imageURL,
    required this.phoneNumber,
    required this.timestamp,
  });

  @override
  State<PremiumAdsDetails> createState() => _PremiumAdsDetailsState();
}

class _PremiumAdsDetailsState extends State<PremiumAdsDetails> {
  @override
  Widget build(BuildContext context) {
    String phNumber = widget.phoneNumber;

    // Format the timestamp as a readable date and time
    String formattedDateTime =
        DateFormat('d MMMM, yyyy h:mm a').format(widget.timestamp.toDate());

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FancyShimmerImage(
                      width: double.infinity, imageUrl: widget.imageURL),
                ),
                SizedBox(
                  height: 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.call),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Dial:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.phoneNumber,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                          onTap: () async {
                            if (await canLaunch('tel: ${phNumber}')) {
                              await launch('tel: ${phNumber}');
                            } else {
                              throw 'Could not launch $phNumber';
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Post Date:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          formattedDateTime,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
