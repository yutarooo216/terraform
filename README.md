# terraform_docker

terraform実行コンテナになります。

## 参考サイト

[dockerでterraform環境を構築して、AWSにVPCを作る。](https://syoblog.com/terraform-environment/)

[Terraformを使い、Azureのインフラ構築してみた](https://qiita.com/takakuda/items/1e93fb0a7cc542b4adc1)

[TerraformでOCI上に仮想サーバを建ててみた](https://blogs.techvan.co.jp/oci/2019/04/08/terraform%e3%81%a7oci%e4%b8%8a%e3%81%ab%e4%bb%ae%e6%83%b3%e3%82%b5%e3%83%bc%e3%83%90%e3%82%92%e5%bb%ba%e3%81%a6%e3%81%a6%e3%81%bf%e3%81%9f/)

## 開発環境構築方法

### dockerソースファイル入手

```bash
git clone https://github.com/naritomo08/terraform_docker_public.git terraform
cd terraform
```

後にファイル編集などをして、git通知が煩わしいときは
作成したフォルダで以下のコマンドを入れる。

```bash
 rm -rf .git
```

### ソースフォルダ作成

```bash
mkdir source
→本ファイル内にmain.tfなどのソースファイルを置く。
```

### 環境変数ファイル作成

```bash
vi .env

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
→AWSの場合、操作ユーザに対応した
 上記の情報を入れる。

ARM_SUBSCRIPTION_ID=
ARM_CLIENT_ID=
ARM_CLIENT_SECRET=
ARM_TENANT_ID=

→AWSの場合、操作ユーザに対応した
 上記の情報を入れる。

gcp管理画面からアクセスjsonキーを入手して、ソースファイルと同じ場所に置く
```

環境変数を取得するための方法は以下を参照してください。

https://qiita.com/SSMU3/items/ce6e291a653f76ddcf79

https://qiita.com/takakuda/items/1e93fb0a7cc542b4adc1

https://dev.classmethod.jp/articles/accesse-google-cloud-with-terraform/

### OCI APIキー作成(OCI利用)

以下のコマンドでOCI APIキーを作成する。

```bash
cd source
mkdir apikey
cd apikey
openssl genrsa -out id_rsa
openssl rsa -in id_rsa -pubout -out id_rsa.pem
ls
→id_rsa,id_rsa.pemファイルが存在していることを確認する。
```

### OCID情報の収集（OCI利用）

以下のサイトの"3.OCID情報の収集"を参照し、以下の情報を収集する。

リソースを入れるコンパートメントは予め作成すること。

* テナンシのOCID
* ユーザーのOCID
* フィンガープリント
* コンパートメントのOCID
* 使用しているリージョンの識別子(例:ap-osaka-1)
* テナンシのオブジェクト・ストレージ・ネームスペース

参考サイト：

[TerraformでOCI上に仮想サーバを建ててみた](https://blogs.techvan.co.jp/oci/2019/04/08/terraform%e3%81%a7oci%e4%b8%8a%e3%81%ab%e4%bb%ae%e6%83%b3%e3%82%b5%e3%83%bc%e3%83%90%e3%82%92%e5%bb%ba%e3%81%a6%e3%81%a6%e3%81%bf%e3%81%9f/)

##　開発環境操作

### 開発環境コンテナ起動/設定再読み込み

```bash
docker-compose up -d
```

### 開発環境コンテナ停止

```bash
docker-compose stop
```

### 開発環境コンテナ破棄

```bash
docker-compose down
```

### terraformコンテナログイン

```bash
docker-compose exec terraform ash
```