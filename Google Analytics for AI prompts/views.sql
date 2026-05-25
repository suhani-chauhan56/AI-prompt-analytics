CREATE VIEW prompt_dashboard AS
SELECT 
    category,
    COUNT(*) AS total_prompts,
    AVG(tokens) AS avg_tokens,
    AVG(response_quality) AS avg_quality,
    SUM(success_flag) AS successes,
    SUM(hallucination_flag) AS hallucinations
FROM prompts
GROUP BY category;

CREATE VIEW high_quality_prompts AS
SELECT *
FROM prompts
WHERE response_quality >= 4 AND success_flag = 1;

CREATE VIEW risky_prompts AS
SELECT *
FROM prompts
WHERE hallucination_flag = 1;