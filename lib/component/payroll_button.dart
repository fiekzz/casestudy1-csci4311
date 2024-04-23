import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AurumButtonService {
  Future<void> invoke();
}

class PayrollButtonController extends StateNotifier<AsyncValue<void>> {
  final AurumButtonService aurumButtonService;

  PayrollButtonController({required this.aurumButtonService})
      : super(const AsyncValue.data(null));
}

class PayrollButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final bool isDisabled;
  final String loadingText;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double borderRadius;
  final Color? overlayColor;
  final Color? borderColor;

  const PayrollButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor,
    this.height = 50,
    this.borderRadius = 24,
    this.isDisabled = false,
    this.isLoading = false,
    this.loadingText = 'Loading...',
    this.borderColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool disabled = onPressed == null || isDisabled;

    // return Container(
    //   clipBehavior: Clip.hardEdge,
    //   decoration: BoxDecoration(
    //     color: Theme.of(context).colorScheme.primaryContainer,
    //   ),
    //   child: Container(
    //     height: 55,
    //     decoration: BoxDecoration(
    //       // borderRadius: BorderRadius.circular(28),
    //       boxShadow: [
    //         BoxShadow(
    //           offset: Offset(0, -6),
    //           color: Color(0x50000000),
    //           blurRadius: 10,
    //           spreadRadius: -12
    //         ),
    //       ],
    //     ),
    //     alignment: Alignment.center,
    //     child: child,
    //   ),
    // );

    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: borderColor ?? Colors.transparent),
            ),
          ),
          elevation: WidgetStateProperty.all<double>(0),
          backgroundColor: WidgetStateProperty.all(
            disabled || isLoading
                ? const Color(0xFFCFCFCF)
                : (backgroundColor ??
                    Theme.of(context).colorScheme.primaryContainer),
          ),
          foregroundColor: WidgetStateProperty.all(
            disabled || isLoading
                ? const Color(0xFF9A9A9A)
                : (foregroundColor ??
                    Theme.of(context).colorScheme.onPrimaryContainer),
          ),
          overlayColor: WidgetStateProperty.all(overlayColor),
        ),
        onPressed: (disabled || isLoading) ? null : onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    loadingText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            : child,
      ),
    );
  }
}
