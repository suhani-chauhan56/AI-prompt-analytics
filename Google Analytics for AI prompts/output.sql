-- Prompt Efficiency Score
SELECT 
    prompt_id,
    (response_quality * success_flag) / (tokens/100) AS efficiency_score
FROM prompts
ORDER BY efficiency_score DESC;

-- User Behavior Analysis
SELECT 
    user_id,
    COUNT(*) AS total_prompts,
    AVG(tokens) AS avg_tokens,
    AVG(response_quality) AS avg_quality
FROM prompts
GROUP BY user_id
ORDER BY total_prompts DESC;

-- Category Risk Score
SELECT 
    category,
    AVG(hallucination_flag) AS risk_score
FROM prompts
GROUP BY category
ORDER BY risk_score DESC;