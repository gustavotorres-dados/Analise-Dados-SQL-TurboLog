# 🚚 Sistema de Gestão de Logística - TurboLog (SQL Server)

## 📌 Sobre o Projeto
Este projeto simula um ambiente real de logística, focado no controlo de entregas, monitorização de motoristas e análise de custos de frete. O objetivo principal foi aplicar conceitos avançados de SQL para transformar dados brutos em informações estratégicas de negócio.

## 📊 Diagrama do Banco de Dados (DER)
Abaixo está a representação visual das tabelas e seus relacionamentos:

![Diagrama Entidade-Relacionamento TurboLog](der_turbolog.png)

---

## 🛠️ Tecnologias Utilizadas
- **Base de Dados:** Microsoft SQL Server
- **Ferramenta:** SQL Server Management Studio (SSMS)
- **Linguagem:** T-SQL

## 🧠 Conceitos Aplicados
- **Modelagem de Dados:** Criação de tabelas com chaves primárias e estrangeiras (Integridade Referencial).
- **Análise Multitabela:** Uso de `INNER JOIN` e `LEFT JOIN` para consolidar dados de motoristas, regiões e fretes.
- **Lógica de Negócio:** Implementação de condicionais `CASE` para classificação automática de fretes.
- **Agregações:** Cálculo de métricas de desempenho com `SUM`, `AVG` e `COUNT`.
- **Segurança de Dados:** Utilização de `TRANSACTIONS` (`COMMIT`/`ROLLBACK`) para operações críticas.
- **Otimização:** Criação de Índices para performance e Stored Procedures para automação.

## 📈 Exemplo de Insight Gerado
Através da consulta de bonificação, o sistema identifica automaticamente quais motoristas atingiram o patamar de "Frete Pesado", facilitando o cálculo de comissões pela equipa de RH.
