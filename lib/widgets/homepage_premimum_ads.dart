import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_review/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../providers/ads_provider.dart';
import '../screens/premium_ads_details/premium_ads_details.dart';

class HomePagePremiumAds extends StatefulWidget {
  

  @override
  State<HomePagePremiumAds> createState() => _HomePagePremiumAdsState();
}

class _HomePagePremiumAdsState extends State<HomePagePremiumAds> {

  @override
  Widget build(BuildContext context) {
    AdsProvider adsProvider = Provider.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: Row(
              children: [
                TextWidget(
                  text: 'Hot'.toUpperCase(),
                  color: Colors.redAccent,
                  textSize: 22,
                  isTitle: true,
                ),
                SizedBox(width: 5,),
                Icon(Icons.search_outlined,color: Colors.cyan,)
              ],
            ),
          ),
          Row(
            children: adsProvider.getfetchpremiumAdsDataList.map(
                  (value) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PremiumAdsDetails(
                          description: value.description,
                          imageURL: value.imageURL,
                          phoneNumber: value.phoneNumber,
                          timestamp: value.timestamp,

                        )));
                  },
                  child: Container(
                      width: 170,
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      margin:
                      EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FancyShimmerImage(
                            height: 120,
                            boxFit: BoxFit.cover,
                            imageUrl: value.imageURL,

                          ),
                          // Image.network(value.imageURL,height: 100,fit: BoxFit.cover),
                          // Text(value.description),
                        ],
                      ),
                    ),
                );

              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
