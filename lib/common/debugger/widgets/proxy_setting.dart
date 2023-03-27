import 'package:flutter/material.dart';
import 'package:get_template/common/utils/utils.dart';
import 'package:get_template/network/request.dart';
import 'package:oktoast/oktoast.dart';

/// @fileName: proxy_setting
/// @date: 2023/2/23 15:55
/// @author clover
/// @description: 代理设置

class ProxySetting extends StatefulWidget {
  const ProxySetting({Key? key}) : super(key: key);

  @override
  State<ProxySetting> createState() => _ProxySettingState();
}

class _ProxySettingState extends State<ProxySetting> {
  final TextEditingController ipEdit = TextEditingController();
  final TextEditingController portEdit = TextEditingController();

  @override
  void initState() {
    super.initState();
    final tp = RequestClient().getProxy();
    ipEdit.text = tp.item1 ?? "";
    portEdit.text = "${tp.item2 ?? ''}";
  }

  void saveProxy() async {
    if (!BaseKit.checkIp(ipEdit.text)) {
      showToast("ip地址格式有误！");
      return;
    }
    final port = int.tryParse(portEdit.text);
    if (port == null || port < 0 || port > 65535) {
      showToast("端口格式有误！");
      return;
    }
    await RequestClient().setProxy(ipEdit.text, port);
    showToast("设置成功");
  }

  void clearProxy() async {
    await RequestClient().clearProxy();
    ipEdit.text = "";
    portEdit.text = "";
    showToast("清理成功");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Row(children: [
          Text(
            "代理地址：",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade200, width: 1),
              ),
              child: TextField(
                controller: ipEdit,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ]),
        SizedBox(height: 10),
        Row(children: [
          Text(
            "代理端口：",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade200, width: 1),
              ),
              child: TextField(
                controller: portEdit,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(left: 75),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  saveProxy();
                },
                child: const Text(
                  "保存",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(100, 40),
                ),
              ),
              TextButton(
                onPressed: () {
                  clearProxy();
                },
                child: const Text(
                  "清除",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  minimumSize: const Size(100, 40),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
