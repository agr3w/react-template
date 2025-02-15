```md
# 🚀 Template React Personalizado

Este é um **template inicial** para projetos React, criado para otimizar o desenvolvimento e evitar configurações repetitivas. Ele já vem com uma estrutura organizada e suporte para **importações absolutas**.

## 📂 Estrutura do Projeto

```
/meu-template-react
├── node_modules/          # Diretório de dependências (ignorado no Git)
├── public/
│   ├── index.html         # HTML já configurado
├── src/
│   ├── styles/
│   │   ├── reset.css      # Reset CSS customizado
│   ├── Router.jsx         # Configuração base para rotas
│   ├── index.js           # Ponto de entrada da aplicação
├── start.bat              # Script para automação da execução do projeto
├── .env                   # Configuração para importação absoluta
├── package.json           # Configurações e dependências
├── .gitignore             # Ignora arquivos desnecessários
```

---

## 🛠️ Funcionalidades

✅ **React Router** pré-configurado (`react-router-dom`)  
✅ **Importações Absolutas** (sem caminhos longos como `"../../components/Component"`)  
✅ **Estrutura inicial pronta para uso**  
✅ **Reset CSS incluso**  
✅ **Automação com `.bat` para iniciar o projeto rapidamente**  

---

## 🚀 Como Usar

### 🔹 Clonando o Template

```sh
git clone https://github.com/seu-usuario/seu-template-react.git nome-do-projeto
cd nome-do-projeto
```

### 🔹 Rodando o Projeto (Automático)

Para facilitar, um arquivo **`start.bat`** já automatiza a inicialização do projeto.  
Basta **clicar duas vezes no arquivo `start.bat`**, ou executá-lo via terminal:

```sh
start.bat
```

Esse script **instala as dependências automaticamente** e inicia o servidor.  

### 🔹 Rodando Manualmente (Caso Necessário)

Caso prefira rodar os comandos manualmente, utilize:

```sh
npm install
npm start
```

O projeto será aberto no navegador em **`http://localhost:3000/`**.

---

## ⚙️ Configuração de Importação Absoluta

Para facilitar os imports, este projeto utiliza um arquivo `.env` com:

```
NODE_PATH=src
```

Isso permite que você importe arquivos de forma mais simples:

```js
import Component from "./components/Component"; // Em vez de "../../components/Component"
import "./styles/reset.css"; // Em vez de "../../styles/reset.css"
```

---

## 📜 Licença

Este projeto é de uso livre. Sinta-se à vontade para modificar e utilizar da maneira que preferir! 😃

---
