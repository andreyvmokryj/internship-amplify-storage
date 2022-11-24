import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:radency_internship_project_2/blocs/image_picker/impostor_bill_data.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';

part 'image_picker_event.dart';

part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc({required this.transactionsRepository}) : super(ImagePickerInitial(null));

  final TransactionsRepository transactionsRepository;

  Future<ImagePickerState> getImageFromGallery() async {
    final picker = ImagePicker();
    final image = await picker.getImage(source: ImageSource.gallery);

    if (image != null) {
      print("ImagePickerBloc.getImageFromCamera: photo processed");
      impostorTransactions.forEach((element) {
        transactionsRepository.add(element);
      });
      return LoadedImage(File(image.path));
    } else {
      return LoadedImage(null);
    }
  }

  Future<ImagePickerState> getImageFromCamera() async {
    final picker = ImagePicker();
    final image = await picker.getImage(source: ImageSource.camera);

    if (image != null) {
      return LoadedImage(File(image.path));
    } else {
      return LoadedImage(null);
    }
  }

  @override
  Stream<ImagePickerState> mapEventToState(
    ImagePickerEvent event,
  ) async* {
    if (event is ImageFromGallery) {
      yield await getImageFromGallery();
    } else if (event is ImageFromCamera) {
      yield await getImageFromCamera();
    }
  }
}
