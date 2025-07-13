with source as (

    select * from {{ source('raw_data_source', 'raw_match_results') }}

),

renamed as (

    select
        -- Sütunları yeniden adlandırıp veri tiplerini düzeltelim
        match_id,
        player_id,
        player_name,
        score,
        match_duration_seconds,
        cast(match_end_time as timestamp) as match_ended_at

    from source

)

select * from renamed