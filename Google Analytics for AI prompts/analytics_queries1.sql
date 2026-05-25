-- Average Prompt Length
SELECT AVG(tokens) AS avg_tokens
FROM prompts;

-- Success Rate
SELECT 
  (SUM(success_flag) / COUNT(*)) * 100 AS success_rate
FROM prompts;

-- Hallucination Rate
SELECT 
  (SUM(hallucination_flag) / COUNT(*)) * 100 AS hallucination_rate
FROM prompts;

-- Category-wise Performance
SELECT 
  category,
  COUNT(*) AS total_prompts,
  AVG(response_quality) AS avg_quality,
  SUM(success_flag) AS success_count
FROM prompts
GROUP BY category;

-- Most Used Prompt Category
SELECT category, COUNT(*) AS usage_count
FROM prompts
GROUP BY category
ORDER BY usage_count DESC;

-- Slowest Prompts
SELECT *
FROM prompts
ORDER BY response_time_ms DESC
LIMIT 5;

-- Failed Prompts Analysis
SELECT *
FROM prompts
WHERE success_flag = 0;