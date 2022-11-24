part of 'image_picker_bloc.dart';

abstract class ImagePickerState {
  ImagePickerState(this.image);

  File? image;
  
}

class ImagePickerInitial extends ImagePickerState {
  ImagePickerInitial(this.image):super(null);

  File? image;
}

class LoadedImage extends ImagePickerState {
  LoadedImage(this.image):super(image);

  File? image;
}
