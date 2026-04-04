# Obsidian Note Generator

## Description
会話で調べたことや学んだことをObsidian用の構造化されたMarkdownノートとして出力するスキル

## Usage
```
/obsidian-note-generator [note-type] [title]
```

### Parameters
- `note-type`: Optional. `investigation`, `learning`, `project`, `reference` (default: `investigation`)
- `title`: Optional. ノートのタイトル (default: 現在の日時)

### Examples
```
/obsidian-note-generator investigation "Vite-Plus Architecture Analysis"
/obsidian-note-generator learning "Rust Monorepo Patterns"
/obsidian-note-generator
```

## Implementation

会話の内容を分析して以下の構造でObsidianノートを生成する：

### Investigation Note Template
```markdown
# {title}

**Created**: {timestamp}
**Tags**: #investigation #coding

## 🎯 Investigation Goal
{what was being investigated}

## 🏗️ Project/System Overview
{high-level architecture and structure}

## 🔍 Key Findings

### Code Structure
{directory structure, important files, entry points}

### Technical Details
{implementation details, patterns, technologies used}

### Important Files & Functions
- `{file_path}:{line}` - {description}
- [[{filename}]] - {purpose}

## 💡 Insights & Learnings
{what was learned, patterns discovered, best practices}

## ❓ Questions & TODOs
- [ ] {question or todo item}

## 🔗 References
{links to documentation, related files, etc}

## 📝 Notes
{additional context, thoughts, related concepts}
```

### Learning Note Template
```markdown
# {title}

**Created**: {timestamp}
**Tags**: #learning #programming

## 📚 Topic
{what was learned about}

## 🎯 Key Concepts
{main concepts covered}

## 💻 Code Examples
{relevant code snippets with explanations}

## 🔑 Takeaways
{important points to remember}

## 🔗 See Also
{related topics, files, concepts}
```

### Project Note Template
```markdown
# {title}

**Created**: {timestamp}
**Tags**: #project #overview

## 📋 Project Summary
{brief description of the project}

## 🏗️ Architecture
{system design, main components}

## 📁 Directory Structure
{key directories and their purposes}

## 🚀 Getting Started
{how to run, build, test}

## 🔧 Key Technologies
{languages, frameworks, tools used}

## 📖 Documentation
{links to docs, READMEs, etc}
```

## Processing Rules

1. **Extract Key Information**:
   - File paths → Convert to `[[filename]]` links where appropriate
   - Function/method names → Format with backticks
   - Code snippets → Wrap in proper code blocks
   - URLs → Convert to proper markdown links

2. **Organize Content**:
   - Group related findings together
   - Prioritize most important discoveries
   - Add appropriate tags based on content

3. **Generate Cross-References**:
   - Create `[[links]]` for referenceable concepts
   - Add relevant tags like #rust, #javascript, #architecture
   - Include file path references with line numbers

4. **Format for Obsidian**:
   - Use Obsidian-compatible markdown
   - Include metadata (tags, dates)
   - Structure with clear headings and sections

## Output Format
The skill outputs the complete markdown content that can be saved directly to an Obsidian vault, with proper formatting, links, and metadata.