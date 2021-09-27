import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tournament_cards_website/AppConstants.dart';
import 'package:tournament_cards_website/domain/logic/GeneratorBLoC.dart';
import 'package:tournament_cards_website/domain/logic/WizardBLoC.dart';
import 'package:tournament_cards_website/domain/model/AppError.dart';
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';
import 'package:tournament_cards_website/domain/model/StepNavigationResponse.dart';
import 'package:tournament_cards_website/domain/model/TournamentType.dart';
import 'package:tournament_cards_website/ui/WebsiteAppBar.dart';
import 'package:tournament_cards_website/ui/wizard/ExportStep.dart';
import 'package:tournament_cards_website/ui/wizard/PlayersStep.dart';
import 'package:tournament_cards_website/ui/wizard/SingleDoubleStep.dart';
import 'package:tournament_cards_website/ui/wizard/TablesStep.dart';
import 'package:tournament_cards_website/ui/wizard/WizardStepper.dart';
import 'package:url_launcher/url_launcher.dart';

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

  PDFGeneration pdfGeneration = PDFGeneration(
    type: TournamentType.DOUBLE,
    numberOfPlayers: 40,
    numberOfRounds: 12,
    drawOption: 0,
    numberOfTables: 12,
    distributeOption: 0,
    languageCode: "de",
  );

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
              child: StreamBuilder<StepNavigationResponse>(
                  stream: _wizardBLoC.wizardStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      pdfGeneration = snapshot.data!.pdfGeneration;
                    }
                    return WizardStepper(
                      currentStep: snapshot.hasData ? snapshot.data!.currentStep : 0,
                      steps: [
                        SingleDoubleStep().build(context, 0, snapshot.hasData ? snapshot.data!.currentStep : 0, pdfGeneration),
                        PlayersStep().build(context, 1, snapshot.hasData ? snapshot.data!.currentStep : 0),
                        TablesStep().build(context, 2, snapshot.hasData ? snapshot.data!.currentStep : 0),
                        ExportStep().build(context, 3, snapshot.hasData ? snapshot.data!.currentStep : 0),
                      ],
                      wizardBLoC: _wizardBLoC,
                      generatorBLoC: _generatorBLoC,
                      pdfModel: pdfGeneration,
                    );
                  })),
          SizedBox(
            width: double.infinity,
            // height: double.infinity,
            child: Container(
              color: AppConstants.greyColor,
              height: 75,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Made with ♥️ by ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Marcel Kaufmann',
                        style: TextStyle(color: AppConstants.mainColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(AppConstants.mailtoURI.toString());
                          },
                      ),
                    ],
                  ),
                ),
              ),
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
