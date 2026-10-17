
WITH facebook AS (

    SELECT
        'Facebook' AS platform,
        ad_id AS ad_detail_id,
        account_id,
        CAST(NULL AS string) AS ad_currency_code,
        CAST(NULL AS string) AS ad_country,
        ad_spend,
        ad_impressions,
        ad_clicks,
        ad_date
    FROM {{ ref('stg_facebook_ads') }}

),

snapchat AS (

    SELECT
        'Snapchat' AS platform,
        ad_detail_id,
        CAST(NULL AS string) AS account_id,
        ad_currency_code,
        ad_country,
        ad_spend,
        ad_impressions,
        ad_clicks,
        ad_date
    FROM {{ ref('stg_snapchat_ads') }}

)

SELECT * FROM facebook

UNION ALL

SELECT * FROM snapchat