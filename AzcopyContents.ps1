# ストレージアカウント名
$SA_NAME = "mystorage20220901"

# ファイル共有名
$SHARE_NAME = "fileshare"

# ファイル共有ディレクトリ
$CONTENTS_PATH = "foo/bar"

# コピー元ローカルディレクトリ
$SOURCE_DIR = ".\contents\"

# SAS トークン有効期限
$EXPIRY = (Get-Date).AddMinutes(30).ToString("yyyy-MM-ddTHH:mmZ")

# azcopy.exe のパス
$AZCOPY = "C:\Program Files\azcopy\azcopy.exe"


Write-Output "==== Start file sync ===="

# SAS トークン取得
$SAS_TOKEN = az storage share generate-sas --name $SHARE_NAME --account-name $SA_NAME --expiry $EXPIRY --permissions cdlrw --https-only
Write-Output SAS_TOKEN: $SAS_TOKEN

# ファイル共有 URL 取得
$DEST_URL = az storage share url --name $SHARE_NAME --account-name $SA_NAME --sas-token $SAS_TOKEN

# URL にディレクトリを付加
# もっとスマートなやり方が無いものか。。
$DEST_URL = $DEST_URL.Replace("$SHARE_NAME", "$SHARE_NAME/$CONTENTS_PATH/")

Write-Output SOURCE: $SOURCE_DIR
Write-Output DESTINATION: $DEST_URL

# SOURCE から DEST_URL に再帰的にファイルをコピー
# azcopy sync $SOURCE_DIR $DEST_URL --recursive=true --delete-destination=false
Start-Process -FilePath $AZCOPY -ArgumentList "sync $SOURCE_DIR $DEST_URL --recursive=true --delete-destination=false" -NoNewWindow -Wait

Write-Output "==== End file sync ===="
