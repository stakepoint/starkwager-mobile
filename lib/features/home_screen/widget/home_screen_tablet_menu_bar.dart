part of '../../feature.dart';

class HomeScreenTabletMenuBar extends ConsumerStatefulWidget {
  final Widget child;

  const HomeScreenTabletMenuBar({
    required this.child,
    super.key,
  });

  @override
  ConsumerState<HomeScreenTabletMenuBar> createState() =>
      _HomeScreenTabletMenuBarState();
}

class _HomeScreenTabletMenuBarState
    extends ConsumerState<HomeScreenTabletMenuBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final GoRouter router = GoRouter.of(context);
      ref.read(navigationStateProvider.notifier).updateIndexFromRoute(
          router.routerDelegate.currentConfiguration.fullPath);
    });
  }

  void _onNavigate(int index) {
    String route;
    switch (index) {
      case 0:
        route = Routes.homeTablet;
        break;
      case 1:
        route = Routes.wagerTablet;
        break;
      case 2:
        route = Routes.walletTablet;
        break;
      case 3:
        route = Routes.profileTablet;
        break;
      default:
        route = Routes.homeTablet;
    }

    ref.read(navigationStateProvider.notifier).updateIndex(index);
    GoRouter.of(context).go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSideBar(),
          Expanded(child: widget.child),
        ],
      ),
    );
  }

  Widget _buildSideBar() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 208,
      color: context.sidebarBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(64),
            SvgPicture.asset(AppIcons.logoIcon),
            verticalSpace(40),
            _buildNewWagerButton(),
            verticalSpace(40), // Reduced from 120
            _buildNavItems(isVertical: true),
          ],
        ),
      ),
    );
  }

  Widget _buildNewWagerButton() {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(Routes.createWager);
      },
      child: Container(
        height: 56,
        width: 160,
        decoration: BoxDecoration(
          color: context.primaryButtonColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: context.menuShadowColor,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.handshakeIcon),
            const SizedBox(width: 12),
            Text('newWager'.tr(), style: AppTheme.of(context).textMediumMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItems({required bool isVertical}) {
    final items = [
      {
        'index': 0,
        'label': 'home'.tr(),
        'icon': AppIcons.homeNoneIcon,
      },
      {
        'index': 1,
        'label': 'wagers'.tr(),
        'icon': AppIcons.homeShakeIcon,
      },
      {
        'index': 2,
        'label': 'wallet'.tr(),
        'icon': AppIcons.walletIcon,
      },
      {
        'index': 3,
        'label': 'profile'.tr(),
        'icon': AppIcons.profileIcon,
      },
    ];

    return isVertical
        ? Column(
            children: items
                .map((item) => _buildNavItem(
                      item['index'] as int,
                      item['label'] as String,
                      item['icon'] as String,
                    ))
                .toList(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items
                .map((item) => _buildNavItem(
                      item['index'] as int,
                      item['label'] as String,
                      item['icon'] as String,
                    ))
                .toList(),
          );
  }

  Widget _buildNavItem(int index, String label, String icon) {
    final currentIndex = ref.watch(navigationStateProvider);
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => _onNavigate(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 32,
            width: 64,
            decoration: BoxDecoration(
              color: isSelected
                  ? context.textHintColor.withValues(alpha: 0.1)
                  : context.transparentColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              height: 32,
              width: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isSelected
                    ? context.menuBackgroundColor
                    : context.transparentColor,
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? context.primaryButtonColor
                        : context.menuTextColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? context.primaryButtonColor
                  : context.menuTextColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          verticalSpace(12),
        ],
      ),
    );
  }
}
