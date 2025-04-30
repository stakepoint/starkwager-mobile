part of '../feature.dart';

class CreateWagerScreen extends ConsumerStatefulWidget {
  const CreateWagerScreen({super.key});

  @override
  ConsumerState<CreateWagerScreen> createState() => _CreateWagerScreenState();
}

class _CreateWagerScreenState extends ConsumerState<CreateWagerScreen> {
  bool _isLoadingCategories = false;
  bool _isLoadingHashtags = false;
  String? _categoriesError;
  String? _hashtagsError;

  @override
  void initState() {
    super.initState();
    // Fetch categories and hashtags when screen initializes
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Initial fetch of categories and hashtags
      _fetchCategoriesAndHashtags();
    });
  }

  void _fetchCategoriesAndHashtags() async {
    setState(() {
      _isLoadingCategories = true;
      _isLoadingHashtags = true;
      _categoriesError = null;
      _hashtagsError = null;
    });

    try {
      await ref.read(categoriesNotifierProvider.notifier).fetchCategories();
    } catch (e) {
      setState(() {
        _categoriesError = e.toString();
      });
    } finally {
      setState(() {
        _isLoadingCategories = false;
      });
    }

    try {
      await ref.read(hashtagsApiNotifierProvider.notifier).fetchHashtags();
    } catch (e) {
      setState(() {
        _hashtagsError = e.toString();
      });
    } finally {
      setState(() {
        _isLoadingHashtags = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final selectedHashtags = ref.watch(selectedHashtagsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    String getDisplayText() {
      if (selectedHashtags.isEmpty) {
        return 'addHashtags'.tr();
      }
      if (selectedHashtags.length == 1) {
        return '#${selectedHashtags.first}';
      }
      return '${selectedHashtags.length} selected';
    }

    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: BaseAppbar(
          context: context, title: 'createWager'.tr(), userName: '@noyi24_7'),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: context.isMobile
                ? EdgeInsets.all(20)
                : EdgeInsets.symmetric(horizontal: 120),
            child: Column(
              crossAxisAlignment: context.isMobile
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                if (context.isMobile)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'createWager'.tr(),
                      style: AppTheme.of(context).headLineLarge32,
                    ),
                  ),
                verticalSpace(size.height * 0.02),
                if (context.isMobile) Divider(),
                verticalSpace(size.height * 0.03),
                // Show API states if needed for debugging
                if (_categoriesError != null || _hashtagsError != null)
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 26),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _categoriesError != null
                          ? 'Error loading categories: $_categoriesError'
                          : 'Error loading hashtags: $_hashtagsError',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                // Continue with the rest of the UI
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showCategoryDialog(context, ref),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.textBoxTextColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _isLoadingCategories
                                    ? Center(
                                        child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2)))
                                    : Text(
                                        selectedCategory ??
                                            'selectCategory'.tr(),
                                        style: AppTheme.of(context)
                                            .textMediumMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: context
                                      .primaryTextColor), // Dropdown icon
                            ],
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace(AppValues.width16),
                    Expanded(
                      child: InkWell(
                        onTap: () => _showHashtagSelector(
                            context, ref, context.isMobile),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 17),
                          decoration: BoxDecoration(
                            color: context.textBoxTextColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _isLoadingHashtags
                                    ? Center(
                                        child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2)))
                                    : Text(
                                        getDisplayText(),
                                        style: AppTheme.of(context)
                                            .textMediumMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: context.primaryTextColor),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(AppValues.height25),
                buildCreateWagerTextField(
                    context, 'titleOfYourWager'.tr(), 'wager.strk/'.tr(), 50),
                verticalSpace(AppValues.height30),
                buildCreateWagerTextField(context,
                    'termsOrWagerDescription'.tr(), 'wager.strk/'.tr(), 1000,
                    maxLine: 3),
                verticalSpace(AppValues.height30),
                buildStakeTextField(context, ref, 'stake'.tr()),
                verticalSpace(size.height * 0.06),
                PrimaryButton(
                  buttonText: 'continue'.tr(),
                  isActive: true,
                  onPressed: () {
                    GoRouter.of(context).push(Routes.createWagerSummary);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------------------------- STAKE FIELD ----------------------------------------------- //

  Widget buildStakeTextField(
      BuildContext context, WidgetRef ref, String title) {
    final controller = ref.watch(textControllerProvider);
    final isStark = ref.watch(isStarkProvider);
    final stakeAmount = ref.watch(stakeAmountProvider);

    final NumberFormat decimalFormatter = NumberFormat("#,##0.00", "en_US");

    final String conversionText = stakeAmount > 0
        ? (isStark
            ? " ${decimalFormatter.format(stakeAmount * 0.24)} USD" // Only show USD equivalent when in STRK mode
            : " ${decimalFormatter.format(stakeAmount)} STRK") // Only show STRK equivalent when in USD mode
        : isStark
            ? "1 STRK ≈ 0.24 USD"
            : "1 USD ≈ 4.17 STRK";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr(),
          style: AppTheme.of(context).textSmallMedium.copyWith(
                color: context.primaryTextColor,
              ),
        ),
        SizedBox(height: 5),
        Stack(
          children: [
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(fontSize: 16),
              onChanged: (value) {
                String numericValue = value.replaceAll(RegExp(r'[^\d]'), '');

                if (numericValue.isEmpty) {
                  ref.read(stakeAmountProvider.notifier).state = 0.0;
                  controller.text = '';
                  return;
                }

                int length = numericValue.length;
                String wholePart =
                    length > 2 ? numericValue.substring(0, length - 2) : '0';
                String decimalPart = length >= 2
                    ? numericValue.substring(length - 2)
                    : numericValue.padLeft(2, '0');

                double amount = double.parse('$wholePart.$decimalPart');

                if (isStark) {
                  ref.read(stakeAmountProvider.notifier).state = amount;
                } else {
                  ref.read(stakeAmountProvider.notifier).state = amount / 0.24;
                }

                String formattedValue = decimalFormatter.format(amount);

                if (formattedValue != controller.text) {
                  controller.value = TextEditingValue(
                    text: formattedValue,
                    selection:
                        TextSelection.collapsed(offset: formattedValue.length),
                  );
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
                filled: true,
                fillColor: context.textBoxTextColor,
                hintText: '0',
                hintStyle: TextStyle(color: context.textHintColor),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      final newIsStark = !isStark;
                      ref.read(isStarkProvider.notifier).state = newIsStark;

                      final currentText = controller.text;
                      if (currentText.isNotEmpty) {
                        final currentValue = double.tryParse(currentText
                                .replaceAll(RegExp(r'[^\d.]'), '')) ??
                            0.0;

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          double newValue;
                          if (newIsStark) {
                            newValue = currentValue / 0.24;
                          } else {
                            newValue = currentValue * 0.24;
                          }

                          controller.text = decimalFormatter.format(newValue);

                          controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: controller.text.length),
                          );
                        });
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        color: context.primaryBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.sync, color: context.primaryTextColor),
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 12,
              child: Text(
                isStark ? 'amountInStark'.tr() : "amountInUsd".tr(),
                style: TextStyle(
                  color: context.primaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'youHave50.00Strk'.tr(),
              style: TextStyle(
                color: context.textHintColor,
              ),
            ),
            Flexible(
              child: Text(
                conversionText,
                style: TextStyle(
                  color: context.textHintColor,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showCategoryDialog(BuildContext context, WidgetRef ref) async {
    Future<String?> showBottomSheet(BuildContext context, Widget child) async {
      return await showModalBottomSheet<String>(
        context: context,
        backgroundColor: context.transparentColor,
        isScrollControlled: true,
        builder: (context) => Container(
          decoration: BoxDecoration(
            color: context.primaryBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: child,
        ),
      );
    }

    Future<String?> showCategoryDialog(
        BuildContext context, Widget child) async {
      return await showDialog<String>(
        context: context,
        builder: (context) => child,
      );
    }

    Widget buildCategorySelectionDialog(
        BuildContext context, List<String> categories) {
      return AlertDialog(
        backgroundColor: context.containerColor,
        surfaceTintColor: context.primaryBackgroundColor,
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: const EdgeInsets.only(right: 20, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(),
              Text(
                'selectCategory'.tr(),
                style: AppTheme.of(context).titleExtraLarge24,
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  size: 24,
                  color: context.primaryTextColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 500,
            child: Column(
              children: [
                ...categories.map(
                  (category) => InkWell(
                    onTap: () => Navigator.of(context).pop(category),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    category,
                                    style: AppTheme.of(context).textSmallMedium,
                                  ),
                                  SizedBox(width: 5),
                                  if (ref.watch(selectedCategoryProvider) ==
                                      category)
                                    SvgPicture.asset(AppIcons.checked),
                                ],
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        if (category != categories[categories.length - 1])
                          buildDotedBorder(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildBottomSheet(List<String> categories) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(),
                    Text(
                      'selectCategory'.tr(),
                      style: AppTheme.of(context).titleExtraLarge24,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 24,
                        color: context.primaryTextColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: categories.map((category) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop(category);
                              ref
                                  .read(selectedCategoryProvider.notifier)
                                  .state = category;
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    category,
                                    style: AppTheme.of(context).textSmallMedium,
                                  ),
                                  SizedBox(width: 5),
                                  if (ref.watch(selectedCategoryProvider) ==
                                      category)
                                    SvgPicture.asset(AppIcons.checked),
                                ],
                              ),
                            ),
                          ),
                          if (category != categories[categories.length - 1])
                            buildDotedBorder(context),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final categoryNotifier = ref.watch(categoriesProvider);

    final selected = await (context.isMobile
        ? showBottomSheet(context, buildBottomSheet(categoryNotifier))
        : showCategoryDialog(
            context, buildCategorySelectionDialog(context, categoryNotifier)));
    if (selected != null) {
      ref.read(selectedCategoryProvider.notifier).state = selected;
    }
  }

  Widget buildDotedBorder(BuildContext context) {
    return Row(
      children: List.generate(
          500 ~/ 10,
          (index) => Expanded(
                child: Container(
                  color: index % 2 == 0
                      ? Colors.transparent
                      : context.dividerColor,
                  height: 1,
                ),
              )),
    );
  }

//----------------------------------------------- CATEGORYWAGER TEXTFIELD ----------------------------------------------- //

  Widget buildCreateWagerTextField(
      BuildContext context, String title, String hintText, int maxLength,
      {int maxLine = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.of(context).textSmallMedium,
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
          buildCounter: (BuildContext context,
              {int? currentLength, int? maxLength, bool? isFocused}) {
            return Text(
              '$currentLength/$maxLength',
              style: TextStyle(
                color: context.textHintColor,
              ),
            );
          },
          maxLines: maxLine,
          maxLength: maxLength,
          decoration: InputDecoration(
            filled: true,
            fillColor: context.textBoxTextColor,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

//----------------------------------------------- HASHTAG SELECTORS ----------------------------------------------- //

  void _showHashtagSelector(
      BuildContext context, WidgetRef ref, bool isMobile) {
    if (isMobile) {
      showModalBottomSheet(
        backgroundColor: context.primaryBackgroundColor,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) => const HashtagBottomSheet(),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const HashtagDialog(),
      );
    }
  }
}

//----------------------------------------------- HASHTAG DIALOG ----------------------------------------------- //
class HashtagDialog extends ConsumerWidget {
  const HashtagDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hashtags = ref.watch(hashtagsListProvider);
    final selectedHashtags = ref.watch(selectedHashtagsProvider);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.containerColor,
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'addHashtag(s)'.tr(),
                    style: AppTheme.of(context).titleExtraLarge24,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 24,
                      color: context.primaryTextColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            verticalSpace(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'hashtagshelpotherusersfindyourwagereasilyandquickly'.tr(),
                  style: AppTheme.of(context).textMediumNormal,
                ),
              ],
            ),
            verticalSpace(24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  _buildHashtagChips(context, hashtags, selectedHashtags, ref),
            ),
          ],
        ),
      ),
    );
  }
}

//----------------------------------------------- HASHTAG BOTTOM SHEET ----------------------------------------------- //
class HashtagBottomSheet extends ConsumerWidget {
  const HashtagBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hashtags = ref.watch(hashtagsListProvider);
    final selectedHashtags = ref.watch(selectedHashtagsProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.primaryBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'addHashtag(s)'.tr(),
                  style: AppTheme.of(context).titleExtraLarge24,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 24,
                    color: context.primaryTextColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          verticalSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                'hashtagshelpotherusersfindyourwagereasilyandquickly'.tr(),
                style: AppTheme.of(context).textMediumNormal,
              ),
            ],
          ),
          verticalSpace(24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                _buildHashtagChips(context, hashtags, selectedHashtags, ref),
          ),
          verticalSpace(24),
        ],
      ),
    );
  }
}

