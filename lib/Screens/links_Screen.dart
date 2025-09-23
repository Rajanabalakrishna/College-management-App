import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

class links extends StatelessWidget {
  const links({super.key});

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          color: Colors.white,

          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 20,bottom: 10),
                child: Text(
                  "Follow our college links",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.public,color: Colors.blue,size: 28, ),
                    SizedBox(width: 8,),
                    TextButton(
                      onPressed: () {
                        launchURL("https://srisivani.com/");
                      },
                      child: Text("SSCE Website",),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/linkedin (1).png",
                      width: 25,
                      height: 25,

                    ),
                    SizedBox(width: 8,),
                    TextButton(
                      onPressed: () {
                        launchURL("https://www.linkedin.com/search/results/people/?heroEntityKey=urn%3Ali%3Aorganization%3A15121861&keywords=sri%20sivani%20college%20of%20engineering%2C%20chilakapalem%20junction%2C%20etcherla%20mandal%2C%20pin-532402%20(cc-w6)&origin=CLUSTER_EXPANSION&position=0&searchId=a5042115-337f-47d5-b316-c7fea9705af5&sid=%3Bbq");
                      },
                      child: Text("Linked In"),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/instagram.png",
                      width: 20,
                      height: 20,
                      color: Colors.pink,
                    ),
                    SizedBox(width: 8,),
                    TextButton(
                      onPressed: () {
                        launchURL("https://www.instagram.com/sri_sivani_srikakulam/");
                      },
                      child: Text("instagram"),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/whatsapp.png",
                      width: 20,
                      height: 20,
                      color: Colors.green,
                    ),
                    SizedBox(width: 8,),
                    TextButton(
                      onPressed: () {
                        launchURL("https://whatsapp.com/channel/0029VaFRd2n8F2pCnL9b4l0L");
                      },
                      child: Text("Whatsapp Channel"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
