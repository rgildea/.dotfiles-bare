# CLAUDE INSTRUCTIONS

### NOTE

- **CLAUDE.md** (this file) lives in the user's home director and contains general instructions for Claude. It is part of the dotfiles bare repository.
- **README.md** contains general instructions for working with the dotfiles.
- **DEVELOPING.md** contains AGENT-friendly instructions for working on changes to the dotfiles.

## VERY IMPORTANT

- Be simple. Approach tasks in a simple, incremental manner.
- Work incrementally, ALWAYS. Small, simple steps. Validate and check each increment before moving on.
- Ask clarifying questions when in doubt.

## Coding standards

- No over-engineering. No unnecessary defensive programming. No extra features. Keep it simple.
- Use latest stable versions of libraries and tools.
- Use latest idiomatic approaches.
- No emojis anywhere. Keep READMEs minimal.
- Favor clear, precise, and concise docstring comments. Be sparing with comments outside of docstrings.
- Favor short modules, short methods and functions. Use clear naming conventions.

## Development process

- Do not guess or make assumptions about the contextscope, size, or complexity of a feature.
- Use the feature-dev plugin/tool for feature development.
- ALWAYS write tests to cover new production code.
- Use code-review tool to review changes before merging.
- Research, hypothesize, and then identify root causes of issues with evidence before fixing — do not guess.
- PROVE your fixes work before declaring them a success.

## Language-specific Guidelines

- Use uv for python package management. Always run `uv run xxx` not `python3 xxx`. Always use `uv add xxx` never `pip install xxx`.
- Use TypeScript when possible. Do not use JavaScript. Always use TypeScript for type safety and modern language features.
