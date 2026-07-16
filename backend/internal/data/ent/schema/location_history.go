package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
	"github.com/google/uuid"
	"github.com/sysadminsmedia/homebox/backend/internal/data/ent/schema/mixins"
)

// LocationHistory holds the schema definition for the LocationHistory entity.
type LocationHistory struct {
	ent.Schema
}

func (LocationHistory) Mixin() []ent.Mixin {
	return []ent.Mixin{
		mixins.BaseMixin{},
	}
}

// Fields of the LocationHistory.
func (LocationHistory) Fields() []ent.Field {
	return []ent.Field{
		field.UUID("entity_id", uuid.UUID{}),
		field.UUID("location_id", uuid.UUID{}),
		// when the entity was moved-in to the location
		field.Time("moved_in").Immutable(),
		// when the entity was moved-out of the location
		field.Time("moved_out").Optional().Nillable(),
	}
}

func (LocationHistory) Indexes() []ent.Index {
	return []ent.Index{
		index.Fields("entity_id"),
	}
}

// Edges of the LocationHistory.
func (LocationHistory) Edges() []ent.Edge {
	return []ent.Edge{
		// The subject entity.
		edge.From("entity", Entity.Type).
			Field("entity_id").
			Ref("location_history").
			Required().
			Unique(),
		// The location to which the history entry points to
		edge.To("location", Entity.Type).
			Field("location_id").
			Required().
			Unique(),
	}
}
