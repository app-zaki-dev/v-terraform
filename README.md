# Terraformの検証

### リソース
- VPC
<!-- - EC2
- S3
- ELB
- Aurora Serverless v2 -->

<br>

### 環境構築
ローカルPCにterraformをインストール後、  
awsのcredential情報をprofile付きで設定してください
```
aws configure --profile name
```
<br>

環境変数のterraform.tfvarsファイルはS3で管理します。
そのため、実行するリソースディレクトリと同じレベルに下記ファイルを作成後、値を設定してください
```
実行するenv内のリソースフォルダ/
cp .default.env terraform.tfvars

作成したファイルに自分の値を設定してください
```

<br>

### 実行方法
実行したいenvsファイルのリソースディレクトリに移動し、
下記のコマンドを実行してください
```
ex/
cd envs/dev/aws_vpc

terraform init --reconfigure -backend-config=env.tfbackend
terraform apply

# backend.tfの構成を変更した時
terraform init -migrate-state

# 削除
terraform destroy
```
<br>

### 環境変数について
呼び出し元のbackend.tfでは変数が使用できないため、  
tfvarsファイルとは別に秘密情報をenv.tfbackendファイルを配置してinit時に読み込ませるようにしています。  
主にS3のバケット名とAWSのProfile名を管理しています。  

```
env.tfbackend

bucket  = "バケット名"
key     = "ファイル名"
region  = "リージョン"
profile = "AWSプロファイル"
```

