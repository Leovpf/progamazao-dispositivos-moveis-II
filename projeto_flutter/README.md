# 💰 Controle de Gastos - Flutter App

Um aplicativo móvel completo para controle pessoal de gastos, desenvolvido em Flutter seguindo as melhores práticas de desenvolvimento, arquitetura modular e persistência de dados real.

## 📱 Sobre o Projeto

Este projeto foi desenvolvido como parte da disciplina de **Programação para Dispositivos Móveis 2**, implementando um sistema completo de controle financeiro pessoal com interface intuitiva, CRUD completo e persistência robusta utilizando SQLite.

## ✨ Funcionalidades

### 🔐 **Sistema de Login**
- Tela de autenticação com validação de campos
- Campos de email e senha com validação
- Feedback visual para erros de login
- Dados de teste disponíveis na interface

### 📊 **Gestão de Gastos (CRUD)**
- **Listar gastos** com interface em cards
- **Adicionar novos gastos** via formulário
- **Editar gastos existentes** (atualização de valores e categorias)
- **Categorizar gastos** (Alimentação, Transporte, Lazer, etc.)
- **Excluir gastos** individualmente ou todos de uma vez
- **Cálculo automático** do total gasto
- **Formatação monetária** em Real brasileiro

### 💾 **Persistência Local (SQLite)**
- Dados salvos automaticamente em banco de dados local
- **Persistência total** (dados permanecem mesmo após fechar o app ou fazer logout)
- **Tela de Status** para verificação técnica das tabelas e registros
- **Dados de exemplo** para demonstração inicial

### 🎨 **Interface e UX**
- Design **Material 3** moderno
- **Tema personalizado** com cores consistentes (Seed Color)
- **Navegação intuitiva** entre telas
- **Ícones categorizados** para cada tipo de gasto
- **Confirmações** para ações destrutivas (Excluir)

## 🏗️ Arquitetura e Estrutura

### 📁 **Organização de Pastas**
```
lib/
├── main.dart                 # Ponto de entrada e Tema Global
├── components/               # Widgets reutilizáveis
│   └── editor.dart           # Componente de campo de texto
├── database/                 # Camada de Persistência
│   ├── app_database.dart     # Conexão Singleton com SQLite
│   └── dao/
│       └── gastos_dao.dart   # Data Access Object (CRUD)
├── models/                   # Modelos de dados
│   └── gasto.dart            # Entidade Gasto
└── screens/                  # Telas da aplicação
    ├── tela_login.dart       # Tela de autenticação
    ├── tela_inicial.dart     # Tela inicial/boas-vindas
    ├── lista_gastos.dart     # Lista de gastos (FutureBuilder)
    ├── formulario_gasto.dart # Formulário de cadastro/edição
    └── status_database/      # Tela de verificação técnica
        └── status.dart
```

### 🧩 **Conceitos Aplicados**

| Conceito | Implementação | Arquivo/Local |
|----------|---------------|---------|
| **StatelessWidget** | Componente Editor reutilizável | `components/editor.dart` |
| **StatefulWidget** | Gerenciamento de estado das telas | `screens/*.dart` |
| **DAO & SQLite** | Persistência e manipulação SQL | `database/dao/gastos_dao.dart` |
| **FutureBuilder** | Carregamento assíncrono de dados | `screens/lista_gastos.dart` |
| **Navigator.push/pop** | Navegação entre telas | Todas as telas |
| **setState** | Atualização dinâmica de interface | `lista_gastos.dart` |
| **ThemeData** | Tema global Material 3 | `main.dart` |
| **Estrutura Modular** | Separação por responsabilidades | Todo o projeto |

## 🛠️ Tecnologias Utilizadas

### **Framework e Linguagem**
- **Flutter 3.32.8** - Framework de desenvolvimento multiplataforma
- **Dart** - Linguagem de programação

