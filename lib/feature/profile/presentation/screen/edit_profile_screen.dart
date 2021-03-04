import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_text_recognition/core/colors.dart';
import 'package:flutter_text_recognition/feature/profile/presentation/bloc/scan_ktp_bloc.dart';
import 'package:flutter_text_recognition/feature/profile/presentation/widget/custom_camera.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController tecNik = TextEditingController();
  final TextEditingController tecNama = TextEditingController();
  final TextEditingController tecDate = TextEditingController();
  final TextEditingController tecTempalLahir = TextEditingController();
  final TextEditingController tecKelamin = TextEditingController();
  final TextEditingController tecAlamat = TextEditingController();
  final TextEditingController tecAgama = TextEditingController();
  final TextEditingController tecPerkawinan = TextEditingController();
  final TextEditingController tecPekerjaan = TextEditingController();
  final TextEditingController tecKewarganegaraan = TextEditingController();
  final DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanKtpBloc, ScanKtpState>(
      listener: (BuildContext context, state) {
        if (state is ScanKtpSuccessState) {
          tecNik.text = state.userData.nik;
          tecNama.text = state.userData.namaLengkap;
          tecDate.text = state.userData.tanggalLahir;
          tecTempalLahir.text = state.userData.tempatLahir;
          tecKelamin.text = state.userData.jenisKelamin;
          tecAlamat.text = state.userData.alamatFull;
          tecAgama.text = state.userData.agama;
          tecPerkawinan.text = state.userData.statusPerkawinan;
          tecPekerjaan.text = state.userData.pekerjaan;
          tecKewarganegaraan.text = state.userData.kewarganegaraan;
        }
      },
      child: Scaffold(
        backgroundColor: appColorSecondaryDarkBlue,
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
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
                  controller: tecNik,
                  style: TextStyle(color: appColorAccent0Gray),
                  decoration: InputDecoration(
                    labelText: 'NIK',
                    labelStyle: TextStyle(color: appColorAccent0Gray),
                  ),
                ),
                TextFormField(
                  controller: tecNama,
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
                        firstDate: new DateTime(1960),
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
                  controller: tecKelamin,
                  style: TextStyle(color: appColorAccent0Gray),
                  decoration: InputDecoration(
                    labelText: 'Jenis Kelamin',
                    labelStyle: TextStyle(color: appColorAccent0Gray),
                  ),
                ),
                TextFormField(
                  controller: tecAlamat,
                  style: TextStyle(color: appColorAccent0Gray),
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    labelStyle: TextStyle(color: appColorAccent0Gray),
                  ),
                ),
                TextFormField(
                  controller: tecAgama,
                  style: TextStyle(color: appColorAccent0Gray),
                  decoration: InputDecoration(
                    labelText: 'Agama',
                    labelStyle: TextStyle(color: appColorAccent0Gray),
                  ),
                ),
                TextFormField(
                  controller: tecPerkawinan,
                  style: TextStyle(color: appColorAccent0Gray),
                  decoration: InputDecoration(
                    labelText: 'Status Perkawinan',
                    labelStyle: TextStyle(color: appColorAccent0Gray),
                  ),
                ),
                TextFormField(
                  controller: tecPekerjaan,
                  style: TextStyle(color: appColorAccent0Gray),
                  decoration: InputDecoration(
                    labelText: 'Pekerjaan',
                    labelStyle: TextStyle(color: appColorAccent0Gray),
                  ),
                ),
                TextFormField(
                  controller: tecKewarganegaraan,
                  style: TextStyle(color: appColorAccent0Gray),
                  decoration: InputDecoration(
                    labelText: 'Kewarganegaraan',
                    labelStyle: TextStyle(color: appColorAccent0Gray),
                  ),
                ),
                FlatButton(
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CustomCamera(),
                        ),
                      );
                      BlocProvider.of<ScanKtpBloc>(context).add(
                        ScanKtpInputEvent(fileImage: result),
                      );
                    },
                    child: Text("Scan Ktp"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
