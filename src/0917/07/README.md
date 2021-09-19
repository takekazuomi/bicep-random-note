# README

Makefile で`mysql-firewall-rules.json`に、自分のIPを入れるようにした。しかし、`mysql-firewall-rules.json` を更新するのは、git フレンドリーじゃない。bicep では、`var firewallrules = json(loadTextContent('mysql-firewall-rules.json'))` と書いた時の、loadTextContent の中身は固定で変数にはできない。これによって、インテリセンスが効いて便利ではあるのだが、`mysql-firewall-rules.json` を環境依存のファイル置き場にはおけない。


