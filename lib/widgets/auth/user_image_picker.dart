import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:image_picker/image_picker.dart' as p;
import '../../helpers/snack_bars.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    required this.pickImageCallback,
    this.enabled = true,
    this.initialImage,
  });

  final void Function(File pickedImage) pickImageCallback;
  final bool enabled;
  final File? initialImage;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImg;

  @override
  void initState() {
    super.initState();
    _pickedImg = widget.initialImage;
  }

  Future<void> _pickImage({required p.ImageSource source}) async {
    try {
      final imagePicker = p.ImagePicker();
      const imageDim = 250.0;

      final image = await imagePicker.pickImage(
        source: source,
        preferredCameraDevice: p.CameraDevice.front,
        maxWidth: imageDim,
        maxHeight: imageDim,
        imageQuality: 60,
      );

      if (image != null) {
        setState(() => _pickedImg = File(image.path));
        widget.pickImageCallback(_pickedImg!);
      }
    } on PlatformException catch (e) {
      SnackBars.showError(context: context, message: e.message);
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    const imgR = 48.0;
    final sch = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(child: CircleAvatar(
          radius: imgR,
          backgroundColor: sch.primary,
          foregroundImage: _pickedImg == null ? null : FileImage(_pickedImg!),
          child: Icon(Icons.person_rounded, size: imgR * 2, color: sch.surface),
        ),),
        Expanded(child: TextButton.icon(
          icon: const Icon(Icons.camera),
          label: const Text('Take Picture'),
          onPressed: widget.enabled
              ? () => _pickImage(source: p.ImageSource.camera)
              : null,
        )),
        Expanded(child: TextButton.icon(
          icon: const Icon(Icons.photo_library),
          label: const Text('Choose From Gallery'),
          onPressed: widget.enabled
              ? () => _pickImage(source: p.ImageSource.gallery)
              : null,
          ))
      ],
    );
  }
}

/*

Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: imgR,
          backgroundColor: sch.primary,
          foregroundImage: _pickedImg == null ? null : FileImage(_pickedImg!),
          child: Icon(Icons.person_rounded, size: imgR * 2, color: sch.surface),
        ),
        const SizedBox(height: 6.0),
        TextButton.icon(
          icon: const Icon(Icons.camera),
          label: const Text('Take Picture'),
          onPressed: widget.enabled
              ? () => _pickImage(source: p.ImageSource.camera)
              : null,
        ),
        TextButton.icon(
          icon: const Icon(Icons.photo_library),
          label: const Text('Choose From Gallery'),
          onPressed: widget.enabled
              ? () => _pickImage(source: p.ImageSource.gallery)
              : null,
        ),
      ],
    );

 */
