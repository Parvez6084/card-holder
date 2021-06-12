
final String tableContact = 'tbl_contact';
final String colName = 'contract_name';
final String colDesignation = 'contract_designation';
final String colPhone = 'contract_phone';
final String colEmail = 'contract_Email';
final String colWebSite = 'contract_website';
final String colCompanyName = 'contract_company_name';
final String colAddress = 'contract_address';
final String colImage = 'contract_image';
final String colID = 'contract_id';
final String colFavorite = 'contract_favorite';

class ContractModel {
  int? id;
  String? name;
  String? designation;
  String? phoneNumber;
  String? email;
  String? companyName;
  String? website;
  String? address;
  String? image;
  bool? favorite;

  ContractModel(
      {this.id,
      this.name,
      this.designation = 'Unknown',
      this.phoneNumber,
      this.email,
      this.companyName = 'Unknown',
      this.website = 'Unknown',
      this.address,
      this.image,
      this.favorite = false
      });


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colName: name,
      colDesignation: designation,
      colPhone: phoneNumber,
      colEmail: email,
      colCompanyName: companyName,
      colWebSite: website,
      colAddress: address,
      colImage:image,
      colFavorite:favorite! ? 1:0,
    };
    if (id != null) {
      map[colID] = id;
    }
    return map;
  }

  ContractModel.fromMap(Map<String, dynamic> map) {
    id = map[colID];
    name = map[colName];
    designation = map[colDesignation];
    phoneNumber = map[colPhone];
    email = map[colEmail];
    companyName = map[colCompanyName];
    website = map[colWebSite];
    address = map[colAddress];
    image = map[colImage];
    favorite = map[colFavorite] == 1 ? true : false;
  }


  @override
  String toString() {
    return 'ContractModel{id: $id, name: $name, designation: $designation, phoneNumber: $phoneNumber, email: $email, companyName: $companyName, website: $website, address: $address, image: $image}';
  }
}
