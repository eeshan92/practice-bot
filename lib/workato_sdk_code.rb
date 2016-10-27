{
  title: "BamBot",

  connection: {
    fields: [
      {
        name: "email",
        control_type: "email",
        optional: false
      },
      {
        name: "token",
        control_type: "password",
        optional: false
      },
      {
        name: "domain",
        optional: false
      }
    ],

    authorization: {
      type: "custom",

      credentials: lambda do |connection|
        headers("X-User-email": connection["email"])
        headers("X-User-Token": connection["token"])
      end
    }
  },

  test: lambda do |connection|
    get("#{connection["domain"]}/users/me")
  end,

  object_definitions: {
    practice: {
      fields: lambda do
        [
          {
            name: "id",
            type: :integer
          },
          {
            name: "date",
            type: :date
          },
          {
            name: "status",
            hint: "active, cancelled, pending"
          },
          {
            name: "location_id",
            type: :integer
          },
          {
            name: "start",
            type: :date_time
          },
          {
            name: "end",
            type: :date_time
          },
          {
            name: "created_at",
            type: :date_time
          },
          {
            name: "updated_at",
            type: :date_time
          },
        ]
      end
    },

    player: {
      fields: lambda do
        [
          {
            name: "id",
            type: :integer
          },
          {
            name: "full_name"
          },
          {
            name: "handle"
          },
          {
            name: "foreign_id",
            type: :string
          },
          {
            name: "gender",
            hint: "male or female"
          },
          {
            name: "created_at",
            type: :date_time
          },
          {
            name: "updated_at",
            type: :date_time
          },
        ]
      end
    },

    attendance: {
      fields: lambda do
        [
          {
            name: "id",
            type: :integer
          },
          {
            name: "practice_id",
            type: :integer
          },
          {
            name: "player_id",
            type: :integer
          },
          {
            name: "status",
            hint: "attend, skip, pending"
          },
          {
            name: "comment"
          },
          {
            name: "created_at",
            type: :date_time
          },
          {
            name: "updated_at",
            type: :date_time
          }
        ]
      end
    }
  },

  actions: {

    search_player: {
      description: "Search <span class='provider'>player</span>",

      input_fields: lambda do |object_definitions|
        object_definitions["player"].
          ignored("id")
      end,

      execute: lambda do |connection, input|
        {
          "players": get("#{connection["domain"]}/players", input)
        }
      end,

      output_fields: lambda do |object_definitions|
        [
          {
            name: "players",
            type: :array, of: :object,
            properties: object_definitions["player"]
          }
        ]
      end,

      sample_output: lambda do |connection|
        {
          "players" => (get("#{connection["domain"]}/players") || [{}]).first
        }
      end
    },

    get_player_by_id: {
      description: "Get <span class='provider'>player</span> by ID",

      input_fields: lambda do |object_definitions|
        object_definitions["player"].
          only("id").
          required("id")
      end,

      execute: lambda do |connection, input|
        get("#{connection["domain"]}/players/#{input["id"]}")
      end,

      output_fields: lambda do |object_definitions|
        object_definitions["player"]
      end,

      sample_output: lambda do |connection|
        (get("#{connection["domain"]}/players") || [{}]).first
      end
    },

    create_player: {
      description: "Create <span class='provider'>player</span>",

      input_fields: lambda do |object_definitions|
        object_definitions["player"].
          ignored("id", "created_at", "updated_at").
          required("full_name")
      end,

      execute: lambda do |connection, input|
        post("#{connection["domain"]}/players", input)
      end,

      output_fields: lambda do |object_definitions|
        object_definitions["player"]
      end,

      sample_output: lambda do |connection|
        (get("#{connection["domain"]}/players") || [{}]).first
      end
    },

    update_player: {
      description: "Update <span class='provider'>player</span>",

      input_fields: lambda do |object_definitions|
        object_definitions["player"].
          ignored("created_at", "updated_at").
          required("id")
      end,

      execute: lambda do |connection, input|
        put("#{connection["domain"]}/players/#{input["id"]}", input)
      end,

      output_fields: lambda do |object_definitions|
        object_definitions["player"].only("id")
      end,

      sample_output: lambda do |connection|
        {
          "id" => 5
        }
      end
    },

    search_practice: {
      description: "Search <span class='provider'>practice</span>",

      input_fields: lambda do |object_definitions|
        object_definitions["practice"].
          ignored("id")
      end,

      execute: lambda do |connection, input|
        {
          "practices": get("#{connection["domain"]}/practices", input)
        }
      end,

      output_fields: lambda do |object_definitions|
        [
          {
            name: "practices",
            type: :array, of: :object,
            properties: object_definitions["practice"]
          }
        ]
      end,

      sample_output: lambda do |connection|
        {
          "practices" => (get("#{connection["domain"]}/practices") || [{}]).first
        }
      end
    },

    get_practice_by_id: {
      description: "Get <span class='provider'>practice</span> by ID",

      input_fields: lambda do |object_definitions|
        object_definitions["practice"].
          only("id").
          required("id")
      end,

      execute: lambda do |connection, input|
        get("#{connection["domain"]}/practices/#{input["id"]}")
      end,

      output_fields: lambda do |object_definitions|
        object_definitions["practice"]
      end,

      sample_output: lambda do |connection|
        (get("#{connection["domain"]}/practices") || [{}]).first
      end
    },

    create_practice: {
      description: "Create <span class='provider'>practice</span>",

      input_fields: lambda do |object_definitions|
        object_definitions["practice"].
          ignored("id", "created_at", "updated_at").
          required("date", "location_id")
      end,

      execute: lambda do |connection, input|
        post("#{connection["domain"]}/practices", input)
      end,

      output_fields: lambda do |object_definitions|
        object_definitions["practice"]
      end,

      sample_output: lambda do |connection|
        (get("#{connection["domain"]}/practices") || [{}]).first
      end
    },

    update_practice: {
      description: "Update <span class='provider'>practice</span>",

      input_fields: lambda do |object_definitions|
        object_definitions["practice"].
          ignored("created_at", "updated_at").
          required("id")
      end,

      execute: lambda do |connection, input|
        put("#{connection["domain"]}/practices/#{input["id"]}", input)
      end,

      output_fields: lambda do |object_definitions|
        object_definitions["practice"].only("id")
      end,

      sample_output: lambda do |connection|
        {
          "id" => 5
        }
      end
    },

    search_attendance: {
      description: "Search <span class='provider'>attendance</span>",

      input_fields: lambda do |object_definitions|
        object_definitions["attendance"].
          ignored("id")
      end,

      execute: lambda do |connection, input|
        {
          "attendances": get("#{connection["domain"]}/attendances", input)
        }
      end,

      output_fields: lambda do |object_definitions|
        [
          {
            name: "attendances",
            type: :array, of: :object,
            properties: object_definitions["attendance"]
          }
        ]
      end,

      sample_output: lambda do |connection|
        {
          "attendances" => (get("#{connection["domain"]}/attendances") || [{}]).first
        }
      end
    },

    get_attendance_by_id: {
      description: "Get <span class='provider'>attendance</span> by ID",

      input_fields: lambda do |object_definitions|
        object_definitions["attendance"].
          only("id").
          required("id")
      end,

      execute: lambda do |connection, input|
        get("#{connection["domain"]}/attendances/#{input["id"]}")
      end,

      output_fields: lambda do |object_definitions|
        object_definitions["attendance"]
      end,

      sample_output: lambda do |connection|
        (get("#{connection["domain"]}/attendances") || [{}]).first
      end
    },

    create_attendance: {
      description: "Create <span class='provider'>attendance</span>",

      input_fields: lambda do |object_definitions|
        object_definitions["attendance"].
          ignored("id", "created_at", "updated_at").
          required("status", "practice_id", "player_id")
      end,

      execute: lambda do |connection, input|
        post("#{connection["domain"]}/attendances", input)
      end,

      output_fields: lambda do |object_definitions|
        object_definitions["attendance"]
      end,

      sample_output: lambda do |connection|
        (get("#{connection["domain"]}/attendances") || [{}]).first
      end
    },

    update_attendance: {
      description: "Update <span class='provider'>attendance</span>",

      input_fields: lambda do |object_definitions|
        object_definitions["attendance"].
          ignored("created_at", "updated_at").
          required("id")
      end,

      execute: lambda do |connection, input|
        put("#{connection["domain"]}/attendances/#{input["id"]}", input)
      end,

      output_fields: lambda do |object_definitions|
        object_definitions["attendance"].only("id")
      end,

      sample_output: lambda do |connection|
        {
          "id" => 5
        }
      end
    }
  },

  triggers: {},

  pick_lists: {}
}