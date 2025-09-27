# 💰 Controle de Gastos - Flutter App

Um aplicativo móvel completo para controle pessoal de gastos, desenvolvido em Flutter seguindo as melhores práticas de desenvolvimento e arquitetura modular.

## 📱 Sobre o Projeto

Este projeto foi desenvolvido como parte da disciplina de **Programação para Dispositivos Móveis 2**, implementando um sistema completo de controle financeiro pessoal com interface intuitiva e funcionalidades robustas.

## ✨ Funcionalidades

### 🔐 **Sistema de Login**
- Tela de autenticação com validação de campos
- Campos de email e senha com validação
- Feedback visual para erros de login
- Dados de teste disponíveis na interface

### 📊 **Gestão de Gastos**
- **Listar gastos** com interface em cards
- **Adicionar novos gastos** via formulário
- **Categorizar gastos** (Alimentação, Transporte, Lazer, etc.)
- **Excluir gastos** individualmente ou todos de uma vez
- **Cálculo automático** do total gasto
- **Formatação monetária** em Real brasileiro

### 💾 **Persistência Local**
- Dados salvos automaticamente no dispositivo
- **Gastos permanecem** entre sessões do app
- **Dados de exemplo** para demonstração inicial
- **Limpeza automática** no logout

### 🎨 **Interface e UX**
- Design **Material 3** moderno
- **Tema personalizado** com cores consistentes
- **Navegação intuitiva** entre telas
- **Ícones categorizados** para cada tipo de gasto
- **Confirmações** para ações destrutivas

## 🏗️ Arquitetura e Estrutura

### 📁 **Organização de Pastas**
```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── components/               # Widgets reutilizáveis
│   └── editor.dart          # Componente de campo de texto
├── models/                  # Modelos de dados
│   ├── gasto.dart          # Classe Gasto
│   └── gastos_manager.dart # Gerenciador de persistência
└── screens/                # Telas da aplicação
    ├── tela_login.dart     # Tela de autenticação
    ├── tela_inicial.dart   # Tela inicial/boas-vindas
    ├── lista_gastos.dart   # Lista de gastos
    └── formulario_gasto.dart # Formulário de cadastro
```

### 🧩 **Conceitos Aplicados**

| Conceito | Implementação | Arquivo |
|----------|---------------|---------|
| **StatelessWidget** | Componente Editor reutilizável | `components/editor.dart` |
| **StatefulWidget** | Telas com estado (lista, formulário) | `screens/*.dart` |
| **Navigator.push/pop** | Navegação entre telas | Todas as telas |
| **setState** | Atualização de interface | `lista_gastos.dart` |
| **TextEditingController** | Controle de campos de texto | `formulario_gasto.dart` |
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
  shared_preferences: ^2.2.2   # Persistência local de dados
```

### **Recursos do Flutter**
- **Material Design 3** - Sistema de design moderno
- **Navigator 2.0** - Sistema de navegação
- **SharedPreferences** - Armazenamento local
- **JSON Serialization** - Conversão de dados

## 🚀 Como Executar

### **Pré-requisitos**
1. **Flutter SDK 3.32.8** instalado
2. **Android Studio** ou **VS Code** com extensões Flutter/Dart
3. **Chrome** para execução web (recomendado para testes)

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
# Para web (recomendado)
flutter run -d chrome

# Para Windows
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
- Opção "Sobre" com informações do app
- Botão "Sair" no canto superior direito

### 3. **Lista de Gastos**
- Visualize gastos existentes (exemplos pré-carregados)
- Veja o total gasto no topo
- Use o botão "+" para adicionar novos gastos
- Menu "⋮" para limpar todos os gastos

### 4. **Adicionar Gasto**
- Preencha descrição, valor e categoria
- Validação automática dos campos
- Retorno automático para a lista

### 5. **Gerenciar Gastos**
- Clique no ícone 🗑️ para deletar gastos individuais
- Use "Limpar todos" para remover todos
- Logout limpa todos os dados

## 🎯 Resultados do Projeto

### **Conceitos Demonstrados**
✅ **Arquitetura modular** com separação de responsabilidades  
✅ **Navegação completa** entre múltiplas telas  
✅ **Gerenciamento de estado** com StatefulWidget  
✅ **Persistência de dados** local  
✅ **Validação de formulários** robusta  
✅ **Interface responsiva** e moderna  
✅ **Boas práticas** de desenvolvimento Flutter  

### **Funcionalidades Implementadas**
✅ Sistema de login com validação  
✅ CRUD completo de gastos  
✅ Categorização e ícones  
✅ Formatação monetária brasileira  
✅ Persistência entre sessões  
✅ Confirmações de segurança  
✅ Interface Material 3  

## 🔮 Possíveis Evoluções

### **Próximas Funcionalidades**
- 📊 **Relatórios e gráficos** de gastos por período
- 🔄 **Sincronização na nuvem** com Firebase
- 💱 **Múltiplas moedas** e conversão
- 📅 **Filtros por data** e categoria
- 🎯 **Metas de gastos** mensais
- 📱 **Notificações** push
- 🔍 **Busca** de gastos

### **Melhorias Técnicas**
- 🗄️ **Banco de dados local** (SQLite)
- 🌐 **API REST** para sincronização
- 🏗️ **Clean Architecture** completa
- 🧪 **Testes unitários** e de integração
- 📦 **CI/CD** pipeline

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
