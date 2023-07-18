%% manuscript.cls
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
\ProvidesClass{common/manuscript}[2023/06/08 v1.0 Manuscript LaTeX document class]

% Options
\DeclareOption{optimization}{\PassOptionsToPackage{optimization}{common/maths}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Preliminary declarations
\RequirePackage[a4paper]{geometry}
\RequirePackage{etoolbox}
\RequirePackage{ifdraft}

% Colors
\RequirePackage[dvipsnames]{xcolor}
\definecolor{Basil}{HTML}{32612D}
\definecolor{Scarlet}{HTML}{900D09}
% Color schemes from https://personal.sron.nl/~pault/
\definecolor{BrightBlue}{HTML}{4477AA}
\definecolor{BrightCyan}{HTML}{66CCEE}
\definecolor{BrightGreen}{HTML}{228833}
\definecolor{BrightYellow}{HTML}{CCBB44}
\definecolor{BrightRed}{HTML}{EE6677}
\definecolor{BrightPurple}{HTML}{AA3377}
\definecolor{BrightGray}{HTML}{BBBBBB}
\definecolor{DarkBlue}{HTML}{222255}
\definecolor{DarkCyan}{HTML}{225555}
\definecolor{DarkGreen}{HTML}{225522}
\definecolor{DarkYellow}{HTML}{666633}
\definecolor{DarkRed}{HTML}{663333}
\definecolor{DarkGray}{HTML}{555555}
\definecolor{HighContrastYellow}{HTML}{DDAA33}
\definecolor{HighContrastRed}{HTML}{BB5566}
\definecolor{HighContrastBlue}{HTML}{004488}
\definecolor{LightBlue}{HTML}{77AADD}
\definecolor{LightCyan}{HTML}{99DDFF}
\definecolor{LightMint}{HTML}{44BB99}
\definecolor{LightPear}{HTML}{BBCC33}
\definecolor{LightOlive}{HTML}{AAAA00}
\definecolor{LightYellow}{HTML}{EEDD88}
\definecolor{LightOrange}{HTML}{EE8866}
\definecolor{LightPink}{HTML}{FFAABB}
\definecolor{LightGray}{HTML}{DDDDDD}
\definecolor{MediumContrastLightYellow}{HTML}{EECC66}
\definecolor{MediumContrastLightRed}{HTML}{FE99AA}
\definecolor{MediumContrastLightBlue}{HTML}{6699CC}
\definecolor{MediumContrastDarkYellow}{HTML}{997700}
\definecolor{MediumContrastDarkRed}{HTML}{994455}
\definecolor{MediumContrastDarkBlue}{HTML}{004488}
\definecolor{MutedIndigo}{HTML}{332288}
\definecolor{MutedCyan}{HTML}{88CCEE}
\definecolor{MutedTeal}{HTML}{44AA99}
\definecolor{MutedGreen}{HTML}{117733}
\definecolor{MutedOlive}{HTML}{999933}
\definecolor{MutedSand}{HTML}{DDCC77}
\definecolor{MutedRose}{HTML}{CC6677}
\definecolor{MutedWine}{HTML}{882255}
\definecolor{MutedPurple}{HTML}{AA4499}
\definecolor{MutedPaleGray}{HTML}{DDDDDD}
\definecolor{PaleBlue}{HTML}{BBCCEE}
\definecolor{PaleCyan}{HTML}{CCEEFF}
\definecolor{PaleGreen}{HTML}{CCDDAA}
\definecolor{PaleYellow}{HTML}{EEEEBB}
\definecolor{PaleRed}{HTML}{FFCCCC}
\definecolor{PaleGray}{HTML}{DDDDDD}
\definecolor{VibrantBlue}{HTML}{0077BB}
\definecolor{VibrantCyan}{HTML}{33BBEE}
\definecolor{VibrantTeal}{HTML}{009988}
\definecolor{VibrantOrange}{HTML}{EE7733}
\definecolor{VibrantRed}{HTML}{CC3311}
\definecolor{VibrantMagenta}{HTML}{EE3377}
\definecolor{VibrantGray}{HTML}{BBBBBB}

% To-do notes in draft mode
% Available commands:
% - \fxnote[options]{<note>}
% - \fxwarning[options]{<note>}
% - \fxerror[options]{<note>}
% - \fxfatal[options]{<note>}
% Available targeted commands:
% - \fxnote*[options]{<note>}{<text>}
% - \fxwarning*[options]{<note>}{<text>}
% - \fxerror*[options]{<note>}{<text>}
% - \fxfatal*[options]{<note>}{<text>}
\RequirePackage[author={}]{fixme}
\fxsetup{marginface=\scriptsize\sffamily\color{gray}}

% Add line numbers in draft mode
\RequirePackage[mathlines]{lineno}
\ifdraft{\linenumbers}{}
\renewcommand{\linenumberfont}{\normalfont\scriptsize\sffamily\color{gray}}
\setlength{\linenumbersep}{\marginparsep}

% Manage culturally-determined typographical rules
% N.B.: `csquotes' must be loaded after `lineno'
\RequirePackage[american]{babel}
\RequirePackage{csquotes}

% Formats for dates and times
\RequirePackage[useregional,showzone=false]{datetime2}

% Font and encoding
\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\RequirePackage[sf,bf,nobottomtitles*,]{titlesec}
\RequirePackage{abstract}
\titleformat{\section}{\normalfont\large\bfseries\sffamily}{\thesection}{1em}{}
\renewcommand\abstractnamefont{\normalfont\small\bfseries\sffamily}

% Space between lines
\RequirePackage{setspace}
\singlespacing

% Subliminal refinements
\RequirePackage{microtype}
\RequirePackage[prevent-all]{widows-and-orphans}

% Prevent footnotes from splitting across pages
\interfootnotelinepenalty=10000

% Prevent line breaks in inline formulas
\binoppenalty=10000
\relpenalty=10000

% Modify the typesets of the `\maketitle' and `\thanks' commands
\RequirePackage{titling}
\setlength{\thanksmargin}{0pt}

% Headers and footers
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancypagestyle{plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[C]{\small\thepage}
}
\fancypagestyle{main}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead[L]{\small\ifnumodd{\value{page}}{}{\thepage}}
    \fancyhead[R]{\small\ifnumodd{\value{page}}{\thepage}{}}
    \fancyhead[C]{\small\textsc{\ifnumodd{\value{page}}{\@headtitle}{\theauthor}}}
}
\pagestyle{main}

