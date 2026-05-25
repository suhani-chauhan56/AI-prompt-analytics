# 📊 AI Prompt Analytics System
### *"Google Analytics — but for AI Prompts"*

> **Built with SQL | MySQL Workbench | CSV Dataset**

---

## 🌟 The Story

Imagine you've just joined an AI company — like OpenAI, Anthropic, or Google DeepMind.

Every single day:
- 🧑‍💻 Thousands of users fire prompts at the AI
- ⚡ The AI responds in milliseconds
- ✅ Some answers are brilliant
- ❌ Some answers are completely wrong
- 🐢 Some responses are painfully slow

But here's the scary part — **nobody is watching the data.**

No one knows which prompts fail. No one tracks where the AI hallucinates. No one measures how efficient the responses are.

So you decide to build something.

You call it: **AI Prompt Analytics System** 🚀

A lightweight, SQL-powered engine that does for AI prompts what Google Analytics does for websites — **tracks, measures, and reveals the truth behind every interaction.**

---

## ❓ Problem Statement

In today's AI-driven world, millions of users interact with AI systems daily. Yet there is **no structured way to evaluate prompt performance**.

Key questions left unanswered:

| ❓ Question | 📊 Why It Matters |
|---|---|
| Which prompts perform well? | Helps users write better prompts |
| Where does AI give wrong answers? | Improves AI safety & trust |
| How many tokens are used per prompt? | Optimizes cost & efficiency |
| Which categories are most effective? | Guides AI training priorities |
| Who are the power users? | Identifies usage patterns |

👉 This project **fills that gap** using pure SQL analytics.

---

## 🎯 Project Objective

Build a **SQL-based analytics system** that extracts meaningful insights from raw AI prompt data:

- 📈 Measure **prompt success rate**
- 🧠 Detect **AI hallucinations**
- ⚡ Analyze **token usage efficiency**
- 🌟 Track **response quality trends**
- 📂 Compare **category-wise performance**
- 👤 Understand **user behavior patterns**

---

## 🏗️ Tech Stack

| Tool | Purpose |
|---|---|
| 🐬 **MySQL Workbench** | Database engine & query execution |
| 📁 **SQL** | Data storage, analysis & transformation |
| 📊 **CSV Dataset** | Source data (500 structured prompt records) |
| 🧠 **Analytical SQL** | Aggregations, KPIs, views, scoring |

---

## 📦 Dataset Overview

The dataset contains **500 records** of AI prompt interactions with the following structure:

```sql
CREATE DATABASE ai_prompt_analytics;
USE ai_prompt_analytics;

CREATE TABLE prompts (
    prompt_id        INT PRIMARY KEY,       -- Unique prompt ID
    user_id          INT,                   -- User who sent the prompt
    prompt_text      TEXT,                  -- The actual prompt
    category         VARCHAR(50),           -- code / education / knowledge
    tokens           INT,                   -- Prompt length in tokens
    response_quality INT,                   -- Quality score (1 = bad, 5 = excellent)
    success_flag     INT,                   -- 1 = successful response, 0 = failed
    hallucination_flag INT,                 -- 1 = AI gave incorrect answer
    response_time_ms INT                    -- How fast AI responded (ms)
);
```

### 📌 Categories Explained:
- 🧑‍💻 **code** — Programming-related prompts (Python, SQL, APIs, etc.)
- 📘 **education** — Conceptual learning (ML, AI, databases, etc.)
- 🌍 **knowledge** — General knowledge (history, current events, etc.)

---

## 🔄 How the Project Works

```
📥 Step 1: Load CSV Data into MySQL
        ↓
🗄️  Step 2: Store in relational table `prompts`
        ↓
🔍 Step 3: Run SQL queries for analysis
        ↓
📊 Step 4: Extract insights & KPIs
        ↓
🚀 Step 5: Present findings & recommendations
```

---

## 🔍 SQL Queries Used

### 📌 1. Overall Success Rate
*How often does the AI give a correct, useful response?*
```sql
SELECT 
  ROUND((SUM(success_flag) / COUNT(*)) * 100, 2) AS success_rate_pct
FROM prompts;
```

---

### 📌 2. Hallucination Rate
*How often does the AI confidently give wrong answers?*
```sql
SELECT 
  ROUND((SUM(hallucination_flag) / COUNT(*)) * 100, 2) AS hallucination_rate_pct
FROM prompts;
```

---

### 📌 3. Category-wise Performance
*Which type of prompt gets the best results?*
```sql
SELECT 
  category,
  COUNT(*)                        AS total_prompts,
  ROUND(AVG(response_quality), 2) AS avg_quality,
  SUM(success_flag)               AS successful_responses,
  SUM(hallucination_flag)         AS hallucinations
FROM prompts
GROUP BY category
ORDER BY avg_quality DESC;
```

---

### 📌 4. Most Used Categories
*What are users asking about most?*
```sql
SELECT 
  category, 
  COUNT(*) AS usage_count
FROM prompts
GROUP BY category
ORDER BY usage_count DESC;
```

---

