import 'package:flutter/material.dart';
import 'package:project_mobile_apps/cake_model.dart';
import 'package:project_mobile_apps/screen/cakery_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class CakeryPage extends StatefulWidget {
  const CakeryPage({Key? key}) : super(key: key);

  @override
  State<CakeryPage> createState() => _CakeryPageState();
}

class _CakeryPageState extends State<CakeryPage> {
  List<CakeModel> listCakeModel = <CakeModel>[];

  Future<List<CakeModel>> fetchData() async {
    // List<CakeModel> listCakeModel = [];

    try {
      var response = await http.get(
        Uri.parse('https://rayhan.isibi.web.id/jamous2'),
      );

      var responseJson = json.decode(response.body);
      log("RESPONSE => $responseJson");

      if (response.statusCode == 200) {
        log("RESPONSE Code==  ${response.statusCode}");
        for (var data in responseJson) {
          CakeModel cakeModel = CakeModel.fromJson(data);
          listCakeModel.add(cakeModel);
        }
      }

      log("listCakeModel==$listCakeModel");

      return listCakeModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    log("jalan");
    fetchData();
    log("Model == $listCakeModel");
  }

  // Widget _buildCard(
  //   CakeModel cake,
  //   BuildContext context,
  // ) {
  //   return Padding(
  //     padding: EdgeInsets.all(4.sp),
  //     child: InkWell(
  //       onTap: () {
  //         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //           return CakeryDetail(
  //             cakeModel: cake,
  //           );
  //         }));
  //       },
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(16.0.r),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.2),
  //               spreadRadius: 3.0,
  //               blurRadius: 5.0,
  //             )
  //           ],
  //           color: Colors.white,
  //         ),
  //         child: ListView(
  //           physics: const NeverScrollableScrollPhysics(),
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(
  //                 right: 8.sp,
  //                 top: 8.sp,
  //               ),
  //               child: const Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [],
  //               ),
  //             ),
  //             Container(
  //               height: 92.h,
  //               width: 92.w,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(16.r),
  //                 image: DecorationImage(
  //                   image: NetworkImage(
  //                     "https://rayhan.isibi.web.id/public/filegambar/${cake.foto}",
  //                   ),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 8.h),
  //             Center(
  //               child: Text(
  //                 'Rp ${cake.harga!}',
  //                 style: TextStyle(
  //                     color: const Color(0xFFCC8053),
  //                     fontFamily: 'Varela',
  //                     fontSize: 16.sp),
  //               ),
  //             ),
  //             Center(
  //               child: Text(
  //                 cake.nama!,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: TextStyle(
  //                     color: const Color(0xFF575E67),
  //                     fontFamily: 'Varela',
  //                     fontSize: 14.sp),
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(8.0.sp),
  //               child: Container(
  //                 color: const Color(0xFFEBEBEB),
  //                 height: 1.0.sp,
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 4.sp),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Icons.chat,
  //                         color: const Color(0xFFD17E50),
  //                         size: 16.sp,
  //                       ),
  //                       SizedBox(
  //                         width: 8.sp,
  //                       ),
  //                       Text(
  //                         'Chat',
  //                         style: TextStyle(
  //                             fontFamily: 'Varela',
  //                             color: const Color(0xFFD17E50),
  //                             fontSize: 12.sp),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     width: 16.h,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Icons.remove_circle_outline,
  //                         color: const Color(0xFFD17E50),
  //                         size: 16.sp,
  //                       ),
  //                       SizedBox(
  //                         width: 8.w,
  //                       ),
  //                       Text(
  //                         '3',
  //                         style: TextStyle(
  //                             fontFamily: 'Varela',
  //                             color: const Color(0xFFD17E50),
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 12.sp),
  //                       ),
  //                       SizedBox(
  //                         width: 8.w,
  //                       ),
  //                       Icon(
  //                         Icons.add_circle_outline,
  //                         color: const Color(0xFFD17E50),
  //                         size: 16.sp,
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // fetchData();
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAF8),
      body: Padding(
          padding: EdgeInsets.only(
            bottom: 80.sp,
          ),
          child: FutureBuilder<List<CakeModel>>(
              // future: Future.value(fetchData()),
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.sp,
                      mainAxisSpacing: 8.sp,
                      childAspectRatio: 0.7.sp,
                    ),
                    itemBuilder: (context, index) {
                      var cake = listCakeModel[index];
                      return Padding(
                        padding: EdgeInsets.all(4.sp),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return CakeryDetail(
                                cakeModel: cake,
                              );
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3.0,
                                  blurRadius: 5.0,
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 8.sp,
                                    top: 8.sp,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [],
                                  ),
                                ),
                                Container(
                                  height: 92.h,
                                  width: 92.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://rayhan.isibi.web.id/public/filegambar/${cake.foto}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Center(
                                  child: Text(
                                    'Rp ${cake.harga!}',
                                    style: TextStyle(
                                        color: const Color(0xFFCC8053),
                                        fontFamily: 'Varela',
                                        fontSize: 16.sp),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    cake.nama!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: const Color(0xFF575E67),
                                        fontFamily: 'Varela',
                                        fontSize: 14.sp),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: Container(
                                    color: const Color(0xFFEBEBEB),
                                    height: 1.0.sp,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.chat,
                                            color: const Color(0xFFD17E50),
                                            size: 16.sp,
                                          ),
                                          SizedBox(
                                            width: 8.sp,
                                          ),
                                          Text(
                                            'Chat',
                                            style: TextStyle(
                                                fontFamily: 'Varela',
                                                color: const Color(0xFFD17E50),
                                                fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 16.h,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.remove_circle_outline,
                                            color: const Color(0xFFD17E50),
                                            size: 16.sp,
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                            '3',
                                            style: TextStyle(
                                                fontFamily: 'Varela',
                                                color: const Color(0xFFD17E50),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Icon(
                                            Icons.add_circle_outline,
                                            color: const Color(0xFFD17E50),
                                            size: 16.sp,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      // return _buildCard(listCakeModel[index], context);
                    },
                    itemCount: listCakeModel.length,
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: ElevatedButton(
                    child: Text("Refresh"),
                    onPressed: () {
                      setState(() async {
                        listCakeModel = await fetchData();
                      });
                      ;
                    },
                  ));
                }
                return Center(
                    child: CircularProgressIndicator(color: Color(0xFFD17E50)));
              })),
    );
  }
}
