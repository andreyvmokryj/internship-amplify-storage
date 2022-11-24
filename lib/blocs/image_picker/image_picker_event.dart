part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent {
}

class ImageFromGallery extends ImagePickerEvent {
  ImageFromGallery();
}

class ImageFromCamera extends ImagePickerEvent{
  ImageFromCamera();
}
