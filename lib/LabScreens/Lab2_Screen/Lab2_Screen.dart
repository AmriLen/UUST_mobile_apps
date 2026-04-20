import 'package:flutter/material.dart';
import 'package:uust_mobile_apps/drawer.dart';
import 'package:uust_mobile_apps/constants.dart';

// ─── Data model ───────────────────────────────────────────────────────────────

enum Difficulty { easy, medium, hard }

class CaminoRoute {
  final String name;
  final String nameEs;
  final String startPoint;
  final String routeMap;
  final int distanceKm;
  final int avgDays;
  final Difficulty difficulty;
  final String description;
  final List<String> highlights;
  final IconData icon;
  final Color color;

  const CaminoRoute({
    required this.name,
    required this.nameEs,
    required this.startPoint,
    required this.routeMap,
    required this.distanceKm,
    required this.avgDays,
    required this.difficulty,
    required this.description,
    required this.highlights,
    required this.icon,
    required this.color,
  });
}

const List<CaminoRoute> caminoRoutes = [
  CaminoRoute(
    name: 'Французский путь',
    nameEs: 'Camino Francés',
    startPoint: 'Сен-Жан-Пье-де-Пор, Франция',
    routeMap: 'assets/images/france-route.png',
    distanceKm: 800,
    avgDays: 30,
    difficulty: Difficulty.medium,
    description:
        'Самый популярный и известный маршрут Камино. Начинается у подножия '
        'Пиренеев во Франции, пересекает весь север Испании через Памплону, '
        'Логроньо, Бургос, Леон и заканчивается в Сантьяго-де-Компостела. '
        'Ежегодно его проходят более 200 000 паломников со всего мира.',
    highlights: [
      'Переход через Пиренеи (перевал Роланда)',
      'Средневековый центр Памплоны',
      'Собор Бургоса — объект ЮНЕСКО',
      'Железный крест (Cruz de Ferro)',
      'О Себрейро — галисийская деревня',
      'Кафедральный собор Сантьяго',
    ],
    icon: Icons.route,
    color: Color(0xFF2196F3),
  ),
  CaminoRoute(
    name: 'Португальский путь',
    nameEs: 'Camino Portugués',
    startPoint: 'Лиссабон, Португалия',
    routeMap: 'assets/images/portugal-route.png',
    distanceKm: 600,
    avgDays: 30,
    difficulty: Difficulty.easy,
    description:
        'Второй по популярности маршрут, идущий вдоль побережья Португалии '
        'и северо-западной Испании. Маршрут богат '
        'историческими городами и красивыми пейзажами.',
    highlights: [
      'Исторический центр Порту',
      'Средневековые деревни Галисии',
      'Паромная переправа в Редонделе',
      'Монастырь Сан-Педро-де-Тенорио',
    ],
    icon: Icons.sailing,
    color: Color(0xFF4CAF50),
  ),
  CaminoRoute(
    name: 'Португальский прибрежный путь',
    nameEs: 'Camino Portugués Coastal',
    startPoint: 'Порту, Португалия',
    routeMap: 'assets/images/portuguese-coastal-route.png',
    distanceKm: 270,
    avgDays: 10,
    difficulty: Difficulty.easy,
    description:
        'Один из коротких маршрутов, идущий вдоль побережья Португалии '
        'и северо-западной Испании. Путь начинается из Порту '
        '(240 км), получая Компостелу за последние 100 км. Маршрут богат '
        'историческими городами и красивыми пейзажами.',
    highlights: [
      'Исторический центр Порту',
      'Средневековые деревни Галисии',
      'Камень Педрон',
      'Паромная переправа в Редонделе',
      'Монастырь Сан-Педро-де-Тенорио',
    ],
    icon: Icons.beach_access,
    color: Color(0xFFFF9800),
  ),
  CaminoRoute(
    name: 'Северный путь',
    nameEs: 'Camino del Norte',
    startPoint: 'Ирун, Испания',
    routeMap: 'assets/images/nort-route.png',
    distanceKm: 820,
    avgDays: 35,
    difficulty: Difficulty.hard,
    description:
        'Один из наиболее живописных и физически сложных маршрутов. Проходит '
        'вдоль Кантабрийского побережья через Страну Басков, Кантабрию '
        'и Астурию. Постоянные подъёмы и спуски, но потрясающие виды '
        'на Атлантический океан компенсируют усилия.',
    highlights: [
      'Побережье Кантабрии',
      'Сан-Себастьян — гастрономическая столица',
      'Бильбао и музей Гуггенхайма',
      'Мыс Хигер',
      'Живописные рыбацкие деревни',
    ],
    icon: Icons.waves,
    color: Color(0xFF00BCD4),
  ),
  CaminoRoute(
    name: 'Изначальный путь',
    nameEs: 'Camino Primitivo',
    startPoint: 'Овьедо, Испания',
    routeMap: 'assets/images/primitive-route.png',
    distanceKm: 320,
    avgDays: 16,
    difficulty: Difficulty.hard,
    description:
        'Старейший маршрут Камино — именно им в IX веке прошёл король Альфонсо II. '
        'Самый сложный из основных маршрутов: суровый горный рельеф Астурии '
        'и Галисии, дикая природа и мало туристов. Для опытных паломников.',
    highlights: [
      'Собор Овьедо',
      'Горные перевалы Астурии',
      'Первобытная природа Галисии',
      'Исторические деревни',
      'Слияние с Французским путём в Мелиде',
    ],
    icon: Icons.terrain,
    color: Color(0xFF795548),
  ),
  CaminoRoute(
    name: 'Серебряный путь',
    nameEs: 'Vía de la Plata',
    startPoint: 'Севилья, Испания',
    routeMap: 'assets/images/silver-route.png',
    distanceKm: 1000,
    avgDays: 40,
    difficulty: Difficulty.hard,
    description:
        'Самый длинный маршрут Камино, идущий с юга на север по древней '
        'римской дороге. Пересекает Андалусию, Эстремадуру и Кастилию. '
        'Малолюдный, требующий серьёзной подготовки, но дающий глубокое '
        'погружение в историю и культуру Испании.',
    highlights: [
      'Собор Севильи',
      'Мериде — римские руины',
      'Касерес — средневековый город ЮНЕСКО',
      'Саламанка — университетский город',
      'Бесконечные просторы Эстремадуры',
    ],
    icon: Icons.history,
    color: Color.fromARGB(255, 197, 112, 0),
  ),
  CaminoRoute(
    name: 'Английский путь',
    nameEs: 'Camino Inglés',
    startPoint: 'Феррол / А-Корунья, Испания',
    routeMap: 'assets/images/english-route.png',
    distanceKm: 120,
    avgDays: 5,
    difficulty: Difficulty.easy,
    description:
        'Самый короткий маршрут, исторически использовавшийся британскими '
        'и скандинавскими паломниками, добиравшимися морем до галисийских '
        'портов. Из Феррола — 120 км, из А-Коруньи — 75 км. '
        'Идеален для тех, у кого мало времени.',
    highlights: [
      'Морские виды Галисии',
      'Средневековый Понтедеуме',
      'Тихие деревенские дороги',
      'Быстрое завершение паломничества',
    ],
    icon: Icons.directions_boat,
    color: Color(0xFF9C27B0),
  ),
  CaminoRoute(
    name: 'Путь к Финистерре',
    nameEs: 'Camino a Finisterre',
    startPoint: 'Сантьяго-де-Компостела, Испания',
    routeMap: 'assets/images/finisterre-route.png',
    distanceKm: 90,
    avgDays: 6,
    difficulty: Difficulty.easy,
    description:
        'Не требует Компостелы — это продолжение паломничества от Сантьяго '
        'до мыса Финистерре («край земли»). В средние века считался '
        'конечной точкой известного мира. Паломники традиционно сжигают '
        'здесь свои ботинки или носки.',
    highlights: [
      'Мыс Финистерре — «край земли»',
      'Маяк Финистерре',
      'Закат над Атлантикой',
      'Традиция сожжения одежды',
      'Дополнительный сертификат — Финистеррана',
    ],
    icon: Icons.wb_sunny,
    color: Color(0xFFFF5722),
  ),
];

