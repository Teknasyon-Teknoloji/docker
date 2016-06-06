# docker
Docker for PHP Projects

## Docker Kurulumu

Linux için docker Linux dağıtımının repolarından kurulabilir.
Mac ve Windows için Docker Toolbox kurulabilir.
Docker Toolbox Docker çalıştırmak için gereken tüm bileşenleri kurar.

https://www.docker.com/products/docker-toolbox

## Docker Machine Çalıştırılması ( Mac OSX )

Docker Toolbox kurulduktan sonra uygulamalar altından  "Docker Quickstart Terminal" uygulaması çalışıtırlır.
İlk kez çalıştırıldığında  dokcer machine ayağa kalkar ve sanal makina hazır hale gelir. Bu makina için verilen isim "default" şeklindedir.
Docker machine ile sanal makina açılıp kapatılabilir.

```bash
$ docker-machine start default
$ docker-machine stop default
$ docker-machine restart default
```

## Docker Imaj Oluşturulması
Öncelikle docker dosyaları proje ana dizini içerisinde "docker" isimli bir dizin oluşturulup oraya taşınmalı.
Projenin docker imajını hazırlamak için projedeki docker dizini altında aşağıdaki komut çalıştırılabilir.
Imaj bu dizindeki Dockerfile dosyasına göre hazırlanmaktadır. Proje ihtiyaçlarına göre bu dosya gözden geçirilip eksik bir sistem modülü veya php modülü eklenebilir.

```bash
$ docker build -t [PROJECT_IMG_NAME] .
```

Bu komutta [PROJECT_IMG_NAME] ismini projeye uygun olarak değiştirmelisiniz. Örneğin mymobi_img gibi.

## Proje Docker Container Ayarları
Proje için container ayarlayıp çalıştırması docker-compose komutu ile yapılabilir.
Öncelikle "docker-compser.yml" dosyası içerisinde proje için gereken değişiklikler yapılır.
Proje ismi ile docker container ismi belirlenir. İmaj ismi önemlidir. Önceki adımda oluşturulan imajın ismi verilmelidir.
Daha sonra proje ihtiyaçlarına göre port, volume vs. eklenebilir.

Default ayarlar ile geliştirici makinasından proje ana dizini docker container içersine default "/data/project" olarak bağlanacaktır.

```bash
$ docker-compose up -d
```
## Container Erişimi
Çalışan containera ssh ile erişmek için

```bash
$ docker exec -it [CONTAINER_NAME] /bin/bash
```

CONTAINER_NAME docker-compose.yml dosyasında servisin container_name ayarı ile tanımlanır. Bu ayar docker exec komutu ile kullanılabilir.

Container'lar çalıştıktan sonra erişim portları otomatik olarak tanımlanır. Bu portlar aşağıdaki komutla görülebilir:
```bash
$ docker ps
```

Web üzerinden erişmek için çalışan docker machine default ipsi olan 192.168.99.100 ile erişilebilir :

http://192.168.99.100:PORT/

Çalışan sanal makina sizin makinanızı 192.168.99.1 olarak görür. Gereken yerlerde bu ip kullanılabilir.

## Docker Servisleri
Mysql, memcached ve gearmand servisleri öntanımlı olarak eklenmiştir. Proje ihtiyaçlarına göre yeni servisler eklenebilir ya da çıkartılabilir. https://hub.docker.com/ adresi üzerinden resmi ve resmi olmayan servisler ihtiyaçlara göre kullanılabilir.

Uygulama servisine links ayarı ile tanıtılan servislere, ilgili servis adı üzerinden erişilebilir. Örneğin veritabanı bağlantısı ya da memcached erişimi için IP adresi yerine mysql:3306, memcached:11211 portu üzerinden erişim sağlanabilir.

Servislerde kullanılan ports ayarı ise, bu portun ana makinadan erişilebilir olmasını sağlar. Eğer bir servisin ana makinadan erişilmesine ihtiyaç yoksa bu ayar kaldırılabilir. Genel olarak mysql veritabanına erişim gerektiğinden, docker-compose.yml dosyasında bu servisin port ayarı tanımlanmıştır.

## Faydalı Docker Komutları
Çalışan containerları listelemek için
```bash
$ docker ps
```

Tüm containerları listelemek için
```bash
$ docker ps -a
```
