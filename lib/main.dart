import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

// ==================== ЛОКАЛИЗАЦИЯ ====================
class AppStrings {
  final Locale locale;
  AppStrings(this.locale);

  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings)!;
  }

  static const LocalizationsDelegate<AppStrings> delegate = _AppStringsDelegate();

  static const supportedLocales = [
    Locale('tr', 'TR'),
    Locale('ru', 'RU'),
  ];

  String get appTitle => locale.languageCode == 'tr' ? 'Koyun Takip' : 'Учёт овец';
  String get animals => locale.languageCode == 'tr' ? 'Hayvanlar' : 'Животные';
  String get calendar => locale.languageCode == 'tr' ? 'Takvim' : 'Календарь';
  String get addRecord => locale.languageCode == 'tr' ? 'Kayıt ekle' : 'Добавить запись';
  String get scanQr => locale.languageCode == 'tr' ? 'QR tara' : 'Сканировать QR';
  String get rations => locale.languageCode == 'tr' ? 'Rasyon şablonları' : 'Рационы';
  String get turkish => 'Türkçe';
  String get russian => 'Русский';
}

class _AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _AppStringsDelegate();
  @override
  bool isSupported(Locale locale) => ['tr', 'ru'].contains(locale.languageCode);
  @override
  Future<AppStrings> load(Locale locale) async => AppStrings(locale);
  @override
  bool shouldReload(covariant LocalizationsDelegate<AppStrings> old) => false;
}

// ==================== ОСНОВНОЕ ПРИЛОЖЕНИЕ ====================
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('tr', 'TR');
  void setLocale(Locale l) => setState(() => _locale = l);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koyun Takip',
      locale: _locale,
      supportedLocales: AppStrings.supportedLocales,
      localizationsDelegates: const [
        AppStrings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}

// ==================== ГЛАВНЫЙ ЭКРАН ====================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.appTitle),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'tr') {
                MyApp.setLocale(context, const Locale('tr', 'TR'));
              } else if (v == 'ru') {
                MyApp.setLocale(context, const Locale('ru', 'RU'));
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'tr', child: Text(s.turkish)),
              PopupMenuItem(value: 'ru', child: Text(s.russian)),
            ],
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(s.animals, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Text(s.calendar, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Text(s.rations, style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: Text(s.addRecord),
      ),
    );
  }
}