### 📌 5. Prompt Efficiency Score
*Which prompts deliver quality per token used?*
```sql
SELECT 
  prompt_id,
  prompt_text,
  ROUND((response_quality * success_flag) / (tokens / 100.0), 2) AS efficiency_score
FROM prompts
ORDER BY efficiency_score DESC
LIMIT 10;
```

---

### 📌 6. Hallucinated Prompts (Risk Analysis)
*Which prompts caused the AI to hallucinate?*
```sql
SELECT 
  prompt_id,
  prompt_text,
  category,
  response_quality
FROM prompts
WHERE hallucination_flag = 1
ORDER BY response_quality ASC;
```

---

### 📌 7. User Behavior Analysis
*Who are the most active users and how do they perform?*
```sql
SELECT 
  user_id,
  COUNT(*)                        AS total_prompts,
  ROUND(AVG(response_quality), 2) AS avg_quality,
  SUM(success_flag)               AS successes,
  SUM(hallucination_flag)         AS hallucinations
FROM prompts
GROUP BY user_id
ORDER BY total_prompts DESC
LIMIT 10;
```

---

### 📌 8. Response Time vs Quality
*Do faster responses mean worse quality?*
```sql
SELECT 
  CASE 
    WHEN response_time_ms < 600  THEN 'Fast (< 600ms)'
    WHEN response_time_ms < 1200 THEN 'Medium (600–1200ms)'
    ELSE                              'Slow (> 1200ms)'
  END AS speed_bucket,
  ROUND(AVG(response_quality), 2) AS avg_quality,
  COUNT(*)                        AS total
FROM prompts
GROUP BY speed_bucket
ORDER BY avg_quality DESC;
```

---

### 📌 9. Token Usage by Category
*Which category uses the most tokens on average?*
```sql
SELECT 
  category,
  ROUND(AVG(tokens), 0)   AS avg_tokens,
  MIN(tokens)             AS min_tokens,
  MAX(tokens)             AS max_tokens
FROM prompts
GROUP BY category;
```

---

### 📌 10. Low Quality Prompts (Needs Improvement)
*Prompts scoring 1 or 2 that need attention*
```sql
SELECT 
  prompt_id,
  prompt_text,
  category,
  response_quality,
  hallucination_flag
FROM prompts
WHERE response_quality <= 2
ORDER BY response_quality ASC;
```

---

## 🧠 What I Analyzed

| ✅ Analysis | 📊 Method |
|---|---|
| User behavior patterns | GROUP BY user_id |
| Prompt success vs failure | SUM(success_flag) |
| AI hallucination frequency | SUM(hallucination_flag) |
| Token usage efficiency | AVG(tokens) per category |
| Category-wise performance | GROUP BY category |
| Response quality trends | AVG(response_quality) |
| Speed vs quality trade-off | CASE bucketing |
| Risk prompts identification | WHERE hallucination_flag = 1 |

---

## 📊 Key Insights Found

### 📈 Performance
- ✅ **Code prompts** performed best — highest avg quality & success rate
- 📘 **Education prompts** were stable and consistent
- ⚠️ **Knowledge prompts** had the highest hallucination risk

### ⚡ Efficiency
- 🎯 **Medium-length prompts** (100–200 tokens) delivered the best quality
- 📉 Very short prompts were too vague; very long ones slowed responses

### 🚨 Risk
- 🔴 Hallucinations were **strongly correlated** with quality scores of 1–2
- 📍 Most hallucinated prompts came from the **knowledge category**
- 🛡️ Identifying these patterns can directly improve AI safety systems

---

## 🏆 Project Outcomes

This project successfully built a:

> ### 📊 Mini AI Analytics Engine — powered entirely by SQL

It demonstrates how structured data + analytical SQL can:

- 🔍 Measure AI system performance at scale
- 🧠 Pinpoint where and why AI fails
- 📉 Identify inefficient prompt patterns
- 👤 Understand real user behavior
- 🛡️ Contribute to AI safety improvements

---

## 🔮 Future Improvements

| 🚀 Upgrade | 💡 Description |
|---|---|
| 📊 Power BI Dashboard | Visual KPI dashboard connected to MySQL |
| 🐍 Python + SQL Pipeline | Automate data ingestion & reporting |
| 🤖 ML Hallucination Detector | Train a model on flagged prompts |
| ⚡ Real-time Tracking | Live prompt monitoring system |
| 🌐 API Integration | Connect to live LLM APIs for streaming data |

---

## 👨‍💻 Conclusion

This project proves that **you don't need a complex ML pipeline to understand AI behavior** — sometimes, clean SQL is all you need.

By treating AI prompt logs as structured data, we can extract patterns, measure risk, and drive real improvements in AI systems.

> 🔥 *"Without analytics, AI is just guessing. With data, it becomes intelligence."*

---

## 📁 Project Structure

```
ai-prompt-analytics/
│
├── 📄 README.md                  ← You are here
├── 📊 prompt_dataset.csv         ← Raw dataset (500 records)
├── 📊 prompt_dataset.xlsx        ← Formatted Excel version
└── 📁 sql/
    ├── schema.sql                ← CREATE TABLE script
    ├── analysis_queries.sql      ← All 10 analysis queries
    └── insights_report.sql      ← Summary KPI view
```

---

*Built with ❤️ using MySQL | SQL Analytics | Real-world AI Data*
