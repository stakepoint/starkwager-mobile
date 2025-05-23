part of '../../feature.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final bool isVertical;
  final Color selectedColor;
  final Color unselectedColor;
  final List<NavigationItem> items;
  final Function(int) onIndexChanged;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    this.isVertical = false,
    required this.selectedColor,
    this.unselectedColor = AppColors.grayNeutral500,
    required this.items,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: isVertical ? 8 : 16,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: isVertical ? _buildVerticalLayout() : _buildHorizontalLayout(),
    );
  }

//----------------------------------------------- HORIZONTAL LAYOUT ----------------------------------------------- //

  Widget _buildHorizontalLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        items.length,
        (index) => _buildNavigationItem(index),
      ),
    );
  }

//----------------------------------------------- VERTICAL LAYOUT ----------------------------------------------- //

  Widget _buildVerticalLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        items.length,
        (index) => _buildNavigationItem(index),
      ),
    );
  }

//----------------------------------------------- NAVIGATION ITEM ----------------------------------------------- //

  Widget _buildNavigationItem(int index) {
    final isSelected = currentIndex == index;
    final item = items[index];

    Widget navItem = GestureDetector(
      onTap: () {
        onIndexChanged(index);
        item.onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: isVertical ? 16 : 8,
        ),
        child: isVertical
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 32,
                    width: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isSelected
                          ? AppColors.grayCool800
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        item.icon,
                        colorFilter: ColorFilter.mode(
                            isSelected ? selectedColor : unselectedColor,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? selectedColor : unselectedColor,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 32,
                    width: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isSelected
                          ? AppColors.grayCool800
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        item.icon,
                        colorFilter: ColorFilter.mode(
                            isSelected ? selectedColor : unselectedColor,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? selectedColor : unselectedColor,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: navItem,
    );
  }
}

//----------------------------------------------- NAVIGATION ITEM ----------------------------------------------- //

class NavigationItem {
  final String label;
  final String icon;
  final VoidCallback onTap;

  NavigationItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });
}
