
SELECT
    CAST(ad_id AS string) AS ad_id,
    CAST(account_id AS string) AS account_id,
    TRY_CAST(ad_spend AS double) AS ad_spend,
    TRY_CAST(ad_impressions AS bigint) AS ad_impressions,
    TRY_CAST(ad_clicks AS bigint) AS ad_clicks,
    TRY_CAST(ad_date AS date) AS ad_date
FROM {{ source('marketing', 'facebook_ads_stats') }}