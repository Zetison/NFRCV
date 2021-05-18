% Class for NFR Curriculum vitae template with LaTeX.
%
% by Jon Vegard Venås, JonVegard.Venas@sintef.no
% at SINTEF Digital
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nfrcv}[2020/11/28 A class for NFR CV in LaTeX]

\RequirePackage{ifthen}
% Set default option values
\newboolean{@compact}\setboolean{@compact}{false}
\newboolean{@compactrefs}\setboolean{@compactrefs}{false}
\newboolean{@grayheader}\setboolean{@grayheader}{false}
\newboolean{@printversion}\setboolean{@printversion}{false}
\newboolean{@calibri}\setboolean{@calibri}{false}

% Update option values
\DeclareOption{compact}{\setboolean{@compact}{true}}
\DeclareOption{compactrefs}{\setboolean{@compactrefs}{true}}
\DeclareOption{grayheader}{\setboolean{@grayheader}{true}}
\DeclareOption{printversion}{\setboolean{@printversion}{true}}
\DeclareOption{calibri}{\setboolean{@calibri}{true}}
\ProcessOptions\relax

\def\arrayStretchLen{1}
\def\arraystretch{\arrayStretchLen}

\if@compact
  \newcommand{\nfrbreak}{\\ \hline}
\else
  \newcommand{\nfrbreak}{\\[1.5ex] \hline}
\fi
\newlength{\dateColumnWidth} % Width of "year"-column 
\setlength{\dateColumnWidth}{1.8cm}

\LoadClass[11pt,a4paper]{article} % A4 size with 11-point font is a page format requirement for NFR CVs

% Set font
\if@calibri
\RequirePackage{fontspec} % Needed for Calibri font
\setmainfont[Ligatures=TeX,
  BoldFont={CALIBRIB.TTF}, 
  ItalicFont={CALIBRII.TTF},
  BoldItalicFont={CALIBRIZ.TTF}
  ]{CALIBRI.TTF}       % Calibri or Times New Roman is a page format requirement for NFR CVs
\else
  \usepackage{fontspec}
  \setmainfont{Carlito}
\fi

\newcommand*{\@cvversion}{}
\newcommand*{\cvversion}{\renewcommand*{\@cvversion}}

\newcommand*{\@firstName}{\textcolor{red}{Set with \texttt{\textbackslash firstName\{\}}}}
\newcommand*{\firstName}{\renewcommand*{\@firstName}}

\newcommand*{\@familyName}{\textcolor{red}{Set with \texttt{\textbackslash familyName\{\}}}}
\newcommand*{\familyName}{\renewcommand*{\@familyName}}

\newcommand*{\@dateOfBirth}{\textcolor{red}{Set with \texttt{\textbackslash dateOfBirth\{\}}}}
\newcommand*{\dateOfBirth}{\renewcommand*{\@dateOfBirth}}

\newcommand*{\@sex}{\textcolor{red}{Set with \texttt{\textbackslash sex\{\}}}}
\newcommand*{\sex}{\renewcommand*{\@sex}}

\newcommand*{\@nationality}{\textcolor{red}{Set with \texttt{\textbackslash nationality\{\}}}}
\newcommand*{\nationality}{\renewcommand*{\@nationality}}

\newcommand*{\@orcid}{}
\newcommand*{\orcid}{\renewcommand*{\@orcid}}

\newcommand*{\@researcherID}{}
\newcommand*{\researcherID}{\renewcommand*{\@researcherID}}

\newcommand*{\@urlForPersonalWebsite}{Set with \texttt{\textbackslash urlForPersonalWebsite\{\}}}
\newcommand*{\urlForPersonalWebsite}{\renewcommand*{\@urlForPersonalWebsite}}

\RequirePackage{parskip}
\RequirePackage{tabularx}             % Used for box creation
\RequirePackage[margin=2cm]{geometry} % 2 cm margins is a page format requirement for NFR CVs
\RequirePackage[table]{xcolor}        % needed for cellcolor in tables

% Format hyperlinks
\definecolor{sintef}{RGB}{2,51,102}
\definecolor{nfrgray}{RGB}{242,242,242}
\RequirePackage[%
  hidelinks,
  colorlinks,
  citecolor=sintef,
  linkcolor=sintef,
  urlcolor=sintef,
  ]{hyperref}

% Formatting header and footer
\RequirePackage{fancyhdr,lastpage}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\arraystretch}{1.2}
\lfoot{\footnotesize \if@printversion\@cvversion\fi}
\rfoot{\footnotesize page \thepage/\pageref{LastPage}}

