import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:url_launcher/url_launcher.dart';

TeXViewWidget introduction =
    _teXViewWidget(r"""<h4>Flutter \( \rm\\TeX \)</h4>""", r""" 
       
      <p>Flutter \( \rm\\TeX \) is a Flutter Package to render so many types of equations based on \( \rm\\LaTeX \), It also includes full HTML with JavaScript
      support.</p>
      """);

TeXViewWidget quadraticEquation =
    _teXViewWidget(r"<h4>Quadratic Equation</h4>", r"""
     When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
     $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>""");

TeXViewWidget matrix = _teXViewWidget("Matrix", r"""<p>
     $$ \begin{bmatrix}
         a & b \\
         c & d
      \end{bmatrix}$$</p>""");

TeXViewWidget align = _teXViewWidget("Align", r"""
    <p>
    $$ 
     \begin{align}
      a&=b+c \\
      d+e&=f
    \end{align}
    $$
    </p>""");

TeXViewWidget alignedTag = _teXViewWidget(r"<h4>Table</h4>", r"""    
           $$
           \begin{array}{|c|c|}
              \hline
              \text{RA} & \text{SQL}  \\
              \hline \hline
              \sigma_{A_{.name} = B_{.name}}(A x B) 
              & 
              \text{select} * \text{from A INNER JOIN B ON A.name = B.name} \\
              \hline 
           \end{array}
           $$""");

TeXViewWidget image() {
  return TeXViewContainer(
    child: TeXViewImage.network(
        'https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png'),
    style: TeXViewStyle(
      textAlign: TeXViewTextAlign.Center,
      height: 300,
      margin: TeXViewMargin.all(10),
      borderRadius: TeXViewBorderRadius.all(20),
    ),
  );
}

TeXViewWidget video() {
  return TeXViewContainer(
    child: TeXViewVideo.youtube(
        "https://www.youtube.com/watch?v=YiNbVEXV_NM&lc=Ugyg4ljzrK0D6YfrO854AaABAg"),
    style: TeXViewStyle(
      textAlign: TeXViewTextAlign.Center,
      width: 300,
    ),
  );
}

TeXViewStyle _teXViewStyle = TeXViewStyle(
  textAlign: TeXViewTextAlign.Center,
  margin: TeXViewMargin.all(10),
  padding: TeXViewPadding.all(10),
  borderRadius: TeXViewBorderRadius.all(10),
  border: TeXViewBorder.all(
    TeXViewBorderDecoration(
        borderColor: Colors.blue,
        borderStyle: TeXViewBorderStyle.Solid,
        borderWidth: 2),
  ),
);

TeXViewWidget onTap() {
  return TeXViewInkWell(
      child: TeXViewDocument(r""" Button (More Information) """),
      style: _teXViewStyle,
      id: "inkwell_1",
      rippleEffect: true,
      onTap: (id) async {
        print(id);

        //Using url_launcher: ^6.0.8 (Flutter Package)
        const url = "https://katex.org/docs/support_table.html#i";
        if (await canLaunch(url))
          await launch(url);
        else
          throw "Could not launch $url";
      });
}

TeXViewWidget _teXViewWidget(String title, String body) {
  return TeXViewColumn(children: [
    TeXViewDocument(title,
        style: TeXViewStyle(
            contentColor: Colors.blue,
            textAlign: TeXViewTextAlign.Center,
            fontStyle: TeXViewFontStyle(fontSize: 20))),
    TeXViewDocument(body,
        style: TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
  ]);
}

class TeXViewDocumentExamples extends StatelessWidget {
  final TeXViewRenderingEngine renderingEngine;

  TeXViewDocumentExamples(
      {this.renderingEngine = const TeXViewRenderingEngine.katex()});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TeXView(
        //height: double.infinity,
        renderingEngine: renderingEngine,
        child: TeXViewColumn(children: [
          image(),
          video(),
          onTap(),
          introduction,
          quadraticEquation,
          alignedTag,
          matrix,
          align,
        ]),
      ),
    );
  }
}
