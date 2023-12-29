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
\ProvidesClass{common/manuscript}[2023/12/27 v1.0 Manuscript LaTeX document class]

% Options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Preliminary declarations
\RequirePackage[a4paper]{geometry}
\RequirePackage[indent]{parskip}
\RequirePackage{etoolbox}
\RequirePackage{ifdraft}

% Colors
\RequirePackage[dvipsnames]{xcolor}
\definecolor{Basil}{HTML}{32612D}
\definecolor{Berry}{HTML}{7A1712}

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
\fxsetup{marginface=\normalfont\scriptsize\sffamily\color{gray}}

% Add line numbers in draft mode
\RequirePackage[mathlines]{lineno}
\ifdraft{\linenumbers}{}
\renewcommand{\linenumberfont}{\normalfont\scriptsize\sffamily\color{gray}}
\setlength{\linenumbersep}{\marginparsep}

% Culturally-determined typographical rules
% N.B.: `csquotes' must be loaded after `lineno'
\RequirePackage[american]{babel}
\RequirePackage{csquotes}
\input{ushyphex.tex}

% Formats for dates and times
\RequirePackage[useregional,showzone=false]{datetime2}

% Space between lines
\RequirePackage[nodisplayskipstretch]{setspace}
\singlespacing

% Modify the typesets of the `\maketitle' and `\thanks' commands
\RequirePackage{titling}
\pretitle{\begin{center}\Large}
\posttitle{\par\end{center}\vskip 1em}
\preauthor{\begin{center}\large \lineskip 0.5em\begin{tabular}[t]{c}}
\postauthor{\end{tabular}\par\end{center}\vskip 1em}
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
    \fancyhead[C]{\small\textsc{\ifnumodd{\value{page}}{\@headtitle}{\@headauthor}}}
}
\pagestyle{main}

% List environments
\RequirePackage{enumitem}
\setlist[itemize]{noitemsep}
\setlist[enumerate]{noitemsep}

% SI units
\RequirePackage{siunitx}

% Captions
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup*[figure]{
    position=below,
    labelfont=sc,
    font+=smaller,
}
\captionsetup*[subfigure]{
    labelfont=normalfont,
}
\captionsetup*[table]{
    position=above,
    labelfont=sc,
    font+=smaller,
}
\captionsetup*[subtable]{
    labelfont=normalfont,
}

% Algorithms
\RequirePackage[ruled,lined,longend,linesnumbered]{algorithm2e}
\SetKwInput{KwNote}{Note}
\AtBeginEnvironment{algorithm}{\DontPrintSemicolon}
\renewenvironment{algomathdisplay}{\begin{equation}}{\@endalgocfline\end{equation}\ifthenelse{\boolean{algocf@linesnumbered}}{\vspace{-\baselineskip}}{\relax}\;}
\newenvironment{algomathdisplay*}{\begin{equation*}}{\@endalgocfline\end{equation*}\ifthenelse{\boolean{algocf@linesnumbered}}{\vspace{-\baselineskip}}{\relax}\;}
\newenvironment{algomathalign}[1]{\align #1}{\@endalgocfline\endalign\ifthenelse{\boolean{algocf@linesnumbered}}{\vspace{-\baselineskip}}{\relax}\;}

% Plots
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{pgfplotstable}
\pgfplotsset{
    compat=1.18,
    every axis/.append style={very thick},
}

% Bibliography
\RequirePackage[
    style=ext-numeric-comp,
    articlein=false,
    innamebeforetitle=true,
    sorting=nyt,
    sortcase=false,
    sortcites,
    maxbibnames=99,
    date=year,
    urldate=long,
]{biblatex}
\DeclareNameAlias{author}{family-given}
\renewbibmacro*{edition}{\iffieldundef{edition}{}{\printfield{edition} edition}}
\renewcommand*{\bibfont}{\small}
\setlength{\bibitemsep}{\parsep}

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

% Font and encoding
\RequirePackage{lmodern}
\RequirePackage[sf,bf,nobottomtitles*,]{titlesec}
\RequirePackage{abstract}
\titleformat{\section}{\normalfont\sffamily\large\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}{\normalfont\sffamily\normalsize\bfseries}{\thesubsection}{1em}{}
\renewcommand\abstractnamefont{\normalfont\sffamily\small\bfseries}

% Subliminal refinements
\RequirePackage{microtype}
\RequirePackage[prevent-all]{widows-and-orphans}
% prevent footnotes from splitting across pages
\interfootnotelinepenalty=10000
% prevent line breaks in inline formulas
\binoppenalty=10000
\relpenalty=10000
% raise an error if a glyph is missing
\tracinglostchars=3

% Cross-referencing
\RequirePackage[pdfusetitle,hyperfootnotes=false]{hyperref}
\RequirePackage{url}
\hypersetup{
    final,
    colorlinks,
    linkcolor=Berry,
    citecolor=Basil,
    urlcolor=RedViolet,
}
\newcommand*{\email}[1]{\href{mailto:#1}{\texttt{#1}}}
\newcommand*{\orcid}[1]{\href{https://orcid.org/#1}{\texttt{#1}}}

% Automatic references
% N.B.: `cleveref' must be loaded after `hyperref'
\RequirePackage[capitalize,noabbrev]{cleveref}
\newcommand{\crefrangeconjunction}{--}
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
\newcommand{\@headtitle}{}
\renewcommand{\title}[2][]{
    \old@title{#2}
    \renewcommand{\@headtitle}{\ifblank{#1}{#2}{#1}}
}

% Add an optional "short author" argument to the `\author' command
% N.B.: This must be defined after loading `hyperref'
\NewCommandCopy{\old@author}{\author}
\newcommand{\@headauthor}{}
\renewcommand{\author}[2][]{
    \old@author{#2}
    \renewcommand{\@headauthor}{%
        \renewcommand{\thanks}[1]{}%
        \renewcommand{\thanksgap}[1]{}%
        \renewcommand{\thanksmark}[1]{}%
        \renewcommand{\and}{\unskip, }%
        \ifblank{#1}{#2}{#1}%
    }
}

% Headings
\date{\ifdraft{\DTMnow}{\today}}
