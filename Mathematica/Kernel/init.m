(* ::Package:: *)

(* User Mathematica Kernel initialization file. *)

(* Import Wolfram Language $Path from `path.m`. *)
With[
  {pathFile = FileNameJoin @ {DirectoryName @ $InputFileName, "path.m"}},

  If[FileExistsQ @ pathFile, Get @ pathFile]

];

(* Set `Environment["PATH"]` to `$PATH` sourced from `~.bash_profile`. *)
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


(* Add new key events. *)
With[
  {keyFile = FileNameJoin @ {DirectoryName @ $InputFileName, "KeyEventTranslations.m"}},

  If[And[FileExistsQ @ keyFile, $FrontEnd =!= Null], Get @ keyFile]

];
