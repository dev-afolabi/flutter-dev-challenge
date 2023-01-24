import 'package:dev_challenge/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 70,
          color: Color(0xff123CAA),
          margin: EdgeInsets.only(top: 60, bottom: 25),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'My Account',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Text('Afolabi test',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                  Text('wallet ID:',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ],
              ),
              Image.asset(
                'assets/icons/material-symbols_share-outline.png',
                width: 50,
                height: 50,
                color: Colors.red,
              )
            ],
          ),
        ),
        Column(
          children: [
            Container(
              height: 50,
              width: 365,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey, width: 0.4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/iconoir_profile-circled.png',
                    width: 25,
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Text(
                      'Profile settings',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: 365,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey, width: 0.4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/mdi_bell-notification-outline.png',
                    width: 25,
                    height: 25,
                    color: Color(0xff123CAA),
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Text(
                      'Notification Settings',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 40,
              width: 365,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey, width: 0.4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/lucide_key.png',
                    width: 25,
                    height: 25,
                    color: Color(0xff123CAA),
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Text(
                      '2FA: Update Security Question',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: 365,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey, width: 0.4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/carbon_security.png',
                    width: 25,
                    height: 25,
                    color: Color(0xff123CAA),
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Text(
                      'Password Settings',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: 365,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey, width: 0.4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/ph_credit-card.png',
                    width: 25,
                    height: 25,
                    color: Color(0xff123CAA),
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Text(
                      'Account Settings',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: 365,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey, width: 0.4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/bx_support.png',
                    width: 25,
                    height: 25,
                    color: Color(0xff123CAA),
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Text(
                      'Contact Us',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: 365,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey, width: 0.4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/material-symbols_share-outline.png',
                    width: 25,
                    height: 25,
                    color: Color(0xff123CAA),
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Text(
                      'Refer and Earn',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: 365,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey, width: 0.4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/ic_outline-logout.png',
                    width: 25,
                    height: 25,
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(7),
                      child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ),
                    onTap: () =>
                        Provider.of<Auth>(context, listen: false).logout(),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
