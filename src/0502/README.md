# try bicep linter

bicep linter のPRが上がってきたので動かしてみた。<https://github.com/Azure/bicep/pull/2341>

## 実行

buildしたのにパスを切って動かしてみる。buildに関しては後述する。

`BCL1000.bicep` としてパラメータが無いテンプレートを作る。これはlinterに引っかかるはず。

```sh
% bicep build BCL1000.bicep
BCL1000.bicep(1,1) : Error BCPL1000: A valid template must be parameterized.
%
```

それっぽいが、エラーになった、エラーは厳しいんじゃないかと思うが、`bicepsettings.json` で警告にも出来るらしい。

`BCPL1010` の未使用なパラメータのチェックが便利そうなので`BCPL1010.bicep`を作って試してみる。

```sh
% bicep build BCL1010.bicep
BCL1010.bicep(1,9) : Warning BCPL1010: Declared parameter must be referenced within the document scope.
```

こっちは、Warning だった。コピってきた`bicepsettings.json` を見ると、下記のように書くと、Warning にできるらしい。`"DiagnosticLevel": "Error"` と書くとエラーになる。詳しい仕様は不明。

```json
"BCPL1010": {
  "EnabledForEditing": true,
  "EnabledForCLI": true
},
```

今のサポートされているルール。基本は、arm-ttk から持ってくる予定のようだ。

- BCPL1000: "A valid template must be parameterized."
- BCPL1010: "Declared parameter must be referenced within the document scope."
- BCPL1020: "Environment() URLs should not be hardcoded"、
- BCPL1030: "Secure parameters can't have hardcoded default. This prevents storage of sensitive data in the Bicep declaration.",
- BCPL1040: "Best practice dictates that Location be set via parameter.",
- BCPL1050: "Declared variable encountered that is not used within scope.",
- BCPL1060: "Dynamic variable should not use concat - string interpolation should be used."
- BCPL1070: "Best Practice: remove unnecessary dependsOn."
- BCPL1080: "String interpolation can be simplified. String variables can be directly assigned to string properties and variables.",

## ビルド

```sh
% git clone git@github.com:jfleisher/bicep.git bicep-linter
% git checkout linter
% dotnet publish --configuration ubuntu-latest --self-contained true -p:PublishTrimmed=true -p:PublishSingleFile=true -r linux-x64 ./src/Bicep.Cli/Bicep.Cli.csproj
% cp -f ~/projects/bicep/src/Bicep.Cli/bin/ubuntu-latest/net5.0/linux-x64/publish/* ~/.local/bin
% bicep -v
Bicep CLI version 0.3.414 (49cd931079)
```

```sh
% LC_MESSAGES=C make
dotnet publish --configuration ubuntu-latest --self-contained true -p:PublishTrimmed=true -p:PublishSingleFile=true -r linux-x64 ./src/Bicep.Cli/Bicep.Cli.csproj
Microsoft (R) Build Engine version 16.9.0+57a23d249 for .NET
Copyright (C) Microsoft Corporation. All rights reserved.

  Determining projects to restore...
  All projects are up-to-date for restore.
/home/takekazu/projects/bicep-linter/src/Bicep.Core/Configuration/ConfigHelper.cs(26,31): error IL3000: 'System.Reflection.Assembly.Location' always returns an empty string for assemblies embedded in a single-file app. If the path to the app directory is needed, consider calling 'System.AppContext.BaseDirectory'. [/home/takekazu/projects/bicep-linter/src/Bicep.Core/Bicep.Core.csproj]
/home/takekazu/projects/bicep-linter/src/Bicep.Core/Analyzers/Linter/LinterAnalyzer.cs(26,28): error IL3000: 'System.Reflection.Assembly.Location' always returns an empty string for assemblies embedded in a single-file app. If the path to the app directory is needed, consider calling 'System.AppContext.BaseDirectory'. [/home/takekazu/projects/bicep-linter/src/Bicep.Core/Bicep.Core.csproj]
make: *** [Makefile:2: build] Error 1
```

今のコードはそのままでは動かないようなので、回避作として、`-p:PublishTrimmed=true -p:PublishSingleFile=true` を外してビルドして、`bicepsettings.json` をソースからカレントディレクトリにコピーして実行する。
