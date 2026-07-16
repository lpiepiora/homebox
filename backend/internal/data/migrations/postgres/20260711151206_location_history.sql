-- +goose Up
-- Record changes to the entity location.
CREATE TABLE IF NOT EXISTS "location_histories" (
    "id" uuid NOT NULL,
    "created_at" timestamptz NOT NULL,
    "updated_at" timestamptz NOT NULL,
    "entity_id" uuid NOT NULL,
    "location_id" uuid NOT NULL,
    "moved_in" timestamptz NOT NULL,
    "moved_out" timestamptz NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "location_histories_entities_location_history"
        FOREIGN KEY ("entity_id")
        REFERENCES "entities" ("id")
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT "location_histories_entities_location_history_entries"
        FOREIGN KEY ("location_id")
        REFERENCES "entities" ("id")
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS "location_histories_entity_id"
    ON "location_histories" ("entity_id");

-- +goose Down
DROP TABLE IF EXISTS "location_histories";
