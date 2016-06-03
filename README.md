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
Öncelikle "docker-composer.yml.sample" dosyası "docker-compser.yml" olarak kopyalaım içerisinde proje için gereken değişiklikler yapılır.
Proje ismi ile docker container ismi belirlenir. İmaj ismi önemlidir. Önceki adımda oluşturulan imajın ismi verilmelidir.
Daha sonra proje ihtiyaçlarına göre port, volume vs. eklenebilir.

Default ayarlar ile geliştirici makinasından proje ana dizini docker container içersine default "/data/project" olarak bağlanacaktır.
Mysql data dizini de her container stop/start sırasında kaybolmaması için buraya eklenmiştir. 


```bash
$ cp docker-compose.yml.sample docker-compose.yml
$ docker-compose up -d
```
## Container Erişimi
Çalışan containera ssh ile erişmek için

```bash
$ docker exec -it [CONTAINER_NAME] /bin/bash
```

CONTAINER_NAME docker-compose.yml dosyasında verdiğimiz proje ismi olmaktadır.

Web üzerinden erişmek için çalışan docker machine default ipsi olan 192.168.99.100 ile erişilebilir :

http://192.168.99.100/

Çalışan sanal makina sizin makinanızı 192.168.99.1 olarak görür. Gereken yerlerde bu ip kullanılabilir.
