import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/widgets/custom_app_bar.dart';
import 'logic.dart';

class HomePage extends GetView<HomeLogic> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBack: false,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: _buildBannerList(),
      ),
      SliverFixedExtentList(
        itemExtent: 120, //列表项高度固定
        delegate: SliverChildBuilderDelegate(
              (_, index) => _buildItem(),
          childCount: 10,
        ),
      )
    ]);
  }

  //轮播图
  Widget _buildBannerList() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: controller.imageList.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(item, height: 200, fit: BoxFit.cover),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '淘特 Flutter 流畅度优化实践',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            '阿里巴巴移动技术 ｜ 12.27',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
          const SizedBox(height: 5),
          const Text(
            '流畅度是用户体验的关键一环，大家都不希望手机用起来像看电影/刷PPT，尤其是现在高刷屏(90/120hz)的普及，更是极大强化了用户对流畅度的感知，但流畅度也跟产品复杂度强相关，也是一次繁与简的取舍',
            maxLines: 2,
            style: TextStyle(fontSize: 12, color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
