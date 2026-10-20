
SELECT
    CAST(ad_detail_id AS string) AS ad_detail_id,
    CAST(ad_currency_code AS string) AS ad_currency_code,
    CAST(ad_country AS string) AS ad_country,
    TRY_CAST(ad_spend AS double) AS ad_spend,
    TRY_CAST(ad_impressions AS bigint) AS ad_impressions,
    TRY_CAST(ad_clicks AS bigint) AS ad_clicks,
    TRY_CAST(ad_date AS date) AS ad_date,
    CAST(data_src AS string) AS data_src
FROM {{ source('marketing', 'snapchat_ads_stats') }}
WHERE ad_detail_id IS NOT NULL
  AND ad_date IS NOT NULL