# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_10_03_000000) do
  create_table "mensagens", force: :cascade do |t|
    t.string "conteudo"
    t.integer "usuario_id", null: false
    t.integer "sala_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sala_id"], name: "index_mensagens_on_sala_id"
    t.index ["usuario_id"], name: "index_mensagens_on_usuario_id"
  end

  create_table "salas", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  create_table "usuarios_salas", force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.integer "sala_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "papel", default: "member", null: false
    t.string "categoria"
    t.index ["papel"], name: "index_usuarios_salas_on_papel"
    t.index ["sala_id"], name: "index_usuarios_salas_on_sala_id"
    t.index ["usuario_id"], name: "index_usuarios_salas_on_usuario_id"
  end

  add_foreign_key "mensagens", "salas"
  add_foreign_key "mensagens", "salas"
  add_foreign_key "mensagens", "usuarios"
  add_foreign_key "mensagens", "usuarios"
  add_foreign_key "usuarios_salas", "salas"
  add_foreign_key "usuarios_salas", "salas"
  add_foreign_key "usuarios_salas", "usuarios"
  add_foreign_key "usuarios_salas", "usuarios"
end
