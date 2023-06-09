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
\AtBeginDocument{\NewCommandCopy{\thedoctitle}{\thetitle}}

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
    \fancyhead[C]{\small\textsc{\ifnumodd{\value{page}}{\thedoctitle}{\theauthor}}}
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
\pgfplotsset{compat=1.18}
\usetikzlibrary{}
\usepgfplotslibrary{}

% Bibliography
% N.B.: the counter `cite' is used to count the number of citations.
\RequirePackage{cite}  % nosort
\newcommand{\bibfile}{bib/refs}
\newcounter{cite}
\preto{\cite}{\stepcounter{cite}}{}{}
\bibliographystyle{plain}
\NewCommandCopy{\oldbibliography}{\bibliography}
\renewcommand{\bibliography}[1]{\ifnum\value{cite}>0\oldbibliography{#1}\fi}

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

% Headings
\date{\ifdraft{\DTMnow}{\today}}
