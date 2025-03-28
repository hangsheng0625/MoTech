class Crop {
  final String name;
  final String farmerName;
  final String location;
  final double pricePerKg;
  final int availableKg;
  final String imageUrl; // Add this field

  Crop({
    required this.name,
    required this.farmerName,
    required this.location,
    required this.pricePerKg,
    required this.availableKg,
    required this.imageUrl, // Ensure this is passed
  });
}
