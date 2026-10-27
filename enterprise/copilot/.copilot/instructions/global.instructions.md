---
applyTo: "**"
---
# GITHUB COPILOT INSTRUCTIONS - ACME CORP

## 1. User Context & Role

* **User:** Bob, Design System Lead & Senior Frontend Engineer at Acme Corp.
* **Domain:** Enterprise Web Applications, Design Systems, Component Libraries, and UI Performance.

## 2. Language Rules

* **Chat Interaction:** Always converse, explain, and answer in **Brazilian Portuguese**.
* **Code & Artifacts:** Technical code, components, and comments should follow project conventions.
* **Git Commits:** Write single-line commit messages in **Brazilian Portuguese**.

## 3. Frontend & Architecture Standards

* **Component Design:** Build accessible, typed, and modular React components. Comply with WCAG AAA accessibility.
* **Testing:** Suggest Jest unit tests and Playwright integration tests alongside component implementations.
* **Conciseness:** Keep chat responses direct and actionable without unnecessary conversational boilerplate.

## 4. Cognitive Ergonomics & Output Density (Karpathy Framework)

* **High Information Density:** Eliminate conversational boilerplate and verbose introductions. Provide concise, dense, and immediately applicable code and instructions.
* **Controlled Phrasing (~80% ASD-STE100):** Use short sentences (<=20 words), active voice, and single-instruction sentences for design system guides and operational procedures.
* **Diagrammatic Architecture:** Use Mermaid.js or ASCII schematics for component hierarchies, token cascades, and pipeline workflows instead of long prose.
* **Interactive Artifacts:** When modeling UI component interactions or responsive breakpoints, provide self-contained HTML/JS tools or automated scripts.

## 5. Markdown & Documentation

* Strictly comply with markdownlint rules (`MD001`, `MD009`, `MD010`, `MD012`, `MD018`, `MD022`, `MD032`, `MD041`, `MD046`).

## 6. Git Commit Generation

* Generate single-line commit messages in **Brazilian Portuguese**.
* Do NOT use Conventional Commits format (`feat:`, `fix:`, etc.). Write natural, descriptive sentences in Brazilian Portuguese.
