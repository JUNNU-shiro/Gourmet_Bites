class DealModel {
  final String id;
  final String title;
  final String imagePath;
  final String logoPath;
  final String storeName;
  final String address;
  final String pickupTime;
  final int stock;
  final String category;
  final double originalPrice;
  final double discountedPrice;
  final double rating;
  final int reviews;
  final double collectionExp;
  final double foodQuality;
  final double variety;
  final double quantity;
  
  // Geolocation fields
  final double latitude;
  final double longitude;
  
  // Additional fields for browse screen compatibility
  final String description;
  final DateTime expiryDate;
  final bool isActive;

  DealModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.logoPath,
    required this.storeName,
    required this.address,
    required this.pickupTime,
    required this.stock,
    required this.category,
    required this.originalPrice,
    required this.discountedPrice,
    required this.rating,
    required this.reviews,
    required this.collectionExp,
    required this.foodQuality,
    required this.variety,
    required this.quantity,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.expiryDate,
    required this.isActive,
  });

  // Convenience constructor for browse screen compatibility
  DealModel.browsable({
    required this.id,
    required this.title,
    required String businessName,
    required this.description,
    required String discount,
    required String imageUrl,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.category,
    required this.expiryDate,
    required this.isActive,
  }) : 
    imagePath = imageUrl,
    logoPath = '',
    storeName = businessName,
    pickupTime = '',
    stock = 0,
    originalPrice = 0.0,
    discountedPrice = 0.0,
    rating = 0.0,
    reviews = 0,
    collectionExp = 0.0,
    foodQuality = 0.0,
    variety = 0.0,
    quantity = 0.0;

  // Getters for browse screen compatibility
  String get imageUrl => imagePath;
  String get businessName => storeName;
  
  String get discount {
    if (originalPrice > 0 && discountedPrice > 0) {
      double discountPercent = ((originalPrice - discountedPrice) / originalPrice) * 100;
      return '${discountPercent.round()}% OFF';
    }
    return 'DEAL';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DealModel && id == other.id;

  @override
  int get hashCode => id.hashCode;
}PS C:\Users\akhil\OneDrive\Desktop\street radar\streetradar> git commit -m "first commit"
Author identity unknown

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'akhil@Akhil.(none)')PS C:\Users\akhil\OneDrive\Desktop\street radar\streetradar> git commit -m "first commit"
Author identity unknown

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'akhil@Akhil.(none)')``