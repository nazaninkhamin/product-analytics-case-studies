/* step 1: calculate conversion funnel
*/
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
/* step2: device and sunscription type segmentation
*/
SELECT
 device_os,
 subscription_type,
 COUNT(DISTINCT CASE WHEN event_name='click_subscribe' THEN user_id END) AS clicked_subscribe,
 COUNT(DISTINCT CASE WHEN event_name='payment_success' THEN use_id END) AS successful_payment,
 COUNT(DISTINCT CASE WHEN event_name='payment_success' THEN user_id END)*1.0/NULLIF(COUNT(DISTINCT CASE WHEN event_name='click_subscribe' THEN user_id END),0) AS conversion_rate
FROM
 user_events
WHERE
 event_timestamp BETWEEN '2026-10-13' AND '2026-10-20'
GROUP BY
 device_os,
 subscription_type
ORDER BY
 device_os
 subscription_type
