import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tournament_cards_website/domain/logic/GeneratorBLoC.dart';
import 'package:tournament_cards_website/domain/logic/WizardBLoC.dart';
import 'package:tournament_cards_website/domain/model/AppError.dart';
import 'package:tournament_cards_website/domain/model/PDFGenerationRequest.dart';
import 'package:tournament_cards_website/domain/model/TournamentType.dart';
import 'package:tournament_cards_website/ui/WebsiteAppBar.dart';
import 'package:tournament_cards_website/ui/wizard/ExportStep.dart';
import 'package:tournament_cards_website/ui/wizard/PlayersStep.dart';
import 'package:tournament_cards_website/ui/wizard/SingleDoubleStep.dart';
import 'package:tournament_cards_website/ui/wizard/TablesStep.dart';
import 'package:tournament_cards_website/ui/wizard/WizardStepper.dart';

import 'Spinner.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GeneratorBLoC _generatorBLoC;
  late WizardBLoC _wizardBLoC;
  late Size _deviceSize;

  @override
  void initState() {
    super.initState();

    _wizardBLoC = WizardBLoC();
    _generatorBLoC = GeneratorBLoC();
    _generatorBLoC.loadingStream.listen((event) {
      if (event) {
        Spinner.showProgress(context);
      } else {
        Spinner.hideProgress(context);
      }
    });
    _generatorBLoC.errorMessageStream.listen((event) {
      String msg = "";
      switch (event) {
        case AppError.WASM_ERROR:
          // TODO: Handle this case.
          break;
        case AppError.CALL_DOWNLOAD_ERROR:
          // TODO: Handle this case.
          break;
        case AppError.PDF_GEN_TIMEOUT:
          // TODO: Handle this case.
          break;
      }
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        webBgColor: '#000000',
        timeInSecForIosWeb: 3,
        webPosition: 'center',
      );
    });
    _generatorBLoC.pdfStream.listen((pdf) {
      _generatorBLoC.startDownloadSink.add(pdf);
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: WebsiteAppBar(_deviceSize),
        backgroundColor: Colors.white,
        body: Container(
            child: Column(children: [
          Expanded(
              child: StreamBuilder<int>(
                  stream: _wizardBLoC.wizardStream,
                  builder: (context, snapshot) {
                    return WizardStepper(
                      currentStep: snapshot.data == null ? 0 : snapshot.data!,
                      steps: [
                        SingleDoubleStep().build(context, 0, snapshot.data == null ? 0 : snapshot.data!),
                        PlayersStep().build(context, 1, snapshot.data == null ? 0 : snapshot.data!),
                        TablesStep().build(context, 2, snapshot.data == null ? 0 : snapshot.data!),
                        ExportStep().build(context, 3, snapshot.data == null ? 0 : snapshot.data!),
                      ],
                      wizardBLoC: _wizardBLoC,
                    );
                  })),
          Center(
            child: OutlinedButton(
              onPressed: () {
                _generatorBLoC.generatePDFSink.add(PDFGenerationRequest(
                    type: TournamentType.DOUBLE, numberOfPlayers: 40, numberOfRounds: 12, drawOption: 0, numberOfTables: 10, distributeOption: 0, languageCode: "de"));
              },
              child: Text("KLICK MICH"),
            ),
          ),
        ])));
  }

  @override
  void dispose() {
    super.dispose();
    _generatorBLoC.dispose();
    _wizardBLoC.dispose();
  }
}
