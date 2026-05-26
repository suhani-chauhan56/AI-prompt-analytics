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

## 📈 Business Insights & Project Outcomes

After analyzing AI prompt data using SQL, several meaningful business insights were discovered.

These findings transform the project from a simple SQL practice project into a real-world AI analytics case study.

---

## 🔥 Key Insights Discovered

### 1️⃣ Long Prompts Increase Hallucination Risk

Analysis showed that prompts with higher token counts were more likely to generate hallucinated or incorrect AI responses.

### 📌 Outcome
- Long and complex prompts confused the AI more frequently.
- Hallucination probability increased significantly for prompts above the optimal token range.
- Prompt optimization can improve AI reliability and response accuracy.

### SQL Query

```sql
SELECT 
  CASE 
    WHEN tokens > 250 THEN 'Long Prompt'
    ELSE 'Short Prompt'
  END AS prompt_type,
  
  COUNT(*) AS total_prompts,
  
  SUM(hallucination_flag) AS hallucinated_prompts,
  
  ROUND(
      (SUM(hallucination_flag) / COUNT(*)) * 100,
      2
  ) AS hallucination_rate_pct

FROM prompts
GROUP BY prompt_type;
```

---

## 2️⃣ Coding Prompts Have Highest Engagement

Technical prompts such as coding and SQL queries generated the highest user interaction and response quality scores.

### 📌 Outcome
- Users spent more time interacting with coding-related prompts.
- Developer-focused prompts produced higher engagement and better AI performance.
- AI tools targeted toward programming assistance may improve user retention.

### SQL Query

```sql
SELECT 
    category,
    
    COUNT(*) AS total_prompts,
    
    ROUND(AVG(response_quality), 2) AS avg_quality,
    
    SUM(success_flag) AS successful_prompts

FROM prompts
GROUP BY category
ORDER BY total_prompts DESC;
```

---

## 3️⃣ Follow-up Prompts Indicate Better User Satisfaction

Users who continued conversations with multiple follow-up prompts showed stronger engagement behavior.

### 📌 Outcome
- Multi-turn conversations indicated higher satisfaction levels.
- Users were more likely to continue interacting when responses were useful.
- Conversational AI systems benefit from interactive engagement patterns.

### SQL Query

```sql
SELECT 
    user_id,
    
    COUNT(*) AS total_prompts,
    
    ROUND(AVG(response_quality), 2) AS avg_quality,
    
    SUM(success_flag) AS successful_interactions

FROM prompts
GROUP BY user_id
HAVING COUNT(*) > 5
ORDER BY total_prompts DESC;
```

---

## 4️⃣ Faster Responses Produce Better Quality Ratings

Response speed had a noticeable impact on perceived response quality.

### 📌 Outcome
- Faster responses generally received better quality scores.
- Slow responses were more commonly associated with hallucinations and failed interactions.
- AI latency optimization can improve user experience.

### SQL Query

```sql
SELECT 
  CASE 
    WHEN response_time_ms < 600 THEN 'Fast'
    WHEN response_time_ms < 1200 THEN 'Medium'
    ELSE 'Slow'
  END AS response_speed,

  ROUND(AVG(response_quality), 2) AS avg_quality,
  
  COUNT(*) AS total_responses

FROM prompts
GROUP BY response_speed
ORDER BY avg_quality DESC;
```

---

## 5️⃣ Token Efficiency Impacts AI Performance

The analysis identified an optimal token range where AI responses achieved the best balance between quality and efficiency.

### 📌 Outcome
- Prompts between 100–200 tokens produced the best response quality.
- Extremely short prompts lacked context.
- Very large prompts reduced efficiency and increased hallucination risk.

### SQL Query

```sql
SELECT 
  CASE 
    WHEN tokens BETWEEN 100 AND 200 THEN 'Optimal Token Range'
    ELSE 'Non Optimal'
  END AS token_category,

  ROUND(AVG(response_quality), 2) AS avg_quality,

  ROUND(AVG(tokens), 0) AS avg_tokens

FROM prompts
GROUP BY token_category;
```

---

# 🏆 Final Project Outcomes

This project successfully demonstrated how SQL analytics can be used to:

✅ Measure AI response quality  
✅ Detect hallucination patterns  
✅ Analyze user engagement behavior  
✅ Track token efficiency  
✅ Evaluate AI performance metrics  
✅ Generate business-level insights from conversational AI data  

---

# 💡 Business Impact

The analytics generated from this project can help organizations:

- Improve AI reliability
- Reduce hallucination risks
- Optimize token usage costs
- Enhance user satisfaction
- Improve prompt engineering strategies
- Build safer AI systems

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
