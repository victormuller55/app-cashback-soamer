import 'dart:async';
import 'dart:io';

import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String remotePDFpath = "";

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() {
   try {
     print("aqui antes 1");
     createFileOfPdfUrl().then((f) {
       setState(() {
         remotePDFpath = f.path;
       });
     });
   } catch(e) {
     showSnackbarError(context);
   }
  }

  Future<File> createFileOfPdfUrl() async {
    print("aqui antes 2");

    var status = await Permission.storage.status;
    print("aqui antes 3");

    if (!status.isGranted) {
      print("aqui antes 4");
      status = await Permission.storage.request();
    }
    print("aqui antes 5");
    print(status.isGranted);

    if (status.isGranted) {
      print("aqui antes 6");
      Completer<File> completer = Completer();
      print("aqui antes 7");
      try {
        print("aqui 1");
        final url = Endpoint.endpointLoadPDF;
        print("aqui 2");
        final filename = url.substring(url.lastIndexOf("/") + 1);
        print("aqui 3");
        var request = await HttpClient().getUrl(Uri.parse(url));
        print("aqui 4");
        var response = await request.close();
        print("aqui 5");
        var bytes = await consolidateHttpClientResponseBytes(response);
        print("aqui 6");
        var dir = await getApplicationDocumentsDirectory();
        print("aqui 7");
        File file = File("${dir.path}/$filename");
        print("aqui 8");
        await file.writeAsBytes(bytes, flush: true);
        print("aqui 9");
        completer.complete(file);
        print("aqui 10");
        return completer.future;
      } catch (e) {
        showSnackbarError(context, message: "Erro na requisicao");
        throw Exception('Error parsing asset file!');
      }
    } else {
      showSnackbarError(context, message: "Sem acesso ao diretorio");
      return File("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF View',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[
                TextButton(
                  child: const Text("Remote PDF"),
                  onPressed: () {
                    if (remotePDFpath.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(path: remotePDFpath),
                        ),
                      );
                    } else {
                      showSnackbarError(context, message: "VAZIO");
                    }
                  },
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("Go to ${pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
