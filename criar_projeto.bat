@echo off
setlocal enabledelayedexpansion

:: ===============================================
:: CONFIGURACOES INICIAIS (COM NOVAS VALIDACOES)
:: ===============================================
title Criador de Projeto React - By Weslley

:: Verificar depend�ncias COM PAUSE
where git >nul || (echo ? Git n�o est� instalado. Baixe em: https://git-scm.com & pause & exit /b)
where npm >nul || (echo ? Node.js n�o est� instalado. Baixe em: https://nodejs.org & pause & exit /b)

:: ================================================
:: INFORMA��ES DO PROJETO
:: ================================================
:input_dir
set "project_dir="
set /p "project_dir=Digite o caminho para o projeto (Enter para '%cd%'): "
if "!project_dir!"=="" set "project_dir=%cd%"

:input_name
set "project_name="
set /p "project_name=Nome do projeto: "
if "!project_name!"=="" (
    echo ? Nome obrigat�rio!
    goto :input_name
)

set "final_path=!project_dir!\!project_name!"

:: ================================================
:: VALIDA��ES REFOR�ADAS
:: ================================================
if exist "!final_path!\" (
    echo ? Diret�rio j� existe!
    pause
    exit /b
)

:: ================================================
:: CRIA��O DO PROJETO (COM TRATAMENTO DE ERROS)
:: ================================================
mkdir "!final_path!" 2>nul || (
    echo ? ERRO GRAVE: Falha ao criar pasta em "!final_path!"
    echo ? Poss�veis causas:
    echo - Permiss�es insuficientes
    echo - Caminho inv�lido
    pause
    exit /b
)

:: Entrar no diret�rio COM VERIFICA��O
cd /d "!final_path!" 2>nul || (
    echo ? ERRO GRAVE: Falha ao acessar diret�rio!
    pause
    exit /b
)

:: ================================================
:: ESCOLHA DO TEMPLATE (VERS�O EST�VEL)
:: ================================================
:select_template
echo.
echo Escolha o tipo de inicializa��o:
echo 1 - Usar template GitHub
echo 2 - Criar via create-react-app (npx)
set /p "template=Digite o n�mero (1/2): "

if "!template!"=="1" (
    echo ?? Clonando template do GitHub...
    git clone https://github.com/agr3w/react-template.git . || (
        echo ? ERRO: Falha ao clonar template!
        echo ? Solu��es:
        echo - Verifique a URL do reposit�rio
        echo - Confira sua conex�o com a internet
        pause
        exit /b
    )
    rmdir /s /q .git 2>nul
) else if "!template!"=="2" (
    echo ?? Criando projeto com create-react-app...
    call npx create-react-app . --verbose || (
        echo ? ERRO: Falha no create-react-app!
        echo ? Solu��es:
        echo - Execute como administrador
        echo - Tente 'npm cache clean --force'
        pause
        exit /b
    )
) else (
    goto :select_template
)

:: ================================================
:: INSTALA��O DE DEPEND�NCIAS (VERS�O SEGURA)
:: ================================================
echo.
echo ?? ETAPA CR�TICA: Instalando depend�ncias...

:: React Router (com tratamento especial)
echo ?? Instalando react-router-dom...
call npm install react-router-dom --loglevel=verbose || (
    echo ? FALHA CATASTR�FICA: React Router n�o instalado!
    pause
    exit /b
)

:: Depend�ncias principais (com timeout)
echo ?? Instalando depend�ncias do package.json...
timeout /t 3 >nul
call npm install --force --loglevel=verbose || (
    echo ? ERRO: Depend�ncias principais falharam!
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
:: FINALIZA��O � PROVA DE FALHAS
:: ================================================
echo.
echo ? TUDO PRONTO! Configura��o finalizada com sucesso!
echo.
echo ?? Dicas importantes:
echo - Diret�rio: "!final_path!"
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