% Create checkbox-commands for "Role in project"
\RequirePackage{tikz}     % for checkbox creation
\RequirePackage{pifont}   % for \ding command
\RequirePackage{amssymb}  % for \square command
\newcommand{\cbox}{$\square$}
\newcommand{\cboxc}{%
  \rlap{$\square$}{\raisebox{2pt}{\large\hspace{1pt}\ding{51}}}}
\newcommand{\dottomargin}{\tikz[baseline=(a), remember picture, overlay]{
    \coordinate (a) at (0, 0);
    \coordinate (b) at ($(current page.north east)!(a)!(current page.south east) - (2, 0)$);
    \draw[thick, dash pattern=on \pgflinewidth off 1.5pt] (a) -- (b);
  }
}

% Define projectRole command
\newtoks\@projectRoles
\def\projectRoles{\the\@projectRoles}
\def\projectRole#1#2{%
   \@bsphack
   \@projectRoles{\ignorespaces#1\hspace{0.5em}~#2\unskip}%
   \def\projectRole##1##2{%
      \@bsphack
      \@projectRoles\expandafter{\the\@projectRoles\hspace{2em}\ignorespaces##1\hspace{0.5em}~##2\unskip}%
      \@esphack
   }%
   \@esphack
}

% Define initial information of cv (title, "Role in the project" and "Personal information")
\newcommand{\frontmatter}{%
\stdsection
{\fontsize{20}{20}\selectfont\bf Curriculum vitae for \@firstName~\@familyName}
\\[3.25ex]
{\fontsize{12}{12}\selectfont\bf\uppercase{Role in the project}}\hspace{1em}\projectRoles
\section{Personal information}
\bgroup
\def\arraystretch{\arrayStretchLen}
\begin{tabularx}{\textwidth}{|l|X|p{1.5cm}|X|}
  \hline\if@grayheader\cellcolor{nfrgray}\fi
  Family name, First name: & \multicolumn{3}{l|}{\@familyName, \@firstName} \nfrbreak
  \if@grayheader\cellcolor{nfrgray}\fi
  Date of birth: & \@dateOfBirth & \if@grayheader\cellcolor{nfrgray}\fi Sex: & \@sex \nfrbreak
  \if@grayheader\cellcolor{nfrgray}\fi
  Nationality: & \multicolumn{3}{l|}{\@nationality} \nfrbreak
  % Only include "Researcher unique identifier"-row if either \orcid or \researcherID is given
  \ifx\@orcid\@researcherID\empty\else\if@grayheader\cellcolor{nfrgray}\fi
  Researcher unique identifier: & \multicolumn{3}{l|}{\ifx\@orcid\empty\relax\else ORCID:~\href{https://orcid.org/\@orcid}{\@orcid}\hspace{1em}\fi\ifx\@researcherID\empty\relax\else ResearcherID:~\href{https://www.researcherid.com/rid/\@researcherID}{\@researcherID}\hspace{1em}\fi} \nfrbreak
  \fi
  % Only include "URL for personal website"-row if \urlForPersonalWebsite is given
  \ifx\@urlForPersonalWebsite\empty\relax\else\if@grayheader\cellcolor{nfrgray}\fi
  URL for personal website: & \multicolumn{3}{l|}{ \href{\@urlForPersonalWebsite}{\@urlForPersonalWebsite}} \nfrbreak
  \fi
\end{tabularx}
\egroup
}

% Create NFR-tables command
\newenvironment{nfrtable}[1][|p{\dateColumnWidth}|X|]{%
\bgroup
\def\arraystretch{\arrayStretchLen}
	\tabularx{\textwidth}{#1}
	\hline\if@grayheader\rowcolor{nfrgray}\else\cellcolor{nfrgray}\fi%
}{\endtabularx\egroup}

% Create addKeyExpertise command
\RequirePackage{mdframed}
\mdfdefinestyle{keyExpertiseFrame}{%
    innertopmargin=0.3\baselineskip,
    innerbottommargin=0.3\baselineskip,
    innerrightmargin=0.5\baselineskip,
    innerleftmargin=0.5\baselineskip,
    skipabove=\baselineskip,
    backgroundcolor=nfrgray}
\newcommand{\addKeyExpertise}[1]{%
\vspace{0.575\baselineskip}
\begin{mdframed}[style=keyExpertiseFrame]
#1
\end{mdframed}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Format section and subsection
\RequirePackage{titlesec}
\newcommand\stdsection{%
\titleformat{\section}{\fontsize{12}{12}\selectfont\bf}{}{0pt}{\uppercase}[]
\titleformat{\subsection}{\normalfont\bf}{}{0pt}{}[]
\titlespacing{\section}{0pt}{\baselineskip}{*0}    % {left spacing}{before spacing}{after spacing}[right]
\titlespacing{\subsection}{0pt}{\baselineskip}{*0}
}
\newcommand\largesection{%
  \titleformat{\section}{\normalfont\huge\bfseries}{}{0pt}{}
  \titlespacing{\section}{0pt}{\baselineskip}{*0}    % {left spacing}{before spacing}{after spacing}[right]
}
\newcommand\trackrecord{\largesection\section{Track record}\stdsection}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Format BibTeX references
\RequirePackage[%
  backend=biber,
  bibstyle=ieee, % ieee, numeric, ...
  dashed=false,
  citestyle=numeric-comp, % numeric-comp, numeric, ...
  backref=true,
  giveninits=true,
  maxbibnames=99,
  sorting=none,
  doi=false,
  url=false,
  isbn=false,
  ]{biblatex}

% To get a more compact bib-ref: Remove citation number
\if@compactrefs
    \DeclareFieldFormat{labelnumberwidth}{}
    \setlength{\biblabelsep}{0pt}
\fi

\AtEveryBibitem{\clearfield{note}}
\AtEveryCitekey{\clearfield{note}}
\AtEveryBibitem{\clearfield{month}}
\AtEveryCitekey{\clearfield{month}}
\AtEveryBibitem{\clearfield{number}}
\AtEveryCitekey{\clearfield{number}}
% The following makes titles hyperlinked
\newbibmacro{string+doiurlisbn}[1]{%
  \iffieldundef{doi}{%
    \iffieldundef{url}{%
      \iffieldundef{isbn}{%
        \iffieldundef{issn}{%
          #1%
        }{%
          \href{http://books.google.com/books?vid=ISSN\thefield{issn}}{#1}%
        }%
      }{%
        \href{http://books.google.com/books?vid=ISBN\thefield{isbn}}{#1}%
      }%
    }{%
      \href{\thefield{url}}{#1}%
    }%
  }{%
    \href{http://dx.doi.org/\thefield{doi}}{#1}%
  }%
}
\DeclareFieldFormat{title}{\usebibmacro{string+doiurlisbn}{\mkbibemph{#1}}}
\DeclareFieldFormat[article,incollection]{title}{\usebibmacro{string+doiurlisbn}{\mkbibquote{#1}}}

% Create command for adding list of references
\def\makeNewRefSection{\gdef\makeNewRefSection{\newrefsection}}
\newcommand{\addReferences}[1]{%
\makeNewRefSection
\nocite{#1}
\printbibliography[heading=none]
}

% Make command for putting given author in bold in the publication list:
\usepackage{xstring}
\usepackage{etoolbox}
\newboolean{bold}
\newcommand{\makeauthorsbold}[1]{%
  \DeclareNameFormat{author}{%
  \setboolean{bold}{false}%
    \renewcommand{\do}[1]{\expandafter\ifstrequal\expandafter{\namepartfamily}{####1}{\setboolean{bold}{true}}{}}%
    \docsvlist{#1}%
    \ifthenelse{\value{listcount}=1}
    {%
      {\expandafter\ifthenelse{\boolean{bold}}{\mkbibbold{\namepartfamily\addcomma\addspace \namepartgiveni}}{\namepartfamily\addcomma\addspace \namepartgiveni}}%
    }{\ifnumless{\value{listcount}}{\value{liststop}}
      {\expandafter\ifthenelse{\boolean{bold}}{\mkbibbold{\addcomma\addspace \namepartfamily\addcomma\addspace \namepartgiveni}}{\addcomma\addspace \namepartfamily\addcomma\addspace \namepartgiveni}}%
      {\expandafter\ifthenelse{\boolean{bold}}{\mkbibbold{\addcomma\addspace \namepartfamily\addcomma\addspace \namepartgiveni\addcomma\isdot}}{\addcomma\addspace \namepartfamily\addcomma\addspace \namepartgiveni\addcomma\isdot}}%
      }
    \ifthenelse{\value{listcount}<\value{liststop}}
    {\addcomma\space}{}
  }
}