% List environments
\RequirePackage{enumitem}

% SI units
\RequirePackage{siunitx}

% Captions
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup*[figure]{position=below}
\captionsetup*[table]{position=above}

% Algorithms
\RequirePackage[ruled,lined,longend,linesnumbered]{algorithm2e}
\SetKwInput{KwNote}{Note}
\AtBeginEnvironment{algorithm}{\DontPrintSemicolon}
\renewenvironment{algomathdisplay}{\begin{equation*}}{\@endalgocfline\end{equation*}\ifthenelse{\boolean{algocf@linesnumbered}}{\vspace{-\baselineskip}}{\relax}\;}

% Plots
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{pgfplotstable}
\usetikzlibrary{}
\usepgfplotslibrary{}
\pgfplotscreateplotcyclelist{bright}{
    BrightBlue,solid\\
    BrightCyan,dashed\\
    BrightGreen,dotted\\
    BrightYellow,dashdotted\\
    BrightRed,densely dashed\\
    BrightPurple,densely dotted\\
    BrightGray,densely dashdotted\\
}
\pgfplotscreateplotcyclelist{dark}{
    DarkBlue,solid\\
    DarkCyan,dashed\\
    DarkGreen,dotted\\
    DarkYellow,dashdotted\\
    DarkRed,densely dashed\\
    DarkGray,densely dotted\\
}
\pgfplotscreateplotcyclelist{highcontrast}{
    black,solid\\
    HighContrastYellow,dashed\\
    HighContrastRed,dotted\\
    HighContrastBlue,dashdotted\\
}
\pgfplotscreateplotcyclelist{light}{
    LightBlue,solid\\
    LightCyan,dashed\\
    LightMint,dotted\\
    LightPear,dashdotted\\
    LightOlive,densely dashed\\
    LightYellow,densely dotted\\
    LightOrange,densely dashdotted\\
    LightPink,loosely dashed\\
    LightGray,loosely dotted\\
}
\pgfplotscreateplotcyclelist{mediumcontrast}{
    black,solid\\
    MediumContrastLightYellow,dashed\\
    MediumContrastLightRed,dotted\\
    MediumContrastLightBlue,dashdotted\\
    MediumContrastDarkYellow,densely dashed\\
    MediumContrastDarkRed,densely dotted\\
    MediumContrastDarkBlue,densely dashdotted\\
}
\pgfplotscreateplotcyclelist{muted}{
    MutedIndigo,solid\\
    MutedCyan,dashed\\
    MutedTeal,dotted\\
    MutedGreen,dashdotted\\
    MutedOlive,densely dashed\\
    MutedSand,densely dotted\\
    MutedRose,densely dashdotted\\
    MutedWine,loosely dashed\\
    MutedPurple,loosely dotted\\
    MutedPaleGray,loosely dashdotted\\
}
\pgfplotscreateplotcyclelist{pale}{
    PaleBlue,solid\\
    PaleCyan,dashed\\
    PaleGreen,dotted\\
    PaleYellow,dashdotted\\
    PaleRed,densely dashed\\
    PaleGray,densely dotted\\
}
\pgfplotscreateplotcyclelist{vibrant}{
    VibrantBlue,solid\\
    VibrantCyan,dashed\\
    VibrantTeal,dotted\\
    VibrantOrange,dashdotted\\
    VibrantRed,densely dashed\\
    VibrantMagenta,densely dotted\\
    VibrantGray,densely dashdotted\\
}
\pgfplotsset{
    compat=1.18,
    cycle list name=bright,
    every axis/.append style={very thick},
}

