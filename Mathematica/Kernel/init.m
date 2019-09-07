(* ::Package:: *)

(* user Mathematica Kernel initialization file *)

(* import Wolfram Language $Path from `path.m` *)
(* path.m is not committed *)
With[
  {pathFile = FileNameJoin @ {DirectoryName @ $InputFileName, "path.m"}},

  If[FileExistsQ @ pathFile, Get @ pathFile]

];

(* set Environment["PATH"] to $PATH sourced from ~.bash_profile *)
If[
  $VersionNumber >= 10,
  SetEnvironment["PATH" -> StringTrim @ RunProcess[{"bash", "-cl", "echo $PATH"}, "StandardOutput"]]
];

If[
  9 <= $VersionNumber < 10,

  Block[
    {file = CreateFile[]},

    Run["bash -cl 'echo $PATH' >> " <> file];
    SetEnvironment["PATH" -> StringTrim @ Import[file, "String"]];
    DeleteFile @ file;

  ]
]


(* add new key events *)
With[
  {keyFile = FileNameJoin @ {DirectoryName @ $InputFileName, "KeyEventTranslations.m"}},

  If[And[FileExistsQ @ keyFile, $FrontEnd =!= Null], Get @ keyFile]

];

(* see Mathematica Stack Exchange question https://mathematica.stackexchange.com/questions/6224 *)
(*
Needs @ "CustomKeyEvents`"

AddKeyEvent[
  "[", 
  FrontEndExecute[
    {
     FrontEnd`NotebookWrite[
       FrontEnd`InputNotebook[],
       "\[LeftDoubleBracket]", 
       After
     ]
    }
  ] 
  "Modifiers" -> {"Control"}
];

AddKeyEvent[
  "]", 
  FrontEndExecute[
    {
     FrontEnd`NotebookWrite[
       FrontEnd`InputNotebook[],
       "\[RightDoubleBracket]", 
       Before
     ]
    }
  ] 
  "Modifiers" -> {"Control"}
];

AddKeyEvent[
  "[", 
  FrontEndExecute[
    {
     FrontEnd`NotebookWrite[
       FrontEnd`InputNotebook[],
       "\[LeftDoubleBracket]", 
       After
     ],
     FrontEnd`NotebookWrite[
       FrontEnd`InputNotebook[],
       "\[RightDoubleBracket]", 
       Before
     ]
    }
  ] 
  "Modifiers" -> {"Control", Switch[$OperatingSystem, "MacOSX", "Command", _, "Alt"]}
];
*)