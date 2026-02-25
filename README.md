## **APPNOTICE**

 Um aplicativo simples de notícias com o objetivo principal de ampliar o conhecimento prático em consumo e integração de APIs, aprimorar conceitos de UX (User Experience), aplicar boas práticas de organização e melhoria de código, e implementar testes para garantir qualidade e confiabilidade.
O projeto servirá como um ambiente de aprendizado contínuo, permitindo experimentar arquiteturas, padrões de desenvolvimento, versionamento de código e estratégias de testes, ao mesmo tempo em que entrega uma interface intuitiva e funcional para acesso a notícias e opensorce.

    AppNotice/
    ├── AppNoticeApp.swift        # Entry point da aplicação (@main)
    │
    ├── View/                     # Camada de Interface (UI - SwiftUI)
    │   ├── HomeView.swift
    │   ├── NoticeDetailView.swift
    │   └── Components/
    │
    ├── ViewModel/                # Camada de Lógica de Apresentação (MVVM)
    │   ├── HomeViewModel.swift
    │   └── NoticeViewModel.swift
    │
    ├── Models/                   # Estruturas de Dados / Entidades
    │   ├── Notice.swift
    │   └── User.swift
    │
    └── Services/                 # Camada de Serviços / Infraestrutura
        ├── APIClient.swift

## Padrão Arquitetural
  MVVM (Model-View-ViewModel)
        
  🔄 Fluxo de Dados
        User Interaction
              ↓
        View
              ↓
        ViewModel
              ↓
        Service
              ↓
        API / Data Source
              ↓
        ViewModel (processa estado)
              ↓
        View (renderiza atualização)




    
📦 Responsabilidade de Cada Camada
        
  🖥 View
        
  Renderiza interface
   Observa estado do ViewModel
   Não contém regra de negócio

 🧠 ViewModel
        
Controla estado da tela
Executa lógica de apresentação
  Comunica com Services
 Trata erros e loading
  
   📦 Model
        
  Representam entidades da aplicação
   Estruturas struct
  Conformidade com Codable, Identifiable, etc.
  
  🔌 Services
  Comunicação com API
  Persistência local
  Regras externas
        
    
    
