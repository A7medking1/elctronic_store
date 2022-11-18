import 'package:equatable/equatable.dart';

class BannerModel extends Equatable{
  final int id;

  final String image;

  const BannerModel({
    required this.image,
    required this.id,
  });

  @override
  List<Object> get props => [image, id];
}

List<BannerModel> banners = [
  const BannerModel(
    image:
        "https://student.valuxapps.com/storage/uploads/banners/1626544896muQ0Q.best-deal-promotional-ribbon-style-green-banner-design_1017-27469.jpg",
    id: 1,
  ),
  const BannerModel(
    image:
        "https://student.valuxapps.com/storage/uploads/banners/1626545208UfigP.golden-coin-money-cashback-promotion-ecommerce-poster-banner-template-blue-background-216757528.jpg",
    id: 2,
  ),
  const BannerModel(
    image:
        "https://student.valuxapps.com/storage/uploads/banners/1641000163w2k1O.انطلاق-عروض-الجمعة-السوداء-Black-Friday-على-متجر-TomTop.jpg",
    id: 3,
  ),
  const BannerModel(
    image:
        "https://th.bing.com/th/id/R.2a4d3331413597cd447f6413175e81ae?rik=%2fMo5qYYGyVbhYw&pid=ImgRaw&r=0",
    id: 4,
  ),
  const BannerModel(
    image:
        "https://mir-s3-cdn-cf.behance.net/project_modules/disp/87656e21454081.56301801dda1b.jpg",
    id: 5,
  ),
  const BannerModel(
    image:
        "https://mir-s3-cdn-cf.behance.net/project_modules/disp/90203a21454081.56301801d86d1.jpg",
    id: 6,
  ),
];
