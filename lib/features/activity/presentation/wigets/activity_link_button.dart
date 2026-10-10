import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';

/// Presentation-only launcher. No network requests or API parsing.
class ActivityLinkButton extends StatelessWidget {
  final String? link;
  const ActivityLinkButton({super.key, required this.link});

  Uri? get _validUri {
    final value = link?.trim();
    if (value == null || value.isEmpty) return null;
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasAuthority || uri.host.isEmpty ||
        (uri.scheme != 'https' && uri.scheme != 'http')) return null;
    return uri;
  }

  @override
  Widget build(BuildContext context) {
    final uri = _validUri;
    if (uri == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: OutlinedButton.icon(
        onPressed: () async {
          try {
            final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
            if (!launched && context.mounted) _showError(context);
          } catch (_) {
            if (context.mounted) _showError(context);
          }
        },
        icon: const Icon(Icons.open_in_new_rounded, size: 18),
        label: const Text('Open Activity Link'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          backgroundColor: AppColors.mint,
          minimumSize: const Size.fromHeight(48),
          side: const BorderSide(color: AppColors.ink, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Couldn't open that activity link.")),
    );
  }
}
