@echo off
setlocal enabledelayedexpansion

:: ===============================================
:: CONFIGURACOES INICIAIS (COM NOVAS VALIDACOES)
:: ===============================================
title Criador de Projeto React - By Weslley

:: Verificar dependências COM PAUSE
where git >nul || (echo ? Git não está instalado. Baixe em: https://git-scm.com & pause & exit /b)
where npm >nul || (echo ? Node.js não está instalado. Baixe em: https://nodejs.org & pause & exit /b)

:: ================================================
:: INFORMAÇÕES DO PROJETO
:: ================================================
:input_dir
set "project_dir="
set /p "project_dir=Digite o caminho para o projeto (Enter para '%cd%'): "
if "!project_dir!"=="" set "project_dir=%cd%"

:input_name
set "project_name="
set /p "project_name=Nome do projeto: "
if "!project_name!"=="" (
    echo ? Nome obrigatório!
    goto :input_name
)

set "final_path=!project_dir!\!project_name!"

:: ================================================
:: VALIDAÇÕES REFORÇADAS
:: ================================================
if exist "!final_path!\" (
    echo ? Diretório já existe!
    pause
    exit /b
)

:: ================================================
:: CRIAÇÃO DO PROJETO (COM TRATAMENTO DE ERROS)
:: ================================================
mkdir "!final_path!" 2>nul || (
    echo ? ERRO GRAVE: Falha ao criar pasta em "!final_path!"
    echo ? Possíveis causas:
    echo - Permissões insuficientes
    echo - Caminho inválido
    pause
    exit /b
)

:: Entrar no diretório COM VERIFICAÇÃO
cd /d "!final_path!" 2>nul || (
    echo ? ERRO GRAVE: Falha ao acessar diretório!
    pause
    exit /b
)

:: ================================================
:: ESCOLHA DO TEMPLATE (VERSÃO ESTÁVEL)
:: ================================================
:select_template
echo.
echo Escolha o tipo de inicialização:
echo 1 - Usar template GitHub
echo 2 - Criar via create-react-app (npx)
set /p "template=Digite o número (1/2): "

if "!template!"=="1" (
    echo ?? Clonando template do GitHub...
    git clone https://github.com/agr3w/react-template.git . || (
        echo ? ERRO: Falha ao clonar template!
        echo ? Soluções:
        echo - Verifique a URL do repositório
        echo - Confira sua conexão com a internet
        pause
        exit /b
    )
    rmdir /s /q .git 2>nul
) else if "!template!"=="2" (
    echo ?? Criando projeto com create-react-app...
    call npx create-react-app . --verbose || (
        echo ? ERRO: Falha no create-react-app!
        echo ? Soluções:
        echo - Execute como administrador
        echo - Tente 'npm cache clean --force'
        pause
        exit /b
    )
) else (
    goto :select_template
)

:: ================================================
:: INSTALAÇÃO DE DEPENDÊNCIAS (VERSÃO SEGURA)
:: ================================================
echo.
echo ?? ETAPA CRÍTICA: Instalando dependências...

:: React Router (com tratamento especial)
echo ?? Instalando react-router-dom...
call npm install react-router-dom --loglevel=verbose || (
    echo ? FALHA CATASTRÓFICA: React Router não instalado!
    pause
    exit /b
)

:: Dependências principais (com timeout)
echo ?? Instalando dependências do package.json...
timeout /t 3 >nul
call npm install --force --loglevel=verbose || (
    echo ? ERRO: Dependências principais falharam!
    echo ? Tente manualmente depois com:
    echo npm install --force
    pause
    exit /b
)

:: ================================================
:: BIBLIOTECAS ADICIONAIS (COM NOVA ESTRUTURA)
:: ================================================
:additional_libs
echo.
set "add_libs="
set /p "add_libs=Deseja instalar bibliotecas adicionais? (s/n): "

if /i "!add_libs!"=="s" (
    :lib_loop
    set "lib_name="
    set /p "lib_name=Digite o nome da biblioteca (ex: axios) ou 'sair' para finalizar: "
    
    if /i "!lib_name!"=="sair" (
        goto :lib_end
    ) else if not "!lib_name!"=="" (
        echo ?? Instalando !lib_name!...
        call npm install !lib_name! --loglevel=verbose || (
            echo ? Aviso: Falha ao instalar !lib_name! (pode ser normal)
            timeout /t 2 >nul
        )
        goto :lib_loop
    )
    :lib_end
)

:: ================================================
:: FINALIZAÇÃO À PROVA DE FALHAS
:: ================================================
echo.
echo ? TUDO PRONTO! Configuração finalizada com sucesso!
echo.
echo ?? Dicas importantes:
echo - Diretório: "!final_path!"
echo - Comando para iniciar: npm start
echo - Problemas? Tente: npm install --force

:start_prompt
echo.
set "start="
set /p "start=Iniciar servidor agora? (s/n): "
if /i "!start!"=="s" (
    echo ?? Iniciando servidor React...
    timeout /t 2 >nul
    code .
    npm start
) else if /i not "!start!"=="n" (
    goto :start_prompt
)

pause