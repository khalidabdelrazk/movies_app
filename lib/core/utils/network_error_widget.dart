import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';

class NetworkErrorWidget extends StatefulWidget {
  final String errorMsg;
  final bool large;
  final Future<void> Function()? onTap;

  const NetworkErrorWidget({
    super.key,
    required this.errorMsg,
    this.onTap,
    required this.large,
  });

  @override
  State<NetworkErrorWidget> createState() => _NetworkErrorWidgetState();
}

class _NetworkErrorWidgetState extends State<NetworkErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: widget.large ? 80 : 40,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            "Network Error",
            style: widget.large
                ? AppStyles.lightRegular16
                : AppStyles.lightRegular16.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            widget.errorMsg,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: widget.large
                ? AppStyles.lightRegular16.copyWith(fontSize: 14)
                : AppStyles.lightRegular16.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () async {
              if (widget.onTap != null) {
                await widget.onTap!();
              }
            },
            icon: const Icon(Icons.refresh),
            label: Text(
              "Try Again",
              style: widget.large
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}