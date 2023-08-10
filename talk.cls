%% talk.cls
%% Copyright 2023 Tom M. Ragonneau
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Tom M. Ragonneau.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{common/talk}[2023/08/07 v1.0 Talk LaTeX document class]

% Options% Options
\DeclareOption{optimization}{\PassOptionsToPackage{optimization}{common/maths}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass[10pt,xcolor=dvipsnames]{beamer}

% Preliminary declarations
\RequirePackage{ifdraft}

% Set theme and templates
\RequirePackage{appendixnumberbeamer}
\usetheme{metropolis}
\metroset{
    titleformat=smallcaps,
    numbering=fraction,
    progressbar=frametitle,
    block=fill,
}
\setbeamertemplate{section in toc}[sections numbered]
\usefonttheme{professionalfonts}
\setbeamerfont{standout}{size=\normalsize}
\setbeamersize{
    text margin left=0.75\beamer@leftmargin,
    text margin right=0.75\beamer@rightmargin,
}

% Change theme colors
\definecolor{VeniceBlue}{HTML}{2F5675}
\definecolor{DarkCaramel}{HTML}{B27A03}
\definecolor{FernGreen}{HTML}{4F7942}
\setbeamercolor{normal text}{fg=VeniceBlue!70!black,bg=black!2}
\setbeamercolor{alerted text}{fg=DarkCaramel}
\setbeamercolor{example text}{fg=FernGreen!95!black}

% Patch `Overfull \vbox (... too high)' in title page
\def\titlepage{\usebeamertemplate{title page}}
\setbeamertemplate{title graphic}{
    \begin{tikzpicture}[overlay,remember picture]
        \node[below left=2em and \beamer@rightmargin of current page.north east] {\inserttitlegraphic};
    \end{tikzpicture}
}

% Customize blocks, alert blocks, and example blocks
\renewcommand{\metropolis@block}[1]{
    \par\vskip\medskipamount%
    \setlength{\parskip}{0pt}
    \ifdefempty{\insertblocktitle}{}{
        \ifbeamercolorempty[bg]{block title#1}{%
            \begin{beamercolorbox}[rightskip=0pt plus 4em]{block title#1}}{%
        \ifbeamercolorempty[bg]{block title}{%
            \begin{beamercolorbox}[rightskip=0pt plus 4em]{block title#1}%
        }{%
            \begin{beamercolorbox}[
                sep=\dimexpr\metropolis@blocksep-\metropolis@blockadjust\relax,
                leftskip=\metropolis@blockadjust,
                rightskip=\dimexpr\metropolis@blockadjust plus 4em\relax,
            ]{block title#1}%
        }}%
            \usebeamerfont*{block title#1}%
            \metropolis@strut%
            \insertblocktitle%
            \metropolis@strut%
        \end{beamercolorbox}%
        \nointerlineskip%
    }%
    \ifbeamercolorempty[bg]{block body#1}{%
        \begin{beamercolorbox}[vmode]{block body#1}}{
    \ifbeamercolorempty[bg]{block body}{%
        \begin{beamercolorbox}[vmode]{block body#1}%
    }{%
        \begin{beamercolorbox}[sep=\metropolis@blocksep, vmode]{block body#1}%
        \vspace{-\metropolis@parskip}
    }}%
        \usebeamerfont{block body#1}%
        \setlength{\parskip}{\metropolis@parskip}%
}


% Font and encoding
\RequirePackage[T1]{fontenc}
\setsansfont{FiraSans}[
    Path=common/fonts/fira-sans/,
    Extension=.otf,
    UprightFont=*-Light,
    BoldFont=*-Regular,
    ItalicFont=*-LightItalic,
    BoldItalicFont=*-Italic,
]
\setmonofont{FiraMono}[
    Path=common/fonts/fira-mono/,
    Extension=.otf,
    UprightFont=*-Regular,
    BoldFont=*-Bold,
]

% Manage culturally-determined typographical rules
\RequirePackage[american]{babel}
\RequirePackage{csquotes}

% Subliminal refinements
\RequirePackage{microtype}

% Bibliography
% N.B.: the counter `cite' is used to count the number of citations.
\RequirePackage{cite}  % nosort
\newcommand{\bibfile}{bib/refs}
\newcounter{cite}
\preto{\cite}{\stepcounter{cite}}{}{}
\bibliographystyle{apalike}
\NewCommandCopy{\old@bibliography}{\bibliography}
\renewcommand{\bibliography}[1]{\ifnum\value{cite}>0\old@bibliography{#1}\fi}

% SI units
\RequirePackage{siunitx}

% Mathematics
\RequirePackage{common/maths}

% Graphics
\RequirePackage{tikz}
\RequirePackage{pgfplots}

% Cancel text
\RequirePackage{cancel}
\NewCommandCopy{\old@cancel}{\cancel}
\renewcommand<>{\cancel}[1]{\alt#2{\old@cancel{#1}\vphantom{#1}}{#1}}

% QR codes
\ifdraft{\PassOptionsToPackage{draft}{qrcode}}{}
\RequirePackage[nolinks]{qrcode}
\qrset{level=Q,version=4}
% Make QR codes clickable (the document is compiled with XeLaTeX)
\setlength{\XeTeXLinkMargin}{1pt}
\let\old@qrcode\qrcode\relax
\def\qrcode#1{\href{#1}{\XeTeXLinkBox{\old@qrcode{#1}}}}
