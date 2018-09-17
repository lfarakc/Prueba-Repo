# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "personas", id: :serial, force: :cascade do |t|
    t.string "tipo_persona", limit: 3, null: false
    t.string "tipo_identificacion", limit: 3, null: false
    t.string "identificacion", limit: 30, null: false
    t.string "nombres", limit: 100, null: false
    t.string "apellidos", limit: 100
    t.string "email", limit: 60
    t.decimal "telefono", precision: 10
    t.datetime "fecha_registro", null: false
    t.bigint "fecha_actualizacion"
  end

  create_table "tipos_identificacion", primary_key: "codigo", id: :string, limit: 3, force: :cascade do |t|
    t.string "nombre", limit: 30, null: false
  end

  create_table "tipos_persona", primary_key: "codigo", id: :string, limit: 3, force: :cascade do |t|
    t.string "nombre", limit: 30, null: false
  end

  create_table "tipos_residuo", primary_key: "codigo", id: :integer, default: nil, force: :cascade do |t|
    t.string "nombre", limit: 50, null: false
  end

  create_table "ubicaciones_personas", primary_key: ["id_persona", "consecutivo"], force: :cascade do |t|
    t.bigint "id_persona", null: false
    t.integer "consecutivo", null: false, comment: "Número consecutivo de la ubicación para la persona"
    t.integer "tipo_ubicacion", null: false, comment: "Tipo de la ubicación (1-Casa, 2-Principal,3-oficina, 4-Sucursal )"
    t.decimal "cod_localidad", precision: 3, null: false
    t.string "direccion", limit: 100, null: false
    t.bigint "coordenada_x"
    t.bigint "coordenada_y"
  end

  create_table "usuarios", primary_key: "id_persona", id: :bigint, comment: "UUID, identificador único del usuario relacionado que viene de la entidad Personas", default: nil, force: :cascade do |t|
    t.string "estado", limit: 1, null: false, comment: "Indica el estado del usuario (A-Activo, I-Inactivo, R-Retirado)"
    t.string "password", limit: 32
  end

  add_foreign_key "personas", "tipos_identificacion", column: "tipo_identificacion", primary_key: "codigo", name: "fk_tipo_identificacion"
  add_foreign_key "personas", "tipos_persona", column: "tipo_persona", primary_key: "codigo", name: "fk_tipo_persona"
  add_foreign_key "usuarios", "personas", column: "id_persona", name: "fk_id_persona"
end
