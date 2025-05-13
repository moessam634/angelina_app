import "package:flutter/material.dart";
class ProfilePhotoBottomSheet extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onDeleteTap;

  const ProfilePhotoBottomSheet({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Profile photo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDeleteTap,
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PhotoOption(
                icon: Icons.camera_alt,
                label: 'camera',
                onTap: onCameraTap,
                filled: true,
              ),
              const SizedBox(width: 32),
              _PhotoOption(
                icon: Icons.photo,
                label: 'Gallery',
                onTap: onGalleryTap,
                filled: false,
              ),
            ],
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              side: const BorderSide(color: Color(0xFF3E5F5B)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF3E5F5B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;

  const _PhotoOption({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled ? const Color(0xFF3E5F5B) : Colors.transparent,
              border: filled ? null : Border.all(color: const Color(0xFF3E5F5B)),
            ),
            child: Icon(
              icon,
              color: filled ? Colors.white : const Color(0xFF3E5F5B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF3E5F5B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
