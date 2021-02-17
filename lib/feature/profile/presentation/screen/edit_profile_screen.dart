import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_text_recognition/core/colors.dart';
import 'package:flutter_text_recognition/feature/profile/presentation/bloc/scan_ktp_bloc.dart';
import 'package:flutter_text_recognition/feature/profile/presentation/widget/custom_camera.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController tecDate = TextEditingController();
  final DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorSecondaryDarkBlue,
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Profile Image",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
              ],
            ),
            TextFormField(
              style: TextStyle(color: appColorAccent0Gray),
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                labelStyle: TextStyle(color: appColorAccent0Gray),
              ),
            ),
            GestureDetector(
              onTap: () async {
                DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: new DateTime.now(),
                    firstDate: new DateTime(2016),
                    lastDate: new DateTime(2025));
                if (picked != null) tecDate.text = dateFormat.format(picked);
              },
              child: TextFormField(
                enabled: false,
                controller: tecDate,
                style: TextStyle(color: appColorAccent0Gray),
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  labelStyle: TextStyle(color: appColorAccent0Gray),
                ),
              ),
            ),
            TextFormField(
              style: TextStyle(color: appColorAccent0Gray),
              decoration: InputDecoration(
                labelText: 'Alamat',
                labelStyle: TextStyle(color: appColorAccent0Gray),
              ),
            ),
            TextFormField(
              style: TextStyle(color: appColorAccent0Gray),
              decoration: InputDecoration(
                labelText: 'Agama',
                labelStyle: TextStyle(color: appColorAccent0Gray),
              ),
            ),
            TextFormField(
              style: TextStyle(color: appColorAccent0Gray),
              decoration: InputDecoration(
                labelText: 'Status Perkawinan',
                labelStyle: TextStyle(color: appColorAccent0Gray),
              ),
            ),
            FlatButton(
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CustomCamera()));

                  BlocProvider.of<ScanKtpBloc>(context)
                      .add(ScanKtpInputEvent(fileImage: result));
                },
                child: Text("Scan Ktp"))
          ],
        ),
      ),
    );
  }
}
