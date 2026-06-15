import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<PackageInfo> _getPackageInfo() => PackageInfo.fromPlatform();

  Future<Map<String, String>> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return {
        'model': '${info.brand} ${info.model}',
        'os': 'Android',
        'osVersion': 'Android ${info.version.release} (SDK ${info.version.sdkInt})',
      };
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return {
        'model': info.utsname.machine,
        'os': 'iOS',
        'osVersion': '${info.systemName} ${info.systemVersion}',
      };
    }

    return {
      'model': LocaleKeys.unknow.tr(),
      'os': LocaleKeys.unknow.tr(),
      'osVersion': LocaleKeys.unknow.tr(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.about.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/arts/logo_with_background.png',
                width: 120,
                height: 120,
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                LocaleKeys.recipe_book.tr(),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 24),
            _SectionTitle(LocaleKeys.about_app_info.tr()),
            FutureBuilder<PackageInfo>(
              future: _getPackageInfo(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final info = snapshot.data!;
                return Card(
                  child: Column(
                    children: [
                      _InfoTile(
                        icon: Icons.tag,
                        label: LocaleKeys.about_version.tr(),
                        value: info.version,
                      ),
                      Divider(height: 1),
                      _InfoTile(
                        icon: Icons.build_outlined,
                        label: LocaleKeys.about_build.tr(),
                        value: info.buildNumber,
                      ),
                      Divider(height: 1),
                      _InfoTile(
                        icon: Icons.inventory_2_outlined,
                        label: LocaleKeys.about_package.tr(),
                        value: info.packageName,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            _SectionTitle(LocaleKeys.about_device_info.tr()),
            FutureBuilder<Map<String, String>>(
              future: _getDeviceInfo(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final info = snapshot.data!;
                return Card(
                  child: Column(
                    children: [
                      _InfoTile(
                        icon: Icons.phone_android,
                        label: LocaleKeys.about_device_model.tr(),
                        value: info['model']!,
                      ),
                      Divider(height: 1),
                      _InfoTile(
                        icon: Icons.memory,
                        label: LocaleKeys.about_device_os.tr(),
                        value: info['os']!,
                      ),
                      Divider(height: 1),
                      _InfoTile(
                        icon: Icons.system_update,
                        label: LocaleKeys.about_device_os_version.tr(),
                        value: info['osVersion']!,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: Icon(Icons.description_outlined),
                label: Text(LocaleKeys.about_licenses.tr()),
                onPressed: () => showLicensePage(
                  context: context,
                  applicationName: LocaleKeys.recipe_book.tr(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ColorSet.textSecondary,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
