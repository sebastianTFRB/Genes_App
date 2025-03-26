import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genesapp/usersScreen/screens_guias/mucopolisacaridosis/mps_guia.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_down/sdown_guia.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_williams/swilliams_guia.dart';
import 'package:genesapp/widgets/custom_app_bar.dart';
import 'package:genesapp/widgets/roleBasedDrawer.dart';

class GuiasScreen extends StatefulWidget {
  const GuiasScreen({super.key});

  @override
  State<GuiasScreen> createState() => _GuiasScreenState();
}

class _GuiasScreenState extends State<GuiasScreen> {
  String? role;
  bool loading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> syndromes = [
    {
      "name": "Síndrome de Williams",
      "color": Colors.greenAccent.shade400,
      "screen": const GuiaSindromeWilliams(),
    },
    {
      "name": "Síndrome de Down",
      "color": Colors.orange.shade400,
      "screen": const GuiaSindromeDown(),
    },
    {
      "name": "Mucopolisacáridos",
      "color": Colors.yellow.shade600,
      "screen": const GuiaMucopolisacaridosis(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      setState(() {
        role = doc.data()?['role'];
        loading = false;
      });
    }
  }

  void selectSyndrome(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWithDrawer(
        title: syndromes[currentIndex]["name"],
        color: syndromes[currentIndex]["color"],
        scaffoldKey: _scaffoldKey,
      ),
      drawer: RoleBasedDrawer(role: role),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                child: Column(
                  children: [
                    GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity != null) {
                          if (details.primaryVelocity! < 0 &&
                              currentIndex < syndromes.length - 1) {
                            selectSyndrome(currentIndex + 1);
                          } else if (details.primaryVelocity! > 0 &&
                              currentIndex > 0) {
                            selectSyndrome(currentIndex - 1);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: syndromes[currentIndex]["color"],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (currentIndex > 0)
                                    selectSyndrome(currentIndex - 1);
                                },
                              ),
                              Expanded(
                                child: Center(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (
                                      Widget child,
                                      Animation<double> animation,
                                    ) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0.3, 0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      syndromes[currentIndex]["name"],
                                      key: ValueKey<String>(
                                        syndromes[currentIndex]["name"],
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (currentIndex < syndromes.length - 1) {
                                    selectSyndrome(currentIndex + 1);
                                  }
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: PopupMenuButton<int>(
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  onSelected: selectSyndrome,
                                  itemBuilder: (context) {
                                    return List.generate(syndromes.length, (
                                      index,
                                    ) {
                                      return PopupMenuItem<int>(
                                        value: index,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 12,
                                              height: 12,
                                              margin: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    syndromes[index]["color"],
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Text(
                                              syndromes[index]["name"],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: syndromes.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return syndromes[index]["screen"];
                        },
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
