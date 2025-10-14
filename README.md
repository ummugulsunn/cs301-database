# CS301 Veritabanı Yönetim Sistemleri

**Ders Materyalleri ve Uygulama Dosyaları**

Bu repository, CS301 Veritabanı Yönetim Sistemleri dersi için hazırlanmış materyalleri içerir.

## 📚 Ders Hakkında

- **Ders Kodu**: CS301
- **Ders Adı**: Veritabanı Yönetim Sistemleri  
- **Öğretim Yılı**: 2025-2026
- **IDE**: DataGrip
- **Veritabanı**: MySQL/PostgreSQL

### 🎯 Ders Hedefleri

- SQL temellerini öğrenmek
- Veritabanı tasarım prensiplerini anlamak
- DataGrip ile pratik yapmak
- Gerçek hayat senaryolarını uygulamak

## 📁 Dosya Yapısı

```
cs301-database/
├── 📚 docs/                          # Ders dokümanları
│   ├── Database_Management_Fundamentals_Guide.md
│   └── README_How_to_Use.md
├── 🗄️ database/                      # SQL dosyaları
│   ├── 01_Database_Setup.sql         # Veritabanı oluşturma
│   ├── 02_Sample_Data_Insert.sql     # Örnek veriler
│   ├── 03_Basic_Queries.sql          # Temel SQL sorguları
│   ├── 04_Advanced_Queries.sql       # İleri seviye teknikler
│   ├── 05_DML_Operations.sql         # Veri işleme
│   └── 06_DataGrip_Practice.sql      # Pratik alıştırmalar
├── 📖 lectures/                      # Ders notları
├── 🎯 exercises/                     # Alıştırmalar
├── 📊 projects/                      # Projeler
└── 📝 notes/                         # Kişisel notlar
```

## 🚀 Başlangıç

### Gereksinimler

- DataGrip IDE (Öğrenciler için ücretsiz)
- MySQL veya PostgreSQL veritabanı sunucusu

### Kurulum Adımları

1. **Repository'yi klonla**
   ```bash
   git clone https://github.com/your-username/cs301-database.git
   cd cs301-database
   ```

2. **DataGrip'i ayarla**
   - DataGrip IDE'yi yükle
   - Yeni veritabanı bağlantısı oluştur
   - MySQL/PostgreSQL sunucusunu yapılandır

3. **Veritabanını başlat**
   ```sql
   -- DataGrip'te setup scriptini çalıştır
   -- Dosya: database/01_Database_Setup.sql
   ```

4. **Örnek verileri yükle**
   ```sql
   -- Veri ekleme scriptini çalıştır
   -- Dosya: database/02_Sample_Data_Insert.sql
   ```

5. **Pratik yapmaya başla**
   ```sql
   -- Temel sorgularla başla
   -- Dosya: database/03_Basic_Queries.sql
   ```

## 📖 Ders İçeriği

### Hafta 1: Veritabanı Temelleri
- [ ] Veritabanı kavramları ve terminoloji
- [ ] Entity-Relationship modelleme
- [ ] Veritabanı tasarım prensipleri
- [ ] Geliştirme ortamının kurulması

### Hafta 2: SQL Temelleri
- [ ] Data Definition Language (DDL)
- [ ] Data Manipulation Language (DML)
- [ ] Temel SELECT sorguları
- [ ] WHERE, ORDER BY, GROUP BY cümlecikleri

### Hafta 3: İleri SQL
- [ ] JOIN işlemleri (INNER, LEFT, RIGHT, FULL)
- [ ] Alt sorgular ve ilişkili alt sorgular
- [ ] Window fonksiyonları
- [ ] Common Table Expressions (CTEs)

### Hafta 4: Pratik Uygulamalar
- [ ] Veritabanı optimizasyonu ve indeksleme
- [ ] İşlem yönetimi
- [ ] Veri bütünlüğü ve kısıtlamalar
- [ ] Gerçek hayat projesi uygulaması

## 🛠️ Araçlar ve Teknolojiler

| Araç | Amaç | Versiyon |
|------|------|----------|
| **DataGrip** | Veritabanı IDE | Son |
| **MySQL** | Veritabanı Sunucusu | 8.0+ |
| **PostgreSQL** | Alternatif DB | 13+ |
| **Git** | Versiyon Kontrolü | Son |

## 📊 Örnek Veritabanı Şeması

Pratik veritabanımız kapsamlı bir üniversite yönetim sistemi içerir:

```
🏛️ Üniversite Veritabanı Şeması

Öğrenciler (15 kayıt)
├── Kişisel bilgiler (isim, email, iletişim)
├── Akademik veriler (GPA, kayıt tarihi, durum)
└── Derslerle ilişki (enrollments üzerinden)

Dersler (18 kayıt)
├── Ders detayları (kod, isim, kredi)
├── Bölüm ilişkisi
└── Ön koşul ilişkileri

Bölümler (6 kayıt)
├── Bölüm bilgileri
├── Bölüm başkanı
└── Bina ve iletişim detayları

Öğretim Üyeleri (10 kayıt)
├── Fakülte bilgileri
├── Bölüm ilişkisi
└── Akademik unvan ve maaş

Kayıtlar (50+ kayıt)
├── Öğrenci-ders ilişkileri
├── Not takibi
└── Dönem ve yıl bilgileri
```

## 🎯 Pratik Alıştırmalar

### 📈 Zorluk Seviyeleri

| Seviye | Açıklama | Dosyalar |
|--------|----------|----------|
| **Başlangıç** | Temel SELECT, WHERE, ORDER BY | `03_Basic_Queries.sql` |
| **Orta** | JOIN'ler, alt sorgular, toplamalar | `04_Advanced_Queries.sql` |
| **İleri** | Window fonksiyonları, CTE'ler, optimizasyon | `05_DML_Operations.sql` |
| **Uzman** | Karmaşık senaryolar, performans ayarlama | `06_DataGrip_Practice.sql` |

### 🏆 Alıştırma Kategorileri

- **Veri Getirme**: Çeşitli koşullarla SELECT sorguları
- **Veri İşleme**: INSERT, UPDATE, DELETE işlemleri
- **Veri Analizi**: Toplamalar, gruplama ve istatistikler
- **Veritabanı Tasarımı**: Şema optimizasyonu ve normalizasyon
- **Performans Ayarı**: İndeksleme ve sorgu optimizasyonu

## 📚 Çalışma Kaynakları

### 📖 Önerilen Okumalar
- **Ders Kitabı**: Database Management Systems by Raghu Ramakrishnan
- **SQL Referansı**: W3Schools SQL Tutorial
- **Pratik Platform**: HackerRank SQL Challenges

### 🔗 Faydalı Linkler
- [MySQL Dokümantasyonu](https://dev.mysql.com/doc/)
- [PostgreSQL Dokümantasyonu](https://www.postgresql.org/docs/)
- [DataGrip Kullanıcı Kılavuzu](https://www.jetbrains.com/help/datagrip/)
- [SQL Fiddle](http://sqlfiddle.com/) - Online SQL test

## 👨‍🎓 Öğrenci Hakkında

**İsim**: [Adınız]  
**Ders**: CS301 Veritabanı Yönetim Sistemleri  
**Üniversite**: [Üniversiteniz]  
**Dönem**: 2025-2026 Bahar  

## 📞 İletişim

- **Email**: [email@universite.edu]
- **GitHub**: [@kullanici-adi](https://github.com/kullanici-adi)

---

⭐ **Bu repository'yi yıldızla** veritabanı çalışmalarınız için faydalı bulduysanız!

📚 **İyi Çalışmalar!** SQL pratik yapmaya devam edin!