// ─── Pilgrim tips data ─────────────────────────────────────────────────────────

class TipSection {
  final String title;
  final IconData icon;
  final List<String> items;
  const TipSection({required this.title, required this.icon, required this.items});
}

const List<TipSection> pilgrimTips = [
  TipSection(
    title: 'Лучшее время для похода',
    icon: Icons.calendar_today,
    items: [
      'Апрель–июнь: комфортная погода, зелёные пейзажи',
      'Сентябрь–октябрь: меньше туристов, хорошая погода',
      'Июль–август: жарко, многолюдно, нужно бронировать заранее',
      'Зима: малолюдно, холодно, некоторые альберги закрыты',
      '25 июля — День святого Иакова: особый праздник в Сантьяго',
    ],
  ),
  TipSection(
    title: 'Документы паломника',
    icon: Icons.book,
    items: [
      'Credencial del Peregrino — паспорт паломника',
      'Получить можно в церквях, туристических офисах Камино',
      'Ставить печати (sellos) каждые 1–2 км пути',
      'Для Компостелы нужно 2 печати в день (последние 100 км)',
      'Compоstela — сертификат выдаётся в соборе Сантьяго',
      'Fisterrana — дополнительный сертификат для маршрута до Финистерре',
    ],
  ),
  TipSection(
    title: 'Жильё в пути',
    icon: Icons.hotel,
    items: [
      'Альберге (Albergue) — хостел для паломников, от 8–15€',
      'Муниципальные альберге — самые дешёвые',
      'Частные альберге — лучше условия, немного дороже',
      'Рекомендуется бронировать в сезон (июль–август)',
      'Casa rural — фермерский дом, уютная альтернатива',
      'Принимают только паломников с Credencial',
    ],
  ),
  TipSection(
    title: 'Что взять с собой',
    icon: Icons.backpack,
    items: [
      'Рюкзак не более 10% веса тела (обычно 8–10 кг)',
      'Трекинговые ботинки с разношенной подошвой',
      'Трекинговые палки — спасут колени на спусках',
      'Спальный мешок (до +15°С) или вкладыш',
      'Дождевик и чехол на рюкзак',
      'Аптечка: пластыри, иглы для мозолей, крем от потёртостей',
      'Фонарик — старт часто в 6 утра',
    ],
  ),
  TipSection(
    title: 'Питание и вода',
    icon: Icons.restaurant,
    items: [
      'Menú del peregrino — обед из 3 блюд за 10–12€',
      'Bocadillo — бутерброд, идеален в дорогу',
      'Питьевые фонтанчики (fuentes) каждые несколько км',
      'Брать воду минимум 1–1.5 литра на сложных участках',
      'Тинто де веррано и сидр — местные напитки',
      'Кофе с круассаном — традиционный завтрак паломника',
    ],
  ),
  TipSection(
    title: 'Стоимость маршрута',
    icon: Icons.euro,
    items: [
      'Эконом-бюджет: 25–35€ в день',
      'Средний бюджет: 40–60€ в день',
      'Альберге: 8–15€ за ночь',
      'Питание: 15–25€ в день',
      'Французский путь (30 дней): от 750€ до 1800€',
      'Португальский путь из Порту (10 дней): от 250€',
    ],
  ),
  TipSection(
    title: 'Маркировка пути',
    icon: Icons.sign_language,
    items: [
      'Жёлтая стрелка (flecha amarilla) — основной указатель',
      'Столбики с ракушкой — официальная навигация',
      'Раковина гребешка — символ паломника',
      'Приложение Buen Camino — GPS навигация офлайн',
      'Книга «A Pilgrim\'s Guide to the Camino» — детальный гайд',
    ],
  ),
];

