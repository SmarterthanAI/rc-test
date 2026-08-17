# RC-99 Reading Comprehension Test Platform

A clean, minimalist, high-performance web assessment application built for practicing and mastering Reading Comprehension tests, with **RC-19 (Dinosaur Extinction & The Iridium Layer)** as the spotlight test, strictly using the official **RC-99 / Aristotle Prep Guide PDF** as the single source of truth.

---

## Key Features

### 1. User Authentication & Multi-User State
- **Sign In & Sign Up**: Individual accounts with email & password.
- **Session Continuity**: Auto-remembers user progress, test attempts, timestamps, scores, and accuracy metrics.
- **Quick Demo Logins**: One-click login for **Student Demo (Alex)** and **Admin Demo**.
- **Guest Explorer Mode**: Take tests immediately without prior registration.

### 2. RC-19 Spotlight Dashboard
- **Prominent Test Card**:
  - Live Status: `Not Started` | `In Progress (X%)` | `Completed`
  - Score Tracking: Best Score, Latest Score, Last Attempted Date
  - Contextual Actions: **Start Test**, **Resume Test**, **Retake Test**, and **Review Solutions**
- **Global Performance Metrics**: Total Tests Completed, Average Score %, Accuracy Rate %, and Total Time Spent.
- **Full Test Catalog**: Access to additional authentic RC tests extracted from the official PDF (RC-01, RC-02, RC-06, RC-07, RC-10, etc.).

### 3. Split-Screen Test Environment (Aptitude Test Simulator)
- **Dual-Pane Layout (Desktop)**:
  - **Left (Passage)**: Paragraph numbering (`¶1`, `¶2`...), font resizer (`A-`, `16px`, `A+`, `Reset`), word count indicator, comfortable reading typography.
  - **Right (Question)**: Clean question interface, single-select options (A through E), Clear Selection, Mark for Review flag.
- **Mobile Responsive**: Stacked layout with quick tab switcher between Passage and Question.
- **Real-Time Question Palette**: Color-coded states for Answered (Green), Unanswered (Gray), Marked for Review (Amber), Answered & Marked, and Current Question. Click any number to jump directly.
- **Live Timer**: Real-time timer with Pause and Resume modal.
- **Background Auto-Save**: Saves state continuously so no answers are ever lost on navigation or page refresh.

### 4. Submission & Scoring Engine
- **Submission Confirmation Modal**: Clear breakdown of Answered vs Unanswered vs Marked items before final submission.
- **Instant Evaluation**: Calculates score, accuracy percentage, time elapsed, and per-question pace.

### 5. Detailed Results Page & Scorecard
- **Visual Scorecard**: Circular score percentage meter, accuracy metric, total time, average pace per question.
- **Question-Wise Analysis Table**: Filter by `All`, `Correct`, `Incorrect`, and `Unattempted`.
- **Direct Solution Links**: One-click jump to the exact solution for any question.

### 6. PDF-Verbatim Solutions & Elimination Analysis
- **100% Faithful to PDF**:
  - Passage Topic and Scope definition.
  - Passage paragraph mapping.
  - Official explanation of why the correct option is right.
  - **Option-by-Option Elimination Analysis**: Explains specifically why each option is correct or flawed (*Out of Scope*, *Distortion*, *Opposite*, *Faulty Use of Detail*, *Extreme*).

### 7. Performance History ("My Progress")
- **Aggregate Analytics**: Best Score, Latest Score, Average Score, Best Accuracy, Total Time, Cumulative Question stats (Attempted, Correct, Incorrect, Unanswered).
- **Attempt History Log**: Chronological record of all attempts with the ability to review past scorecards and solution snapshots.

### 8. Admin Content Management System (CMS)
- **Manage Any Test**: Select RC-19 or any other test.
- **Edit Passage & Scope**: Update title, topic & scope, paragraph mapping, and full passage text.
- **Full Question CRUD**: Add questions, edit question text, options A-E, correct answer key, and detailed option analysis.
- **Reorder Questions**: Move questions up or down.
- **Reset to Default PDF Data**: One-click restoration of pristine PDF data.

---

## How to Run the Platform Locally

Serve the directory with any static server:

```bash
# Using Ruby (built into macOS)
cd /Users/atharvagrawal/.gemini/antigravity/scratch/rc-test-platform
ruby -rwebrick -e 'server = WEBrick::HTTPServer.new(Port: 8080, DocumentRoot: "."); trap("INT") { server.shutdown }; server.start'

# Or using Python 3
python3 -m http.server 8080

# Or using Node.js npx serve
npx serve .
```

Open your browser at:
**`http://localhost:8080`**

---

## Single Source of Truth Reference: RC-19
- **Passage**: *The Iridium Layer and Dinosaur Extinction (Gubbio, Italy, 1979)*
- **Questions**: 3 Questions on theories revolutionization, supporting evidence (Roman numerals I, II, III), and isotope analysis.
- **Keys**: Q1: **D**, Q2: **D**, Q3: **D**
- **Explanations**: Verbatim from Aristotle Prep RC-99 Guide.
