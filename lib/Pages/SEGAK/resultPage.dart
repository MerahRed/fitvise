import 'package:FitVise/main.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';
import 'package:open_filex/open_filex.dart';
import 'package:FitVise/utilities/pdf_gen.dart';

class Resultpage extends StatefulWidget {
  const Resultpage({super.key});

  @override
  State<Resultpage> createState() => _resultPageState();
}

class _resultPageState extends State<Resultpage> {
  String overall = "Well Done";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1.5),
                      ),
                      child: Column(
                        children: [
                          Image.asset("lib/assets/bear.gif", scale: 2.5),
                          const SizedBox(height: 18),
                          const Text(
                            "Congratulations!",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const Divider(
                            height: 32,
                            thickness: 2,
                            color: Colors.green,
                            indent: 30,
                            endIndent: 30,
                          ),
                          Text(
                            "You have completed the SEGAK test.\n\nYour results have been recorded and you can view your detailed result sheet by clicking the button below.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              letterSpacing: 1.1,
                            ),
                          ),
                          SizedBox(height: 30),
                          GestureDetector(
                            onTap: () async {
                              // ensure everything converted to String
                              final file =
                                  await PdfGenerator.generateResultSheetPdf(
                                currentUsername: currentUsername,
                                currentheight: '$currentheight',
                                currentweight: '$currentweight',
                                userStatus: user_status,
                                overall: overall,
                                segak: segak,
                                filename:
                                    'result_sheet_$currentUsername.pdf', // optional
                              );

                              // show a quick snackbar and open with default viewer
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('PDF saved: ${file.path}')),
                              );

                              await OpenFilex.open(file.path);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade400,
                                    Colors.blue.shade700
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14.0, horizontal: 32),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.open_in_new_rounded,
                                        color: Colors.white, size: 28),
                                    SizedBox(width: 12),
                                    Text(
                                      "View Result Sheet",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        segak["Push up"] = 0;
                        segak["Sit up"] = 0;
                        segak["Step test"] = 0;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MainApp()),
                          (_) => false,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade400,
                              Colors.green.shade700
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.check_circle,
                                  color: Colors.white, size: 28),
                              SizedBox(width: 12),
                              Text(
                                "Complete",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