//----------------------------------------------- HASHTAG CHIPS ----------------------------------------------- //

List<Widget> _buildHashtagChips(BuildContext context, List<String> hashtags,
    Set<String> selectedHashtags, WidgetRef ref) {
  return hashtags.map((hashtag) {
    final isSelected = selectedHashtags.contains(hashtag);
    return GestureDetector(
      onTap: () {
        ref.read(selectedHashtagsProvider.notifier).toggleHashtag(hashtag);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? context.isDarkMode
                  ? AppColors.buttonColor // Yellow in dark mode
                  : AppColors.tabSelectedColor // Blue in light mode
              : context.isDarkMode
                  ? AppColors.grayNeutral800 // Dark in dark mode
                  : AppColors.grayCool100, // Light gray in light mode
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppIcons.hashTagIcon,
              colorFilter: ColorFilter.mode(
                  isSelected
                      ? context.isDarkMode
                          ? AppColors.grayNeutral800 // Dark text on yellow in dark mode
                          : AppColors.white // White text on blue in light mode
                      : context.primaryTextColor,
                  BlendMode.srcIn),
            ),
            horizontalSpace(4),
            Text(
              hashtag,
              style: AppTheme.of(context).textRegularMedium.copyWith(
                    color: isSelected
                        ? context.isDarkMode
                            ? AppColors.grayNeutral800 // Dark text on yellow in dark mode
                            : AppColors.white // White text on blue in light mode
                        : context.primaryTextColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }).toList();
}
