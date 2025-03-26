import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:genesapp/adminScreen/admin.dart';
import 'package:genesapp/adminScreen/adminrequest.dart';
import 'package:genesapp/medicScreen/articles.dart';
import 'package:genesapp/medicScreen/medico.dart';
import 'package:genesapp/medicScreen/viewArticles.dart';
import 'package:genesapp/pacientScreen/paciente.dart';
import 'package:genesapp/usersScreen/perfil.dart';
import 'package:genesapp/login.dart';

import 'package:genesapp/usersScreen/williamspredict.dart';

class RoleBasedDrawer extends StatelessWidget {
  final String? role;

  const RoleBasedDrawer({
    super.key,
    required this.role,
  });

  void _handleLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 140,
          width: double.infinity,
          
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF43cea2), Color(0xFF185a9d)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset('assets/images/GenesApp2.png'),
            ),
          ),

        ),

        
        if (role == 'admin') ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('ADMINISTRADOR', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings, color: Colors.blueAccent),
            title: const Text('Panel de Administrador'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.verified_user, color: Colors.blueAccent),
            title: const Text('Panel de Verificación'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminVerificationPanel()),
              );
            },
          ),
        ],
        if (role == 'doctor') ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('MÉDICO', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          ListTile(
            leading: const Icon(Icons.medical_services, color: Colors.teal),
            title: const Text('Panel de Médico'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DoctorScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.article, color: Colors.teal),
            title: const Text('subir articulo'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SubirArticuloScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.feed, color: Colors.teal),
            title: const Text('publicaciones'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VerArticulosScreen()),
            ),
          ),
        ],
        if (role == 'patient') ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('PACIENTE', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
            title: const Text('Panel de Paciente'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            ),
          ),
        ],
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('UTILIDADES', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
        ),
        ListTile(
          leading: const Icon(Icons.analytics, color: Colors.deepPurple),
          title: const Text('predictividad williams'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Williamspredict()),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.person, color: Colors.indigo),
          title: const Text('Mi perfil'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.redAccent),
          title: const Text('Cerrar sesión'),
          onTap: () => _handleLogout(context),
        ),
      ],
    ),
  );
}

}
  