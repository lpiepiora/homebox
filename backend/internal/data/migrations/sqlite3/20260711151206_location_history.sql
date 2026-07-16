-- +goose Up
create table if not exists location_histories
(
    id          uuid     not null
        primary key,
    created_at  datetime not null,
    updated_at  datetime not null,
    entity_id   uuid     not null
        constraint location_histories_entities_location_history
            references entities
            on delete cascade,
    location_id uuid     not null
        constraint location_histories_entities_location_history_entries
            references entities
            on delete cascade,
    moved_in     datetime not null,
    moved_out    datetime
);

create index if not exists location_histories_entity_id
    on location_histories (entity_id);

-- +goose Down
drop table if exists location_histories;
