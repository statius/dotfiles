(* ::Package:: *)

(* Installation script for extra Mathematica front end keyboard shortcuts. *)

Module[
  {
   keyEventsFile,
   keyEventString
  },
  
  (* Find system `KeyEventTranslations.tr` file. *)
  keyEventsFile = FrontEndExecute[
    FrontEnd`FindFileOnPath["KeyEventTranslations.tr", "PrivatePathsTextResources"]
  ];
  
  (* Import system `KeyEventTranslations` resource string. *)
  keyEventString = Import[keyEventsFile, "Text"];
  
  (* Change path into `$UserBaseDirectory`. *)
  keyEventsFile = StringReplace[
    keyEventsFile,
    $InstallationDirectory -> $UserBaseDirectory
  ];
  
  (* Create necessary directory structure. *)
  If[
    ! DirectoryQ[DirectoryName @ keyEventsFile],
    CreateDirectory[
      DirectoryName @ keyEventsFile,
      CreateIntermediateDirectories -> True
    ]
  ];
    
  (* Splice double braket notation in to system `KeyEventTranslation` string. *)
  keyEventString = StringReplace[
    keyEventString,
    "EventTranslations[{

(* Evaluation *)" -> "EventTranslations[{

(* Double bracket notation *)
\tItem[KeyEvent[\"[\", Modifiers -> {Control}],
\t\tFrontEndExecute[{
\t\t\tFrontEnd`NotebookWrite[FrontEnd`InputNotebook[], leftDoubleBracket, After]
\t\t}]],
\tItem[KeyEvent[\"]\", Modifiers -> {Control}],
\t\tFrontEndExecute[{
\t\t\tFrontEnd`NotebookWrite[FrontEnd`InputNotebook[], rightDoubleBracket, After]
\t\t}]], 
\tItem[KeyEvent[\"]\", Modifiers -> {Control, Command}],
\t\tFrontEndExecute[{
\t\t\tFrontEnd`NotebookWrite[FrontEnd`InputNotebook[], leftDoubleBracket, After],
\t\t\tFrontEnd`NotebookWrite[FrontEnd`InputNotebook[], rightDoubleBracket, Before]
\t\t}]],

(* Evaluation *)"
  ];

  keyEventString = StringReplace[
    keyEventString, 
    {
     "leftDoubleBracket" -> ToString[FullForm @ "\[LeftDoubleBracket]"],
     "rightDoubleBracket" -> ToString[FullForm @ "\[RightDoubleBracket]"]
    }
  ];
  
  (* Check if user `KeyEventTranslations.tr` exists. *)
  (* - if it does, check if it is the same as the newly spliced string *)
  (* - if it does not exist or match, export the new string *)
  If[
    Nand[
      FileExistsQ @ keyEventsFile,
      SameQ[keyEventString, Import[keyEventsFile, "Text"]]
    ],
    Export[keyEventsFile, keyEventString, "Text"]
  ];
  
  (* Reload text resources if session is using a front end. *)
  (* note: this may not be very effective *)
  If[
    $FrontEnd =!= Null,
    FrontEndExecute @ FrontEnd`FlushTextResourceCaches[]
  ];

]
