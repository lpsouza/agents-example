# AI Agents Configuration Repository

> [!NOTE]
> **Educational & Fictional Template:** This repository is an educational
> template created for learning and demonstration purposes. The persona
> **Bob**, his family, his pets, and the company **Acme Corp** are completely
> fictional examples designed to showcase how to structure and maintain
> production-grade AI agent dotfiles.

This repository provides a modular, battle-tested framework for managing
global AI agent configurations, system prompts, and steering rules across
multiple profiles (**Personal** and **Enterprise**) and diverse tools
(**Google Antigravity / Gemini CLI**, **GitHub Copilot**, and **AWS Kiro**).

## Overview & Concept

When working with modern AI coding assistants, maintaining consistent
behavioral instructions, security guardrails, coding styles, and context
across different machines and tools can become cumbersome.

This repository demonstrates how to manage these configurations as **dotfiles**
using symbolic links:

* **Separation of Contexts:** Maintain different personas and rules for personal
  side projects versus corporate work.
* **Single Source of Truth:** Keep instructions in a single version-controlled
  repository.
* **Automated Symlinking:** Use **GNU Stow** on Linux/macOS and **PowerShell**
  on Windows to deploy rules directly into each tool's expected configuration
  directory.

## Why Configure in the User Directory (~) Instead of Repositories?

A frequent question when organizing AI agent instructions is: *why not place
instruction files directly inside each project repository?*

While project-level instructions (such as `AGENTS.md` or
`.github/copilot-instructions.md`) have an important place, keeping your
baseline configurations in your user home directory (`~` or `$HOME`) offers
distinct architectural advantages:

* **Universal Consistency Across All Codebases:**
  Home directory rules apply everywhere by default. Whether you are hacking on a
  quick scratch script, contributing to an open-source library, or auditing a
  client codebase, your AI assistant immediately inherits your communication
  style, security awareness, and preferred engineering practices.

* **Zero Repository Pollution & Team Neutrality:**
  Your personal preferences (such as chat language, explanation depth, or
  editor quirks) do not belong in a shared Git repository. Committing personal
  rules to team projects creates merge churn and can inadvertently impose your
  preferences on teammates who have different workflows.

* **Clean Separation of Concerns:**
  * **User Home (`~`):** Defines *who you are*—your role, language protocols,
    personal security baselines, and individual tool integrations (MCP servers).
  * **Project Root (`./`):** Defines *what the project is*—architecture
    decisions, local build commands, testing setups, and team conventions.
  Both layers complement each other seamlessly: global rules set the baseline,
  while project rules provide domain-specific context.

* **Frictionless Profile Switching:**
  Switching between personal side projects and enterprise work is a single
  command (`./scripts/setup.sh enterprise`). Your entire toolchain is rewired
  instantaneously via symlinks without altering or dirtying a single Git
  repository on your disk.

* **Privacy & Secret Isolation:**
  Keeping personal routines, working hours, and machine-specific Model Context
  Protocol (MCP) endpoints within `~` eliminates the risk of accidentally
  committing private information or proprietary team workflows to public
  repositories.

## Meet the Persona: Bob

To keep this repository concrete and educational rather than abstract,
configurations are modeled after **Bob**:

* **Personal Profile:** Bob is a Senior Frontend and Mobile Engineer living
  in São Paulo/SP, Brazil, with his wife Alice and cat Max. In his personal
  time, he develops open-source UI libraries, explores mobile animations, brews
  specialty coffee, and practices urban cycling.
* **Enterprise Profile:** Bob serves as Design System Lead and Senior Frontend
  Engineer at **Acme Corp**, managing design token architecture, component
  governance (Storybook, Playwright), and corporate workflows via Model Context
  Protocol (MCP) servers (Figma MCP, Jira MCP, and Sentry MCP).

> [!TIP]
> You can easily fork or clone this repository and replace Bob's details with
> your own personal info, preferred tech stack, and company guidelines.

## Repository Structure

