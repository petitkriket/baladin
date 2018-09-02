t.string "confirmation_token"
t.datetime "confirmed_at"
t.datetime "confirmation_sent_at"
t.string "unconfirmed_email"



User Create (1.1ms)  INSERT INTO "users" ("email", "encrypted_password", "created_at", "updated_at", "name", "confirmation_token", "confirmation_sent_at", "role", "locale") VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING "id"  [["email", "pujno@1shivom.com"], ["encrypted_password", "$2a$11$53d/3yZC8jMQY.DxdRPj7uVL3xQJd8fA4LV1gYf92XDTbH/iAAGY2"], ["created_at", "2018-09-02 21:00:02.562391"], ["updated_at", "2018-09-02 21:00:02.562391"], ["name", "Patrick"], ["confirmation_token", "U8jzBWvCNXZjjaC2nHh5"], ["confirmation_sent_at", "2018-09-02 21:00:02.562827"], ["role", 0], ["locale", "fr"]]



create_table "events", force: :cascade do |t|
  t.string "address"
  t.string "city"
  t.string "country"
  t.float "latitude"
  t.float "longitude"
  t.string "photo"
  t.boolean "published"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.bigint "user_id"
  t.bigint "passenger_id"
  t.index ["passenger_id"], name: "index_events_on_passenger_id"
  t.index ["user_id"], name: "index_events_on_user_id"

  INSERT INTO "events" ("address", "city", "country", "latitude", "longitude", "published", "created_at", "updated_at", "user_id", "passenger_id") VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING "id"  [["address", "Londres, Royaume-Uni"], ["city", "London"], ["country", "GB"], ["latitude", 51.5073509], ["longitude", -0.1277583], ["published", true], ["created_at", "2018-09-02 21:46:40.022305"], ["updated_at", "2018-09-02 21:46:40.022305"], ["user_id", 1], ["passenger_id", 1]]
