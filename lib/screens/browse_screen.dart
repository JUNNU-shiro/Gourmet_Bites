import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/deal_model.dart';
import 'deal_detail_screen.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

const String kGoogleApiKey = 'YOUR_GOOGLE_API_KEY';
final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  double _selectedDistance = 5.0;
  String _currentAddress = "Fetching location...";
  String _selectedLocationName = "";
  Position? _userPosition;
  bool _isLoadingLocation = false;
  bool _isUsingCurrentLocation = true;

  final List<DealModel> deals = [
    DealModel.browsable(
      id: '1',
      title: 'Free Coffee with Breakfast',
      businessName: 'Cafe Central',
      description: 'Get a free coffee with any breakfast order',
      discount: '50% OFF',
      imageUrl: 'https://via.placeholder.com/300x200',
      latitude: 37.4221,
      longitude: -122.0844,
      address: '123 Main St, Mountain View, CA',
      category: 'Food',
      expiryDate: DateTime.now().add(const Duration(days: 7)),
      isActive: true,
    ),
    DealModel.browsable(
      id: '2',
      title: 'Pizza Special Deal',
      businessName: 'Tony\'s Pizza',
      description: 'Buy one pizza get one 50% off',
      discount: 'BOGO 50%',
      imageUrl: 'https://via.placeholder.com/300x200',
      latitude: 37.4219,
      longitude: -122.0840,
      address: '456 Oak Ave, Mountain View, CA',
      category: 'Food',
      expiryDate: DateTime.now().add(const Duration(days: 5)),
      isActive: true,
    ),
    DealModel.browsable(
      id: '3',
      title: 'Gym Membership Discount',
      businessName: 'FitZone Gym',
      description: '30% off on annual membership',
      discount: '30% OFF',
      imageUrl: 'https://via.placeholder.com/300x200',
      latitude: 37.4180,
      longitude: -122.0820,
      address: '789 Fitness St, Mountain View, CA',
      category: 'Fitness',
      expiryDate: DateTime.now().add(const Duration(days: 10)),
      isActive: true,
    ),
    DealModel.browsable(
      id: '4',
      title: 'Spa Treatment Special',
      businessName: 'Relaxation Spa',
      description: 'Buy 2 treatments get 1 free',
      discount: 'BUY 2 GET 1',
      imageUrl: 'https://via.placeholder.com/300x200',
      latitude: 37.4250,
      longitude: -122.0880,
      address: '321 Wellness Ave, Mountain View, CA',
      category: 'Beauty',
      expiryDate: DateTime.now().add(const Duration(days: 3)),
      isActive: true,
    ),
  ];

  List<DealModel> get _filteredDeals {
    if (_userPosition == null) return [];
    return deals.where((deal) {
      double distanceInMeters = Geolocator.distanceBetween(
        _userPosition!.latitude,
        _userPosition!.longitude,
        deal.latitude,
        deal.longitude,
      );
      return distanceInMeters / 1000 <= _selectedDistance;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    setState(() => _isLoadingLocation = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentAddress = "Location services disabled";
          _isLoadingLocation = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
        setState(() {
          _currentAddress = "Location permission denied";
          _isLoadingLocation = false;
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      _userPosition = position;
      _isUsingCurrentLocation = true;
      _updateAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _currentAddress = "Location unavailable";
        _isLoadingLocation = false;
      });
    }
  }

  Future<void> _updateAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = [
          place.subLocality,
          place.locality,
          place.administrativeArea,
        ].where((element) => element != null && element.isNotEmpty).join(', ');
        
        setState(() {
          if (_isUsingCurrentLocation) {
            _currentAddress = address.isNotEmpty ? address : 'Current Location';
          } else {
            _selectedLocationName = address.isNotEmpty ? address : 'Selected Location';
          }
          _isLoadingLocation = false;
        });
      } else {
        setState(() => _isLoadingLocation = false);
      }
    } catch (_) {
      setState(() => _isLoadingLocation = false);
    }
  }

  void _showLocationOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Location',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Current Location Option
            ListTile(
              leading: const Icon(Icons.my_location, color: Color(0xFF204E38)),
              title: const Text('Use Current Location'),
              subtitle: Text(_isUsingCurrentLocation ? 'Currently selected' : 'Tap to use current location'),
              onTap: () {
                Navigator.pop(context);
                _getUserLocation();
              },
            ),
            
            const Divider(),
            
            // Search for Location Option
            ListTile(
              leading: const Icon(Icons.search, color: Color(0xFF204E38)),
              title: const Text('Search for Location'),
              subtitle: const Text('Find a specific address or area'),
              onTap: () {
                Navigator.pop(context);
                _handleManualLocationSelection();
              },
            ),
            
            // If user has selected a custom location, show it
            if (!_isUsingCurrentLocation && _selectedLocationName.isNotEmpty) ...[
              const Divider(),
              ListTile(
                leading: const Icon(Icons.location_on, color: Color(0xFF204E38)),
                title: const Text('Selected Location'),
                subtitle: Text(_selectedLocationName),
                trailing: const Icon(Icons.check, color: Color(0xFF204E38)),
              ),
            ],
            
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _handleManualLocationSelection() async {
    try {
      Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: Mode.overlay,
        language: 'en',
        hint: 'Search for location...',
        logo: Container(), // Hide Google logo
        components: [], // Add country restriction if needed
      );

      if (p != null) {
        setState(() => _isLoadingLocation = true);
        
        final detail = await _places.getDetailsByPlaceId(p.placeId!);
        final lat = detail.result.geometry!.location.lat;
        final lng = detail.result.geometry!.location.lng;

        setState(() {
          _userPosition = Position(
            latitude: lat,
            longitude: lng,
            timestamp: DateTime.now(),
            accuracy: 1.0,
            altitude: 0.0,
            heading: 0.0,
            headingAccuracy: 1.0,
            speed: 0.0,
            speedAccuracy: 0.0,
            altitudeAccuracy: 1.0,
          );
          _isUsingCurrentLocation = false;
          _currentAddress = p.description ?? 'Selected Location';
        });
        
        _updateAddressFromCoordinates(lat, lng);
      }
    } catch (e) {
      setState(() => _isLoadingLocation = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to select location. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getDistanceText(DealModel deal) {
    if (_userPosition == null) return "";
    double distanceInMeters = Geolocator.distanceBetween(
      _userPosition!.latitude,
      _userPosition!.longitude,
      deal.latitude,
      deal.longitude,
    );
    double distanceInKm = distanceInMeters / 1000;
    return distanceInKm < 1
        ? "${distanceInMeters.round()}m away"
        : "${distanceInKm.toStringAsFixed(1)}km away";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF204E38),
      appBar: AppBar(
        backgroundColor: const Color(0xFF204E38),
        elevation: 0,
        leading: _isLoadingLocation
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : IconButton(
                icon: Icon(
                  _isUsingCurrentLocation ? Icons.my_location : Icons.location_on,
                  color: Colors.white,
                ),
                onPressed: _showLocationOptions,
              ),
        title: GestureDetector(
          onTap: _showLocationOptions,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _isUsingCurrentLocation 
                      ? _currentAddress 
                      : _selectedLocationName.isNotEmpty 
                          ? _selectedLocationName 
                          : _currentAddress,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Distance Slider Section
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Search within • ${_selectedDistance.toStringAsFixed(1)} km',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withOpacity(0.3),
                    thumbColor: Colors.white,
                    overlayColor: Colors.white.withOpacity(0.2),
                  ),
                  child: Slider(
                    value: _selectedDistance,
                    min: 1.0,
                    max: 50.0,
                    divisions: 49,
                    onChanged: (value) {
                      setState(() {
                        _selectedDistance = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Deals Count and Filter Info
          if (_userPosition != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    '${_filteredDeals.length} deals found',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  if (!_isUsingCurrentLocation)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Custom Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          
          // Deals List Section
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: _userPosition == null
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: Color(0xFF204E38)),
                          SizedBox(height: 16),
                          Text(
                            'Loading location...',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : _filteredDeals.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_off, size: 64, color: Colors.grey),
                              const SizedBox(height: 16),
                              const Text(
                                'No deals nearby',
                                style: TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try increasing the search distance',
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredDeals.length,
                          itemBuilder: (context, index) {
                            final deal = _filteredDeals[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DealDetailScreen(deal: deal),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      // Deal Image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          deal.imageUrl,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              width: 80,
                                              height: 80,
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.image, color: Colors.grey),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      
                                      // Deal Info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              deal.title,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              deal.businessName,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 12,
                                                  color: Colors.grey[500],
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                  _getDistanceText(deal),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF204E38),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                      // Deal Discount
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF204E38),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          deal.discount,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}