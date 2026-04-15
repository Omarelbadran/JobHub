import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../search_job_view/search_job_view.dart';
class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.w,
      child: TextFormField(
        readOnly: true,
          onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchJobView(),
            ),
          );
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search , color: Colors.deepOrange,),
            hintText: 'Search For Jobs',
            hintStyle: TextStyle(
              fontSize: 14.sp,
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold
            ),
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
          )
      ),
    );
  }
}
