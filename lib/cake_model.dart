class CakeModel {
  int? id;
  String? nama;
  int? harga;
  String? deskripsi;
  String? foto;
  String? category;
  String? createdAt;
  String? updatedAt;

  CakeModel({
    this.id,
    this.nama,
    this.harga,
    this.deskripsi,
    this.foto,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  CakeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nama = json["nama"];
    harga = json["harga"] != null ? int.parse(json["harga"].toString()) : null;
    deskripsi = json["deskripsi"];
    foto = json["foto"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['harga'] = harga;
    data['deskripsi'] = deskripsi;
    data['foto'] = foto;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
