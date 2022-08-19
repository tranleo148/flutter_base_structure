import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../l10n/bloc/language_bloc.dart';
import '../../l10n/l10n.dart';
import '../../src/utils/extensions.dart';
import '../constants/app_constants.dart';
import '../constants/assets_path.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) {},
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  LanguageBloc()..add(ChangeLanguageEvent(WidgetsBinding.instance.window.locale)),
            ),
          ],
          child: BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
            switch (state.runtimeType) {
              case LanguageLoadingState:
                return const Center(child: CircularProgressIndicator());
              case LanguageLoadedState:
                return _buildApp(context, (state as LanguageLoadedState).locale);
            }
            return _buildApp(context, WidgetsBinding.instance.window.locale);
          }),
        ));
  }

  Widget _buildApp(BuildContext context, Locale appLocale) {
    return MaterialApp(
      title: AppConst.appName,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: appLocale,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.copyWith(
              bodyMedium: const TextStyle(color: AppConst.textColor),
              displayMedium: const TextStyle(color: AppConst.textColor),
            ),
        /*textTheme: GoogleFonts.robotoTextTheme(
              Theme.of(context).textTheme,
            ),*/
        primarySwatch: AppConst.primaryColor,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false, // this to remove Debug banner
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyHomePageState extends State<MyHomePage> {
  static const int mDefaultPageIdx = 1; // Default page show-up when start app
  static const int mMainPageIdx = 1; // Page ignore when press on bottom bar
  static const int mMaxTabNum = 3; // Number of tab display on bottom bar
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  int _selectedIndex = mDefaultPageIdx;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: mDefaultPageIdx);
    super.initState();
  }

  // region Addition Methods
  void _onItemTapped(int index) {
    // Test change language
    if (index == 0) {
      context.read<LanguageBloc>().add(const ChangeLanguageEvent(Locale('en')));
    } else if (index == 2) {
      context.read<LanguageBloc>().add(const ChangeLanguageEvent(Locale('vi')));
    }
    if (index == mMainPageIdx) {
      _controller?.jumpToPage(index);
      setState(() {
        _selectedIndex = index;
      });
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(context.snackBarFeatureNotAvailableYet);
    }
  }

  void _pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // endregion

  // region Addition Widgets
  Widget buildBottomBarItem(int index, String? image, String text) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / mMaxTabNum,
      //color: Colors.blue,
      child: TextButton(
        onPressed: image != null
            ? () {
                if (index != mMainPageIdx) {
                  _onItemTapped(index);
                }
              }
            : null,
        child: Column(
          children: <Widget>[
            image != null
                ? Image.asset(
                    image,
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.contain,
                    color: _selectedIndex == index ? AppConst.primaryColor : AppConst.textColor,
                  )
                : const SizedBox(height: 30, width: 30),
            const SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: _selectedIndex == index ? AppConst.primaryColor : AppConst.textColor),
            )
          ],
        ),
      ),
    );
  }

  // endregion

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBody: true,
      // make body extend to bottom navigation bar
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          Container(
              color: Colors.pink,
              child: const Center(
                child: Text(
                  'Index 0',
                  style: optionStyle,
                ),
              )),
          Container(
              color: Colors.cyan,
              child: const Center(
                child: Text(
                  'Index 1',
                  style: optionStyle,
                ),
              )),
          Container(
              color: Colors.cyan,
              child: const Center(
                child: Text(
                  'Index 2',
                  style: optionStyle,
                ),
              )),
        ],
        onPageChanged: (index) {
          _pageChanged(index);
        },
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onItemTapped(mMainPageIdx);
        },
        elevation: 5,
        child: Image.asset(
          ImageAssets.UI_BTNICON_PLAYERBOY,
          width: 40.0,
          height: 40.0,
          fit: BoxFit.contain,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppConst.themeColor[100],
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 65,
          child: Row(
            children: <Widget>[
              buildBottomBarItem(0, ImageAssets.UI_BAGTABICON_WEAPON, 'Tab1'),
              buildBottomBarItem(1, null, 'Tab2'),
              buildBottomBarItem(2, ImageAssets.UI_BAGTABICON_EQUIP, 'Tab3'),
            ],
          ),
        ),
      ),
    );
  }
}
