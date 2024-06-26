import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';



class ThemeProvider with ChangeNotifier {
  TextStyle get headerStyle => GoogleFonts.comfortaa(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle get bodyStyle => GoogleFonts.syne(fontSize: 14);
  TextStyle get buttonStyle => GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle get captionStyle => GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.bold);
  TextStyle get subtitleStyle => GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle get titleStyle => GoogleFonts.mansalva(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle get errorStyle => GoogleFonts.openSans(fontSize: 14, color: Colors.red);
  TextStyle get successStyle => GoogleFonts.openSans(fontSize: 14, color: Colors.green);
  TextStyle get infoStyle => GoogleFonts.openSans(fontSize: 14, color: Colors.blue);
  TextStyle get warningStyle => GoogleFonts.openSans(fontSize: 14, color: Colors.orange);
  TextStyle get linkStyle => GoogleFonts.openSans(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline);
  TextStyle get disabledStyle => GoogleFonts.openSans(fontSize: 14, color: Colors.grey);
  TextStyle get activeStyle => GoogleFonts.openSans(fontSize: 14, color: Colors.green);
  TextStyle get inactiveStyle => GoogleFonts.openSans(fontSize: 14, color: Colors.red);
  TextStyle get selectedStyle => GoogleFonts.openSans(fontSize: 14, color: Colors.blue);
  TextStyle get unselectedStyle => GoogleFonts.openSans(fontSize: 14, color: Colors.grey);
}