### **Dependências**
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8      # Ícones iOS
  intl: ^0.19.0                # Formatação de valores e datas
  shared_preferences: ^2.2.2   # Preferências simples
  sqflite: ^2.2.8              # Banco de dados SQLite
  path: ^1.8.4                 # Auxiliar para caminhos de arquivo
  sqflite_common_ffi: ^2.3.6   # Suporte SQLite para Desktop
```

### **Recursos do Flutter**
- **Material Design 3** - Sistema de design moderno
- **SQLite (sqflite)** - Banco de dados relacional local
- **Navigator 2.0** - Sistema de navegação
- **Asynchronous Programming** - Futures e Async/Await

## 🚀 Como Executar

### **Pré-requisitos**
1. **Flutter SDK 3.32.8** instalado
2. **Android Studio** ou **VS Code** com extensões Flutter/Dart

### **Instalação e Execução**

1. **Clone ou baixe o projeto**
```bash
cd projeto_flutter
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o aplicativo**
```bash
# Para web (Requer configuração FFI ou usar mobile)
flutter run -d chrome

# Para Windows/Linux/Mac (Suporte via sqflite_common_ffi)
flutter run -d windows

# Para Android (emulador necessário)
flutter run -d android
```

### **Dados de Teste**
Para acessar o aplicativo, use:
- **Email:** `usuario@teste.com`
- **Senha:** `123456`

## 📋 Fluxo de Uso

### 1. **Login**
- Abra o app e insira as credenciais de teste
- Validação automática dos campos

### 2. **Tela Inicial**
- Boas-vindas com botão para acessar gastos
- Opção "Status do Banco" para verificação técnica
- Opção "Sobre" com informações do app

### 3. **Lista de Gastos**
- Visualize gastos salvos no banco de dados
- Veja o total gasto atualizado no topo
- Menu "⋮" para limpar todos os gastos (Reset)

### 4. **Adicionar ou Editar**
- Use o botão "+" para adicionar novo gasto
- **Toque em um card** existente para editar seus dados
- Validação automática dos campos

### 5. **Gerenciar Gastos**
- Clique no ícone 🗑️ para deletar gastos individuais
- Dados permanecem salvos mesmo após sair do app

## 🎯 Resultados do Projeto

### **Conceitos Demonstrados**
✅ **Arquitetura modular** com separação de responsabilidades  
✅ **Persistência completa** com SQLite e padrão DAO  
✅ **CRUD Funcional** (Criar, Ler, Atualizar, Deletar)  
✅ **Navegação completa** entre múltiplas telas  
✅ **Gerenciamento de estado** com StatefulWidget e setState  
✅ **Carregamento Assíncrono** com FutureBuilder  
✅ **Interface Material 3** com Tema Global  

### **Funcionalidades Implementadas**
✅ Sistema de login com validação  
✅ Categorização e ícones dinâmicos  
✅ Formatação monetária brasileira  
✅ Persistência robusta entre sessões  
✅ Confirmações de segurança  
✅ Tela de diagnóstico do banco de dados

## 🔮 Possíveis Evoluções

### **Próximas Funcionalidades**
- 📊 **Relatórios e gráficos** de gastos por período
- 🔄 **Sincronização na nuvem** com Firebase
- 💱 **Múltiplas moedas** e conversão
- 📅 **Filtros por data** e categoria
- 🎯 **Metas de gastos** mensais

## 👨‍💻 Desenvolvimento

**Desenvolvido por:** Leonardo Ferreira; Frederico Barbosa; Rafael Victor; Jorge Patrocinio; Guilherme Souza
**Disciplina:** Programação para Dispositivos Móveis 2  
**Flutter Version:** 3.32.8  
**Data:** Setembro 2025  

---

### 📄 Licença
Este projeto foi desenvolvido para fins educacionais como parte do curso de desenvolvimento móvel.

### 🤝 Contribuições
Para sugestões e melhorias, sinta-se à vontade para criar issues ou pull requests.

---

**⭐ Se este projeto foi útil para você, não esqueça de dar uma estrela!**