import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import '../widgets/pelatte.dart';
import 'about_us_info.dart';

class About_us_page extends StatefulWidget {
  const About_us_page({Key? key}) : super(key: key);

  @override
  State<About_us_page> createState() => _About_us_pageState();
}

class _About_us_pageState extends State<About_us_page> {

  List<about_us_info> about_us_infoList = [
    about_us_info('assets/images/img_2.jpg', 'Vedant Pancholi', 'Frontend Developer'),
    about_us_info('assets/images/img_1.jpg', 'Maharshi Patel', 'Backend Developer'),
    about_us_info('assets/images/img_3.jpg', 'Jesal Prajapati', 'IoT Developer'),
    about_us_info('assets/images/img_4.jpg', 'Parva Prajapati', 'IoT Developer'),
  ];

  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 2,
          title: const Text(
            "About Us",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: kSecondaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              )
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 3,
                  child: SizedBox(
                    height: size.height*0.13,
                    width: size.width*0.9,
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Our mission is to provide a reliable and efficient solution to help police organizations monitor and track the performance of their "
                          "officers and employees, through the use of IoT-based smart surveillance technology.",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0,),
                child: Text("Expert Developers", style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                ),
                SizedBox(
                  height: size.height*0.42,
                  child: ScrollSnapList(
                    curve: Curves.easeInCirc,
                    itemBuilder: _buildListItem,
                    itemCount: about_us_infoList.length,
                    itemSize: 220,
                    onItemFocus: (index) {},
                    dynamicItemSize: true,
                  ),
                ),
                SizedBox(
                  height: size.height*0.02,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 3,
                  child: SizedBox(
                    height: size.height*0.22,
                    width: size.width*0.9,
                    child:   Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("About Our Mission : \n",
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Text("In today's time police organization has certain fields in which an officer or employee has to visit the place allocated respectively. "
                              "Each of these officers is given adequate salary commensurate with their work. The circumstances are such that somewhere these salaried persons "
                              "work properly or not. That is why we need to observe them. It is becoming complex to track and check the actual scenario of surveillance. "
                              "IoT-based smart surveillance mechanism can be helpful in order to track these routes and duties.",
                            style: TextStyle(fontSize: 15.5),
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
    );
}
  Widget _buildListItem(BuildContext context, int index) {
    about_us_info about_info = about_us_infoList[index];
    return SizedBox(
      width: 220,
      height: 350,
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              Image.asset(
                about_info.imagePath,
                fit: BoxFit.cover,
                width: 220,
                height: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                about_info.name,
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: kSecondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                about_info.role,
                style:  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
