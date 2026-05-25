# 📊 AI Prompt Analytics System
> *"Google Analytics — but for AI Prompts"*

![SQL](https://img.shields.io/badge/SQL-MySQL-blue) ![Dataset](https://img.shields.io/badge/Dataset-500%20Records-green) ![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---



Imagine you've just joined an AI company — like OpenAI or Google DeepMind.

Every single day:
- 🧑‍💻 Thousands of users fire prompts at the AI
- ✅ Some answers are brilliant — ❌ some are completely wrong
- 🐢 Some responses are slow, some hallucinate facts entirely

**But nobody is watching the data.**

So you build something — a lightweight, SQL-powered engine that does for AI prompts what Google Analytics does for websites:

> **Tracks, measures, and reveals the truth behind every AI interaction.**

---

## ❓ Problem Statement

There is no structured way to evaluate AI prompt performance. Key questions go unanswered:

| Question | Why It Matters |
|---|---|
| Which prompts perform well? | Helps users write better prompts |
| Where does AI hallucinate? | Improves AI safety & trust |
| How many tokens per prompt? | Optimizes cost & efficiency |
| Which categories work best? | Guides AI training priorities |

---

## 🎯 Objectives

- 📈 Measure prompt **success rate**
- 🧠 Detect **AI hallucinations**
- ⚡ Analyze **token usage efficiency**
- 📂 Compare **category-wise performance**
- 👤 Understand **user behavior patterns**

---

## 🏗️ Tech Stack

| Tool | Purpose |
|---|---|
| 🐬 MySQL Workbench | Database engine & query execution |
| 📁 SQL | Data storage, analysis & transformation |
| 📊 CSV / Excel | Source dataset (500 records) |

---

## 📦 Dataset — Schema

```sql
CREATE DATABASE ai_prompt_analytics;
USE ai_prompt_analytics;

CREATE TABLE prompts (
    prompt_id          INT PRIMARY KEY,
    user_id            INT,
    prompt_text        TEXT,
    category           VARCHAR(50),       -- code | education | knowledge
    tokens             INT,
    response_quality   INT,               -- Score: 1 (bad) to 5 (excellent)
    success_flag       INT,               -- 1 = success, 0 = failure
    hallucination_flag INT,               -- 1 = incorrect AI response
    response_time_ms   INT
);
```

---

## 🔄 How It Works

```
📥 Load CSV  →  🗄️ Store in MySQL  →  🔍 Run Queries  →  📊 Extract Insights  →  🚀 Report Findings
```

---

## 🔍 SQL Queries

### 1. Overall Success Rate
```sql
SELECT ROUND((SUM(success_flag) / COUNT(*)) * 100, 2) AS success_rate_pct
FROM prompts;
```

### 2. Hallucination Rate
```sql
SELECT ROUND((SUM(hallucination_flag) / COUNT(*)) * 100, 2) AS hallucination_rate_pct
FROM prompts;
```

### 3. Category-wise Performance
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

### 4. Most Used Categories
```sql
SELECT category, COUNT(*) AS usage_count
FROM prompts
GROUP BY category
ORDER BY usage_count DESC;
```

### 5. Prompt Efficiency Score
```sql
SELECT 
  prompt_id,
  prompt_text,
  ROUND((response_quality * success_flag) / (tokens / 100.0), 2) AS efficiency_score
FROM prompts
ORDER BY efficiency_score DESC
LIMIT 10;
```

### 6. Hallucinated Prompts — Risk Analysis
```sql
SELECT prompt_id, prompt_text, category, response_quality
FROM prompts
WHERE hallucination_flag = 1
ORDER BY response_quality ASC;
```

### 7. User Behavior Analysis
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

### 8. Response Time vs Quality
```sql
SELECT 
  CASE 
    WHEN response_time_ms < 600  THEN 'Fast (< 600ms)'
    WHEN response_time_ms < 1200 THEN 'Medium (600–1200ms)'
    ELSE                              'Slow (> 1200ms)'
  END AS speed_bucket,
  ROUND(AVG(response_quality), 2) AS avg_quality,
  COUNT(*) AS total
FROM prompts
GROUP BY speed_bucket
ORDER BY avg_quality DESC;
```

### 9. Token Usage by Category
```sql
SELECT 
  category,
  ROUND(AVG(tokens), 0) AS avg_tokens,
  MIN(tokens)           AS min_tokens,
  MAX(tokens)           AS max_tokens
FROM prompts
GROUP BY category;
```

### 10. Low Quality Prompts
```sql
SELECT prompt_id, prompt_text, category, response_quality, hallucination_flag
FROM prompts
WHERE response_quality <= 2
ORDER BY response_quality ASC;
```

---

## 📊 Key Insights

| Area | Finding |
|---|---|
| 🧑‍💻 Code prompts | Best performance — highest quality & success rate |
| 📘 Education prompts | Stable and consistent across all metrics |
| 🌍 Knowledge prompts | Highest hallucination risk |
| 🎯 Token sweet spot | 100–200 tokens gave the best quality scores |
| 🔴 Hallucination pattern | Strongly correlated with quality scores of 1–2 |

---

## 🏆 Outcomes

This project delivers a **Mini AI Analytics Engine — built entirely in SQL** that:

- 🔍 Measures AI performance at scale
- 🧠 Pinpoints where and why AI fails
- 👤 Reveals real user behavior patterns
- 🛡️ Identifies risk prompts for AI safety improvements

---

## 🔮 Future Improvements

| Upgrade | Description |
|---|---|
| 📊 Power BI Dashboard | Visual KPIs connected live to MySQL |
| 🐍 Python + SQL Pipeline | Automated data ingestion & reporting |
| 🤖 ML Hallucination Detector | Model trained on flagged prompts |
| ⚡ Real-time Tracking | Live prompt monitoring system |

---

## 📁 Project Structure

```
ai-prompt-analytics/
│
├── 📄 README.md
├── 📊 prompt_dataset.csv
├── 📊 prompt_dataset.xlsx
└── 📁 sql/
    ├── sqlSchema.sql              ← Database & table creation
    ├── analytics_queries1.sql     ← All 10 analysis queries
    ├── views.sql                  ← Reusable SQL views
    └── output.sql                 ← Query outputs & results
```

---

## 👨‍💻 Conclusion

This project proves you don't need a complex ML pipeline to understand AI behavior — **clean SQL is enough.**

> 🔥 *"Without analytics, AI is just guessing. With data, it becomes intelligence."*

---

*Built with ❤️ using MySQL | SQL Analytics | Real-world AI Data*