// ─── Main Screen ──────────────────────────────────────────────────────────────

class Lab2 extends StatefulWidget {
  const Lab2({Key? key}) : super(key: key);

  @override
  State<Lab2> createState() => _Lab2State();
}

class _Lab2State extends State<Lab2> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Путь Святого Иакова', style: unbReg),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.map), text: 'Маршруты'),
            Tab(icon: Icon(Icons.info_outline), text: 'Паломникам'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _RoutesTab(),
          _TipsTab(),
        ],
      ),
    );
  }
}

// ─── Routes Tab ───────────────────────────────────────────────────────────────

class _RoutesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _CaminoHeader()),
        SliverToBoxAdapter(child: _MapCard(routeMapImage: 'assets/images/cds-map.png')),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _RouteCard(route: caminoRoutes[index]),
              childCount: caminoRoutes.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}

class _MapCard extends StatelessWidget {
  final CaminoRoute? route;
  final String? routeMapImage;
  const _MapCard({
    this.route,
    this.routeMapImage,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(routeMapImage ?? route!.routeMap),
          fit: BoxFit.contain,
        )
      ),
    );
  }
}

class _CaminoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🐚', style: TextStyle(fontSize: 36)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Buen Camino!',
                        style: unbBoldW.copyWith(fontSize: 20)),
                    Text('Добро пожаловать в паломничество',
                        style: unbRegWMin),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Камино де Сантьяго — сеть древних паломнических маршрутов, ведущих '
            'к собору Сантьяго-де-Компостела в Галисии (Испания), где покоятся '
            'мощи апостола Иакова.',
            style: unbRegWMin.copyWith(height: 1.5),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _StatChip(icon: Icons.route, label: '${caminoRoutes.length} маршрутов'),
              const SizedBox(width: 8),
              _StatChip(icon: Icons.people, label: '+300 тыс. / год'),
              const SizedBox(width: 8),
              _StatChip(icon: Icons.public, label: 'ЮНЕСКО'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(label, style: unbRegWMin.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

class _RouteCard extends StatelessWidget {
  final CaminoRoute route;
  const _RouteCard({required this.route});

  String get _difficultyLabel {
    switch (route.difficulty) {
      case Difficulty.easy: return 'Лёгкий';
      case Difficulty.medium: return 'Средний';
      case Difficulty.hard: return 'Сложный';
    }
  }

  Color get _difficultyColor {
    switch (route.difficulty) {
      case Difficulty.easy: return Colors.green;
      case Difficulty.medium: return Colors.orange;
      case Difficulty.hard: return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => _RouteDetailScreen(route: route)),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: route.color,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(route.icon, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(route.name, style: unbBoldW.copyWith(fontSize: 14)),
                        Text(route.nameEs,
                            style: unbRegWMin.copyWith(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _InfoBadge(icon: Icons.straighten, label: '${route.distanceKm} км'),
                      const SizedBox(width: 8),
                      _InfoBadge(icon: Icons.today, label: '~${route.avgDays} дней'),
                      const SizedBox(width: 8),
                      _InfoBadge(
                        icon: Icons.fitness_center,
                        label: _difficultyLabel,
                        color: _difficultyColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.place, size: 14, color: Colors.black54),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Старт: ${route.startPoint}',
                          style: unbRegMin.copyWith(color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    route.description,
                    style: unbRegMin.copyWith(height: 1.4, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  const _InfoBadge({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? Colors.blueGrey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: c),
          const SizedBox(width: 3),
          Text(label, style: unbRegMin.copyWith(fontSize: 11, color: c)),
        ],
      ),
    );
  }
}

// ─── Route Detail Screen ──────────────────────────────────────────────────────

class _RouteDetailScreen extends StatelessWidget {
  final CaminoRoute route;
  const _RouteDetailScreen({required this.route});

  String get _difficultyLabel {
    switch (route.difficulty) {
      case Difficulty.easy: return 'Лёгкий';
      case Difficulty.medium: return 'Средний';
      case Difficulty.hard: return 'Сложный';
    }
  }

  Color get _difficultyColor {
    switch (route.difficulty) {
      case Difficulty.easy: return Colors.green;
      case Difficulty.medium: return Colors.orange;
      case Difficulty.hard: return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(route.name, style: unbReg),
        backgroundColor: route.color,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailHeader(route: route),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatsRow(route: route, difficultyLabel: _difficultyLabel, difficultyColor: _difficultyColor),
                  _MapCard(route: route),
                  const SizedBox(height: 20),
                  Text('О маршруте', style: unbBold),
                  const SizedBox(height: 8),
                  Text(route.description,
                      style: unbRegMin.copyWith(height: 1.6, color: Colors.black87)),
                  const SizedBox(height: 20),
                  Text('Главные достопримечательности', style: unbBold),
                  const SizedBox(height: 8),
                  ...route.highlights.map((h) => _HighlightItem(text: h)),
                  const SizedBox(height: 24),
                  _RouteFooter(route: route),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  final CaminoRoute route;
  const _DetailHeader({required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [route.color, route.color.withValues(alpha: 0.7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(route.icon, size: 52, color: Colors.white),
          const SizedBox(height: 12),
          Text(route.name, style: unbBoldW.copyWith(fontSize: 22)),
          Text(route.nameEs,
              style: unbRegWMin.copyWith(fontSize: 14, fontStyle: FontStyle.italic)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.place, size: 14, color: Colors.white70),
              const SizedBox(width: 4),
              Expanded(
                child: Text('Старт: ${route.startPoint}',
                    style: unbRegWMin.copyWith(fontSize: 11)),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.flag, size: 14, color: Colors.white70),
              const SizedBox(width: 4),
              Text('Финиш: Сантьяго-де-Компостела, Испания',
                  style: unbRegWMin.copyWith(fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final CaminoRoute route;
  final String difficultyLabel;
  final Color difficultyColor;
  const _StatsRow({
    required this.route,
    required this.difficultyLabel,
    required this.difficultyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatCard(icon: Icons.straighten, value: '${route.distanceKm}', unit: 'км', color: Colors.blue)),
        const SizedBox(width: 8),
        Expanded(child: _StatCard(icon: Icons.today, value: '~${route.avgDays}', unit: 'дней', color: Colors.teal)),
        const SizedBox(width: 8),
        Expanded(child: _StatCard(icon: Icons.fitness_center, value: difficultyLabel, unit: 'сложность', color: difficultyColor)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;
  final Color color;
  const _StatCard({required this.icon, required this.value, required this.unit, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(value, style: unbBold.copyWith(color: color, fontSize: 14)),
          Text(unit, style: unbRegMin.copyWith(color: Colors.black54, fontSize: 10)),
        ],
      ),
    );
  }
}

class _HighlightItem extends StatelessWidget {
  final String text;
  const _HighlightItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🐚 ', style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(text, style: unbRegMin.copyWith(height: 1.4)),
          ),
        ],
      ),
    );
  }
}

class _RouteFooter extends StatelessWidget {
  final CaminoRoute route;
  const _RouteFooter({required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: route.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: route.color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tips_and_updates, color: route.color, size: 18),
              const SizedBox(width: 8),
              Text('Совет', style: unbBold.copyWith(color: route.color, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Для получения Компостелы пройдите пешком минимум последние 100 км '
            '(или 200 км на велосипеде). Делайте по 2 штампа в день в любых '
            'альберге, кафе, церквях.',
            style: unbRegMin.copyWith(height: 1.5, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// ─── Tips Tab ─────────────────────────────────────────────────────────────────

class _TipsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _TipsHeader(),
        const SizedBox(height: 12),
        ...pilgrimTips.map((section) => _TipsSectionCard(section: section)),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _TipsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFFFA726)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Text('🎒', style: TextStyle(fontSize: 36)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Советы паломнику', style: unbBoldW.copyWith(fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  'Всё, что нужно знать перед выходом на Камино',
                  style: unbRegWMin.copyWith(height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TipsSectionCard extends StatefulWidget {
  final TipSection section;
  const _TipsSectionCard({required this.section});

  @override
  State<_TipsSectionCard> createState() => _TipsSectionCardState();
}

class _TipsSectionCardState extends State<_TipsSectionCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(widget.section.icon, size: 22, color: const Color(0xFFE65100)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(widget.section.title, style: unbBold.copyWith(fontSize: 13)),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.black54,
                  ),
                ],
              ),
              if (_expanded) ...[
                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 10),
                ...widget.section.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_outline,
                          size: 14, color: Color(0xFFE65100)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(item,
                            style: unbRegMin.copyWith(height: 1.4, color: Colors.black87)),
                      ),
                    ],
                  ),
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
