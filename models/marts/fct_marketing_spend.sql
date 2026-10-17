
WITH marketing_ads AS (

    SELECT *
    FROM {{ ref('int_marketing_ads') }}

)

SELECT
    platform,
    ad_detail_id,
    account_id,
    ad_currency_code,
    ad_country,
    ad_spend,
    ad_impressions,
    ad_clicks,
    ad_date,

    CASE
        WHEN ad_impressions > 0
        THEN ad_clicks * 1.0 / ad_impressions
        ELSE NULL
    END AS click_through_rate,

    CASE
        WHEN ad_clicks > 0
        THEN ad_spend / ad_clicks
        ELSE NULL
    END AS cost_per_click,

    CASE
        WHEN ad_impressions > 0
        THEN ad_spend * 1000.0 / ad_impressions
        ELSE NULL
    END AS cost_per_thousand_impressions

FROM marketing_ads