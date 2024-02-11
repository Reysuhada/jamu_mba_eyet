import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:project_mobile_apps/cake_model.dart';
import 'package:project_mobile_apps/widget/navbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher_string.dart';

class CakeryDetail extends StatelessWidget {
  const CakeryDetail({
    Key? key,
    required this.cakeModel,
  }) : super(key: key);

  final CakeModel cakeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF545D68),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Pesan',
          style: TextStyle(
            fontFamily: 'Varela',
            fontSize: 24.0.sp,
            color: const Color(0xFF545D68),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF545D68),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.only(left: 16.0.sp),
            child: Text(
              'Jamu',
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 40.0.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF17532),
              ),
            ),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
            ),
            child: Hero(
              tag: cakeModel.foto!,
              child: Container(
                height: 200.h,
                width: 200.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.sp),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://rayhan.isibi.web.id/public/filegambar/${cakeModel.foto!}",
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0.h),
          Center(
            child: Text(
              'Rp ${cakeModel.harga}',
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF17532),
              ),
            ),
          ),
          SizedBox(height: 16.0.sp),
          Center(
            child: Text(
              cakeModel.nama!,
              style: TextStyle(
                  color: const Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 24.0.sp),
            ),
          ),
          SizedBox(height: 16.0.sp),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 52.0,
              child: Text(
                cakeModel.deskripsi!,
                maxLines: 4,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0.sp,
                  color: const Color(0xFFB4B8B9),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0.h),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await launchUrlString(
                      'whatsapp://send?phone=62882001060357&text=saya ingin pesan ${cakeModel.nama}');
                } catch (e) {
                  log("ERROR LAUNCH WA == $e");
                }
                // openWhatsapp(
                //     context: context,
                //     text: "Silahkan Pesan Sesuai dengan yang anda pilih",
                //     number: "+62882001060357");
              },
              child: const Text('Pesan via WhatsApp'),
            ),
          ),
          SizedBox(height: 28.0.h),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFF17532),
        child: const Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavbarWidget(),
    );
  }

  void openWhatsapp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    var whatsapp =
        number.replaceAll(RegExp(r"\s+"), ""); // Remove any white space
    var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.encodeFull(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatsappURLIos)) {
        await launch(whatsappURLIos);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }
}
