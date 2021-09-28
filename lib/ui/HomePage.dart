import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tournament_cards_website/App.dart';
import 'package:tournament_cards_website/AppConstants.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:tournament_cards_website/domain/logic/GeneratorBLoC.dart';
import 'package:tournament_cards_website/domain/logic/WizardBLoC.dart';
import 'package:tournament_cards_website/domain/model/AppError.dart';
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';
import 'package:tournament_cards_website/domain/model/StepNavigationResponse.dart';
import 'package:tournament_cards_website/domain/model/TournamentType.dart';
import 'package:tournament_cards_website/ui/WebsiteAppBar.dart';
import 'package:tournament_cards_website/ui/herosection/HeroSectionWidget.dart';
import 'package:tournament_cards_website/ui/wizard/WizardStepper.dart';
import 'package:tournament_cards_website/ui/wizard/export/ExportStep.dart';
import 'package:tournament_cards_website/ui/wizard/players/PlayersStep.dart';
import 'package:tournament_cards_website/ui/wizard/rounds/RoundsStep.dart';
import 'package:tournament_cards_website/ui/wizard/singledouble/SingleDoubleStep.dart';
import 'package:tournament_cards_website/ui/wizard/tables/TablesStep.dart';
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

  final _numberOfPlayersController = TextEditingController();
  final _numberOfRoundsController = TextEditingController();
  final _numberOfTablesController = TextEditingController();

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
          msg = AppLocalizations.of(context).errorWasm;
          break;
        case AppError.CALL_DOWNLOAD_ERROR:
          msg = AppLocalizations.of(context).errorDownload;
          break;
        case AppError.PDF_GEN_TIMEOUT:
          msg = AppLocalizations.of(context).errorTimeout;
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
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: HeroSectionWidget(_deviceSize),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 800, minWidth: 300),
                    child: StreamBuilder<StepNavigationResponse>(
                        stream: _wizardBLoC.wizardStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            pdfGeneration = snapshot.data!.pdfGeneration;
                          }
                          if (_numberOfPlayersController.text == '') {
                            _numberOfPlayersController.text = '40';
                          }
                          pdfGeneration.numberOfPlayers = int.parse(_numberOfPlayersController.text);

                          if (_numberOfRoundsController.text == '') {
                            _numberOfRoundsController.text = '12';
                          }
                          pdfGeneration.numberOfRounds = int.parse(_numberOfRoundsController.text);

                          if (_numberOfTablesController.text == '') {
                            _numberOfTablesController.text = '10';
                          }
                          pdfGeneration.numberOfTables = int.parse(_numberOfTablesController.text);
                          pdfGeneration.languageCode = App.of(context)!.getLocale()!.languageCode;
                          return WizardStepper(
                            currentStep: snapshot.hasData ? snapshot.data!.currentStep : 0,
                            steps: [
                              SingleDoubleStep().build(context, 0, snapshot.hasData ? snapshot.data!.currentStep : 0, pdfGeneration),
                              PlayersStep().build(context, 1, snapshot.hasData ? snapshot.data!.currentStep : 0, pdfGeneration, _numberOfPlayersController),
                              RoundsStep().build(context, 2, snapshot.hasData ? snapshot.data!.currentStep : 0, pdfGeneration, _numberOfRoundsController),
                              TablesStep().build(context, 3, snapshot.hasData ? snapshot.data!.currentStep : 0, pdfGeneration, _numberOfTablesController),
                              ExportStep().build(context, 4, snapshot.hasData ? snapshot.data!.currentStep : 0),
                            ],
                            wizardBLoC: _wizardBLoC,
                            generatorBLoC: _generatorBLoC,
                            pdfModel: pdfGeneration,
                          );
                        }),
                  ),
                ],
              ),
            )),
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _generatorBLoC.dispose();
    _wizardBLoC.dispose();
    _numberOfPlayersController.dispose();
    _numberOfRoundsController.dispose();
    _numberOfTablesController.dispose();
    super.dispose();
  }
}
