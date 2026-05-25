CREATE DATABASE ai_prompt_analytics1;

USE ai_prompt_analytics1;

CREATE TABLE prompts (
    prompt_id INT PRIMARY KEY,
    user_id INT,
    prompt_text TEXT,
    category VARCHAR(50),
    tokens INT,
    response_quality INT,
    success_flag INT,
    hallucination_flag INT,
    response_time_ms INT
);

SELECT * FROM prompts;