% Bibliography
% N.B.: the counter `cite' is used to count the number of citations.
\RequirePackage{cite}  % nosort
\newcommand{\bibfile}{bib/refs}
\newcounter{cite}
\preto{\cite}{\stepcounter{cite}}{}{}
\bibliographystyle{plain}
\NewCommandCopy{\old@bibliography}{\bibliography}
\renewcommand{\bibliography}[1]{\ifnum\value{cite}>0\old@bibliography{#1}\fi}

% Keywords-like commands
\newcommand{\keywords}[1]{
    \begingroup
    \def\and{ ; }
    \hypersetup{pdfkeywords={#1}}
    \def\and{\ifhmode\unskip\nobreak\fi\ $\cdot$ }
    \paragraph*{Keywords} #1
    \endgroup
}
\newcommand{\msc}[1]{
    \begingroup
    \def\and{ ; }
    \hypersetup{pdfsubject={#1}}
    \def\and{\ifhmode\unskip\nobreak\fi\ $\cdot$ }
    \paragraph*{Mathematics Subject Classification (2020)} #1
    \endgroup
}

% Mathematics
\RequirePackage{common/maths}

% Cross-referencing
\RequirePackage[pdfusetitle,hyperfootnotes=false]{hyperref}
\RequirePackage{url}
\hypersetup{
    final,
    colorlinks=true,
    linkcolor=Scarlet,
    citecolor=Basil,
    urlcolor=RedViolet,
}
\newcommand*{\email}[1]{\href{mailto:#1}{\texttt{#1}}}
\newcommand*{\orcid}[1]{\href{https://orcid.org/#1}{#1}}

% Automatic references
% N.B.: `cleveref' must be loaded after `hyperref'
\RequirePackage[capitalize,noabbrev]{cleveref}
\crefname{equation}{}{}
\Crefname{equation}{}{}
\crefname{lstlisting}{Listing}{Listings}
\Crefname{lstlisting}{Listing}{Listings}

% Glossaries
% N.B.: `glossaries-extra' must be loaded after `hyperref'
\RequirePackage[acronym]{glossaries-extra}
\setabbreviationstyle[acronym]{long-short}
\glsdisablehyper
\loadglsentries{common/glossary}

% Add an optional "short title" argument to the `\title' command
% N.B.: This must be defined after loading `hyperref'
\NewCommandCopy{\old@title}{\title}
\renewcommand{\title}[2][]{\old@title{#2}\newcommand{\@headtitle}{\ifblank{#1}{#2}{#1}}}

% Headings
\date{\ifdraft{\DTMnow}{\today}}
