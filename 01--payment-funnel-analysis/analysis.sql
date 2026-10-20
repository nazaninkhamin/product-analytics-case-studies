SELECT
 event_name,
 COUNT(DISTINCT user_id) AS unique_users
FROM
user_events
WHERE
 event_timestamp BETWEEN '2026-10-13' AND '2026-10-20'
 AND event_name IN ('view_plan_page', 'click_subscribe', 'payment_success')
GROUP BY 
 event_name
ORDER BY
 CASE
  WHEN event_name='view_plan_page' THEN 1
  WHEN event_name='click_subscribe' THEN 2
  WHEN event_name='payment_success' THEn 3
 END;

