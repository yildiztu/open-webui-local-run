# Open WebUI Kurulum Rehberi

Bu README, Open WebUI'nin Windows ortamında PostgreSQL ve pgvector ile kurulumunu anlatmaktadır.

## Gerekli Ortam Değişkenleri

Aşağıdaki içeriği `.env` dosyasına kaydedin:

```
DATABASE_URL=postgresql://postgres:PWD@localhost:5432/postgres
WEBUI_AUTH=true
ENABLE_WEBSOCKET_SUPPORT=false
VECTOR_DB=pgvector
ENABLE_LOGIN_FORM=true
```

## pgvector Kurulumu

Visual Studio ve PostgreSQL kurulu olduğunu varsayarak, aşağıdaki komutları bir CMD penceresinde çalıştırın:

```batch
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
set "PGROOT=C:\Program Files\PostgreSQL\16"
cd %TEMP%
git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git
cd pgvector
nmake /F Makefile.win
nmake /F Makefile.win install
```

Bu komutlar:
1. Visual Studio geliştirme ortamını yükler
2. PostgreSQL dizinini belirler
3. pgvector eklentisini indirir
4. pgvector'ü derler ve PostgreSQL'e yükler

## Open WebUI Kurulumu ve Çalıştırma

PowerShell'de aşağıdaki komutları çalıştırın:

```powershell
# Sanal ortam oluşturma
python -m venv openwebui-env

# Open WebUI'yi yükleme
pip install open-webui

# Sanal ortamı aktifleştirme
.\openwebui-env\Scripts\activate

# .env dosyasındaki değişkenleri ortam değişkenlerine yükleme
Get-Content .env | ForEach-Object {
    $name, $value = $_.split('=')
    if ($name -and $value) {
        Set-Item -Path "env:$name" -Value $value
    }
}

# Open WebUI'yi çalıştırma
open-webui serve
```

## Notlar

- PostgreSQL'in çalışır durumda olduğundan emin olun
- `.env` dosyasındaki veritabanı bağlantı bilgilerini kendi kurulumunuza göre düzenleyin
- Güvenlik için production ortamında daha güçlü bir şifre kullanın

## Sorun Giderme

Eğer pgvector kurulumunda sorun yaşarsanız:
- PostgreSQL sürümünüzün pgvector ile uyumlu olduğundan emin olun
- Visual Studio'nun C++ derleyici bileşenlerinin kurulu olduğunu kontrol edin
- PostgreSQL'in PATH'de olduğunu doğrulayın