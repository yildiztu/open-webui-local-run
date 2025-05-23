# Open WebUI Installation Guide for Windows

This README provides detailed instructions for setting up Open WebUI with PostgreSQL and pgvector on Windows systems.

## Prerequisites

Before starting, ensure you have:
- Windows 10 or 11
- Administrative privileges
- Internet connection

## Installing Python and pip

1. Download the latest Python installer from [python.org](https://www.python.org/downloads/)
2. Run the installer and check "Add Python to PATH"
3. Select "Install Now" for a standard installation or "Customize installation" for more options
4. Verify installation by opening Command Prompt and typing:
   ```
   python --version
   pip --version
   ```

## Required Environment Variables

Create a `.env` file in your project directory with the following content:

```
DATABASE_URL=postgresql://postgres:YOUR_PASSWORD_HERE@localhost:5432/postgres
WEBUI_AUTH=true
ENABLE_WEBSOCKET_SUPPORT=false
VECTOR_DB=pgvector
ENABLE_LOGIN_FORM=true
```

Replace `YOUR_PASSWORD_HERE` with your actual PostgreSQL password.

## Installing pgvector Extension

Run the following commands in Command Prompt (CMD):

```batch
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
set "PGROOT=C:\Program Files\PostgreSQL\16"
cd %TEMP%
git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git
cd pgvector
nmake /F Makefile.win
nmake /F Makefile.win install
```

These commands:
1. Load Visual Studio development environment
2. Set PostgreSQL directory path
3. Clone pgvector repository
4. Compile and install pgvector extension to PostgreSQL

Note: Adjust the paths if your Visual Studio or PostgreSQL are installed in different locations.

## Installing and Running Open WebUI

Execute these commands in PowerShell:

```powershell
# Create virtual environment
python -m venv openwebui-env

# Install Open WebUI
pip install open-webui

# Activate virtual environment
.\openwebui-env\Scripts\activate

# Load environment variables from .env file
Get-Content .env | ForEach-Object {
    $name, $value = $_.split('=')
    if ($name -and $value) {
        Set-Item -Path "env:$name" -Value $value
    }
}

# Run Open WebUI
open-webui serve
```

## Accessing the Interface

Once running, you can access Open WebUI by opening your web browser and navigating to:
```
http://localhost:8080
```

If this is your first time running Open WebUI, you'll need to create an admin account through the login form.

## Notes and Troubleshooting

### PostgreSQL Setup
- Ensure PostgreSQL is installed and running
- Verify the database credentials in your `.env` file match your PostgreSQL setup
- For security in production environments, use a strong password

### pgvector Installation Issues
- Make sure Visual Studio includes C++ development tools
- Verify your PostgreSQL version is compatible with pgvector
- Check that PostgreSQL bin directory is in your system PATH

### Connection Problems
- If you can't access localhost:8080, check if another application is using that port
- Verify that Open WebUI is running without errors in the terminal
- Check Windows Firewall settings if accessing from another device on the network

### Virtual Environment
- If you close your terminal, you'll need to reactivate the virtual environment before running Open WebUI again
- To deactivate the virtual environment when finished, simply type `deactivate`

## Updating Open WebUI

To update to the latest version:

```powershell
.\openwebui-env\Scripts\activate
pip install --upgrade open-webui
```

This guide should help you successfully install and run Open WebUI on your Windows system with PostgreSQL and pgvector support.