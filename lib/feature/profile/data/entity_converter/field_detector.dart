bool checkNikField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "nik";
}

bool checkNamaField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "nama" || text == "nema" || text == "name";
}

bool checkTglLahirField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "lahir" ||
      text == "tempat" ||
      text == "tempatigllahir" ||
      text == "empatgllahir" ||
      text == "tempat/tgl";
}

bool checkJenisKelaminField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "kelamin" || text == "jenis";
}

bool checkAlamatField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "alamat" ||
      text == "lamat" ||
      text == "alaahom" ||
      text == "alama" ||
      text == "alamao" ||
      text == "alamarw";
}

bool checkRtRwField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "rt/rw" || text == "rw " || text == "rt" || text == "rtirw";
}

bool checkKelDesaField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "kel/desa" || text == "helldesa" || text == "kelldesa";
}

bool checkKecamatanField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "kecamatan" || dataText.contains("kecamatan");
}

bool checkAgamaField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "agama" || text == "gama";
}

bool checkKawinField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "kawin" || text == "perkawinan" || text == "perkawinan:";
}

bool checkPekerjaanField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "kerja" || text == "pekerjaan";
}

bool checkKewarganegaraanField(String dataText) {
  final text = dataText.toLowerCase().trim();
  return text == "kewarganegaraan" ||
      text == "negaraan" ||
      text == "kewarganegaraan:";
}