
## 準備

Azure CLI, AzCopy を使います。作業用PCまたはサーバーにインストールしてください。

- [Azure CLI](https://docs.microsoft.com/ja-jp/cli/azure/install-azure-cli-windows?tabs=azure-cli)
- [AzCopy](https://docs.microsoft.com/ja-jp/azure/storage/common/storage-use-azcopy-v10)


## Azure CLI サインイン

以下のコマンドを実行して、ファイル共有にアクセス権があるユーザーで Azure にサインインします。

```cmd
az login
```


## ファイルの同期

AzcopyContents.ps1 をエディタで開き、環境に合わせて以下を変更します。

- ストレージアカウント名
- ファイル共有名
- ディレクトリパス
- コピー元ディレクトリパス
- SAS トークン有効期限
- azcopy.exe パス


AzcopyContents.ps1 スクリプトを実行してファイルを同期します。

```powershell
.\AzcopyContents.ps1
```

PSSecurityException が出る場合は実行ポリシーを変更して実行してください。

```powershell
PowerShell -ExecutionPolicy RemoteSigned .\AzcopyContents.ps1
```


## 参考

- [azcopy sync - Microsoft Docs](https://docs.microsoft.com/ja-jp/azure/storage/common/storage-ref-azcopy-sync)
