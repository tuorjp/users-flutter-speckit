<!--
Sync Impact Report:
- Version change: Initial -> 1.0.0
- List of modified principles:
  - I. Spec-First Development (Added)
  - II. Premium Visual Experience (Added)
  - III. Test-Driven Development (Added)
  - IV. Component-Based Architecture (Added)
  - V. Clean Architecture & Patterns (Added)
- Added sections:
  - Technical Constraints
  - Development Workflow
- Templates alignment:
  - .specify/templates/plan-template.md (✅ Checked)
  - .specify/templates/spec-template.md (✅ Checked)
  - .specify/templates/tasks-template.md (✅ Checked)
-->

# Users App Constitution

## Core Principles

### I. Spec-First Development
No implementation without an approved specification and implementation plan. This ensures all team members align on requirements and technical approach before a single line of implementation code is written.

### II. Premium Visual Experience
Interfaces must be vibrant, modern, and high-fidelity. We prioritize user delight through curated color palettes (HSL), glassmorphism, smooth gradients, and subtle micro-animations. A basic MVP is not enough; the design must WOW the user.

### III. Test-Driven Development (NON-NEGOTIABLE)
Logic must be verified via automated tests (unit/widget/integration) that are written before the implementation. Tests must fail first (Red phase) to prove they are testing the right thing, then pass (Green phase), and finally be refactored.

### IV. Component-Based Architecture
UI and logic must be modular, reusable, and self-contained. Avoid monolithic widgets or services. Each component should have a single responsibility and be independently testable.

### V. Clean Architecture & Patterns
Follow standard Flutter/Dart best practices. Maintain a clear separation of concerns between data, domain, and presentation layers. Use consistent state management patterns (e.g., BLoC or Provider) across the entire application.

## Technical Constraints

- **Platform**: Flutter ^3.11.0 (Dart ^3.0)
- **Design System**: Material 3 enabled, custom design tokens for brand consistency.
- **Dependencies**: Use `pubspec.yaml` for dependency management; avoid ad-hoc library additions.

## Development Workflow

1. **Specify**: Create feature spec with `/speckit.specify`.
2. **Plan**: Generate implementation plan with `/speckit.plan`.
3. **Tasks**: Break down implementation into actionable items with `/speckit.tasks`.
4. **Implement**: Execute tasks following the TDD cycle with `/speckit.implement`.
5. **Verify**: Run full test suite and manual QA before merging.

## Governance

This constitution supersedes all other informal practices. Amendments require a version bump and a Sync Impact Report documenting the changes across all dependent templates and documentation.

**Version**: 1.0.0 | **Ratified**: 2026-03-27 | **Last Amended**: 2026-03-27
