import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:instagram_clone_flutter/screen/addpost_text.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final List<File> _images = [];  // Lista de imágenes
  File? _selectedImage;  // Imagen seleccionada
  int currentPage = 0;  // Variable para controlar la página de imágenes

  // Este método se encarga de cargar las imágenes
  _fetchNewMedia() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> album = await PhotoManager.getAssetPathList(type: RequestType.image);
      List<AssetEntity> media = await album[0].getAssetListPaged(page: currentPage, size: 60);

      for (var asset in media) {
        if (asset.type == AssetType.image) {
          final file = await asset.file;
          if (file != null) {
            _images.add(file);  // Añadimos las imágenes a la lista
          }
        }
      }

      if (mounted) {
        setState(() {
          currentPage++;  // Incrementamos la página para cargar más imágenes
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: No permission to access storage'), backgroundColor: Colors.redAccent),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();  // Llamamos a la función para cargar las imágenes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_selectedImage != null) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddPostTextScreen(_selectedImage!),
                ));
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Next',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          child: CustomScrollView(
            slivers: [
              // SliverPersistentHeader para la imagen seleccionada, con fondo detrás
              if (_selectedImage != null)
                SliverPersistentHeader(
                  delegate: _SelectedImageHeaderDelegate(image: _selectedImage!),
                  pinned: true,  // La imagen se mantiene fija
                ),

              // Cuadrícula de imágenes
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImage = _images[index]; // Actualizamos la imagen seleccionada
                        });
                      },
                      child: Image.file(
                        _images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    );
                  },
                  childCount: _images.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Clase para crear el SliverPersistentHeader con la imagen seleccionada
class _SelectedImageHeaderDelegate extends SliverPersistentHeaderDelegate {
  final File image;

  _SelectedImageHeaderDelegate({required this.image});

  @override
  double get maxExtent => 250.0;  // Altura máxima de la imagen
  @override
  double get minExtent => 250.0;  // Altura mínima de la imagen (la misma para que no cambie el tamaño)

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,  // Fondo detrás de la imagen
      height: maxExtent,
      padding: const EdgeInsets.all(8.0),
      child: Image.file(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // Aquí debe ser siempre 'true' para que la imagen se actualice cada vez que se cambie
    return true;
  }
}
