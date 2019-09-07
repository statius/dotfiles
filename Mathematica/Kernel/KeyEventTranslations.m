(* ::Package:: *)

(* installation script for extra Mathematica front end keyboard shortcuts *)

Module[
  {
   keyEventsFile,
   keyEventString
  },
  
  (* find system KeyEventTranslations.tr file *)
  keyEventsFile = FrontEndExecute[
    FrontEnd`FindFileOnPath["KeyEventTranslations.tr", "PrivatePathsTextResources"]
  ];
  
  (* import system KeyEventTranslations resource string *)
  keyEventString = Import[keyEventsFile, "Text"];
  
  (* change path into $UserBaseDirectory *)
  keyEventsFile = StringReplace[
    keyEventsFile,
    $InstallationDirectory -> $UserBaseDirectory
  ];
  
  (* create necessary directory structure *)
  If[
    ! DirectoryQ[DirectoryName @ keyEventsFile],
    CreateDirectory[
      DirectoryName @ keyEventsFile,
      CreateIntermediateDirectories -> True
    ]
  ];
    
  (* splice double braket notation in to system KeyEventTranslation string *)
  keyEventString = StringReplace[
    keyEventString,
    "EventTranslations[{" -> "EventTranslations[{

(* Double bracket notation *)
\tItem[KeyEvent[\"[\", Modifiers -> {Control}],
\t\tFrontEndExecute[{
\t\t\tFrontEnd`NotebookWrite[FrontEnd`InputNotebook[], \"\[LeftDoubleBracket]\", After]
\t\t}]],
\tItem[KeyEvent[\"]\", Modifiers -> {Control}],
\t\tFrontEndExecute[{
\t\t\tFrontEnd`NotebookWrite[FrontEnd`InputNotebook[], \"\[RightDoubleBracket]\", After]
\t\t}]], 
\tItem[KeyEvent[\"]\", Modifiers -> {Control, Command}],
\t\tFrontEndExecute[{
\t\t\tFrontEnd`NotebookWrite[FrontEnd`InputNotebook[], \"\[LeftDoubleBracket]\", After],
\t\t\tFrontEnd`NotebookWrite[FrontEnd`InputNotebook[], \"\[RightDoubleBracket]\", Before]
\t\t}]],"
  ]
  
  (* check if user KeyEventTranslations.tr exists  *)
  (* if it does, check if it is the same as the newly spliced string *)
  (* if it does not exist or match, export the new string *)
  If[
    Nand[
      FileExistsQ @ keyEventsFile,
      StringMatchQ[keyEventString, Import[keyEventsFile, "Text"]]
    ],
    Export[keyEventsFile, keyEventString, "Text"]
  ];
  
  (* reload text resources if session is using a front end *)
  If[
    $FrontEnd =!= Null,
    FrontEndExecute @ FrontEnd`FlushTextResourceCaches[]
  ];

]