```text
agents/
├── copilot/
│   └── .copilot/
│       └── instructions/
│           └── global.instructions.md  # Personal rules for GitHub Copilot
├── gemini/
│   └── .gemini/
│       └── GEMINI.md                   # Personal rules for Antigravity / Gemini CLI
├── enterprise/
│   ├── copilot/
│   │   └── .copilot/
│   │       └── instructions/
│   │           └── global.instructions.md  # Acme Corp rules for GitHub Copilot
│   ├── gemini/
│   │   └── .gemini/
│   │       └── GEMINI.md               # Acme Corp rules for Antigravity / Gemini CLI
│   └── kiro/
│       └── .kiro/
│           └── steering/
│               └── global.md           # Acme Corp steering rules for AWS Kiro
├── scripts/
│   ├── setup.sh                        # Automated setup for Linux / macOS (GNU Stow)
│   └── setup.ps1                       # Automated setup for Windows PowerShell
├── .gitignore                          # Standard ignore patterns
├── .markdownlint.json                  # Markdown linter configuration
├── LICENSE                             # MIT License
└── README.md                           # Documentation & usage guide
```

## Supported Tools and Discovery Paths

Each AI tool discovers global rules from standardized locations in the user's
home directory (`~` or `$HOME`):

* **Google Antigravity / Gemini CLI:** Discovered at `~/.gemini/GEMINI.md`.
  Used for workspace rules, operational autonomy, and coding standards.
* **GitHub Copilot:** Discovered at
  `~/.copilot/instructions/global.instructions.md`. Used for universal
  instructions applied across repositories and chat sessions.
* **AWS Kiro:** Discovered at `~/.kiro/steering/global.md`.
  Used for enterprise steering rules and spec-driven development guidelines.

## Quick Start Setup

### Linux / macOS

Prerequisites: Install **GNU Stow** via your package manager:

```bash
# Ubuntu / Debian
sudo apt install stow

# macOS (Homebrew)
brew install stow

# Fedora / Red Hat
sudo dnf install stow
```

Run the automated setup script specifying your profile (`personal` or
`enterprise`):

```bash
# Set up Personal profile (default)
./scripts/setup.sh personal

# Set up Enterprise profile (Acme Corp: Gemini, Copilot, and Kiro)
./scripts/setup.sh enterprise

# View help and available options
./scripts/setup.sh --help
```

### Windows (PowerShell)

Run the PowerShell script to create directory junctions and symbolic links:

```powershell
# Set up Personal profile (default)
.\scripts\setup.ps1 -Profile personal

# Set up Enterprise profile (Acme Corp: Gemini, Copilot, and Kiro)
.\scripts\setup.ps1 -Profile enterprise

# Force overwrite existing symlinks/targets
.\scripts\setup.ps1 -Profile enterprise -Force
```

## How to Customize for Yourself

1. **Clone the Repository:**

   ```bash
   git clone <your-repo-url> ~/agents
   cd ~/agents
   ```

2. **Customize Personal Rules:**
   * Edit `gemini/.gemini/GEMINI.md`: Update your name, role, tech stack, and
     optional daily context (e.g. city, pets, hobbies).
   * Edit `copilot/.copilot/instructions/global.instructions.md`: Adjust coding
     style preferences and language requirements.

3. **Customize Enterprise Rules:**
   * Edit `enterprise/gemini/.gemini/GEMINI.md`: Replace "Acme Corp" with your
     organization name, specify your team's MCP servers (e.g., Figma, Jira,
     GitHub, or telemetry MCPs), and set company commit standards.
   * Edit `enterprise/copilot/.copilot/instructions/global.instructions.md` and
     `enterprise/kiro/.kiro/steering/global.md`: Update enterprise architecture
     and governance standards.

4. **Deploy:**
   Run `./scripts/setup.sh personal` or `./scripts/setup.sh enterprise`
   depending on which environment you are setting up.

## Engineering Best Practices & Security

* **Security First:** Never commit credentials, private API keys, or personal
  secrets to this repository. Use environment variables or secret managers.
* **Markdownlint Compliance:** Ensure all `.md` files adhere to standard
  markdownlint rules (`MD001` through `MD046`).
* **Modular Configuration:** Keep global instructions high-level and
  domain-focused; use repository-level instructions
  (`.github/copilot-instructions.md`, `AGENTS.md`, `.kiro/`) for
  project-specific rules.

## License

This repository is licensed under the [MIT License](LICENSE).
