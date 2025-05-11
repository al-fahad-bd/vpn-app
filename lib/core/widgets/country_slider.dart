import 'package:flutter/material.dart';

class CountrySlider extends StatefulWidget {
  final List<String> countryFlags;
  final ValueChanged<int> onChanged;

  const CountrySlider({
    super.key,
    required this.countryFlags,
    required this.onChanged,
  });

  @override
  CountrySliderState createState() => CountrySliderState();
}

class CountrySliderState extends State<CountrySlider> {
  final PageController _pageController = PageController(
    viewportFraction: 0.25,
    initialPage: 2,
  );
  int _currentIndex = 2; // Default selected index

  final Map<String, String> countryNames = {
    'assets/countryFlags/ca.png': 'Canada',
    'assets/countryFlags/sa.png': 'Saudi Arabia',
    'assets/countryFlags/bd.png': 'Bangladesh',
    'assets/countryFlags/us.png': 'United States',
    'assets/countryFlags/af.png': 'Afganistan',
    'assets/countryFlags/cn.png': 'China',
    // Add more mappings as needed
  };

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int newIndex = _pageController.page!.round();
      if (newIndex != _currentIndex) {
        setState(() {
          _currentIndex = newIndex;
          widget.onChanged(_currentIndex);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.countryFlags.length,
        clipBehavior: Clip.none,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          widget.onChanged(index);
        },
        itemBuilder: (context, index) {
          double scale = (index == _currentIndex) ? 1.3 : 0.8;

          return Transform.scale(
            scale: scale,
            child: Column(
              children: [
                if (index == _currentIndex)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Circular shape
                      border: Border.all(
                        color: const Color(0xff4FD6F7), // Border color
                        width: 1, // Border width
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        widget.countryFlags[index],
                        width: 60, // Adjust width and height as needed
                        height: 60,
                        fit: BoxFit
                            .cover, // Ensures the image covers the circular area
                      ),
                    ),
                  )
                else
                  ClipOval(
                    child: Image.asset(
                      widget.countryFlags[index],
                      width: 60, // Adjust width and height as needed
                      height: 60,
                      fit: BoxFit
                          .cover, // Ensures the image covers the circular area
                    ),
                  ),
                if (index == _currentIndex)
                  const SizedBox(
                    height: 18,
                  ),
                if (index == _currentIndex)
                  Text(
                    countryNames[widget.countryFlags[index]] ?? 'Unknown',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
