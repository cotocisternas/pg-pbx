# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131026012857) do

  create_table "cdrs", force: true do |t|
    t.string    "network",     limit: 10,                                               null: false
    t.timestamp "calldate",               precision: 0, default: '2013-10-26 01:48:20'
    t.string    "clid",        limit: 80,               default: "",                    null: false
    t.string    "src",         limit: 80,               default: "",                    null: false
    t.string    "dst",         limit: 80,               default: "",                    null: false
    t.string    "dcontext",    limit: 80,               default: "",                    null: false
    t.string    "channel",     limit: 80,               default: "",                    null: false
    t.string    "dstchannel",  limit: 80,               default: "",                    null: false
    t.string    "lastapp",     limit: 80,               default: "",                    null: false
    t.string    "lastdata",    limit: 80,               default: "",                    null: false
    t.integer   "duration",    limit: 8,                                                null: false
    t.integer   "billsec",     limit: 8,                                                null: false
    t.string    "disposition", limit: 45,               default: "",                    null: false
    t.string    "amaflags",                                                             null: false
    t.string    "accountcode", limit: 20,               default: "",                    null: false
    t.string    "uniqueid",    limit: 32,               default: "",                    null: false
    t.string    "userfield",                            default: "",                    null: false
  end

  add_index "cdrs", ["uniqueid"], name: "index_cdrs_on_uniqueid", unique: true, using: :btree

  create_table "dialplans", force: true do |t|
    t.string  "context",  limit: 20,  default: "", null: false
    t.string  "exten",    limit: 20,  default: "", null: false
    t.integer "priority", limit: 2,   default: 0,  null: false
    t.string  "app",      limit: 20,  default: "", null: false
    t.string  "appdata",  limit: 128
    t.string  "network",  limit: 128,              null: false
  end

  create_table "dids", force: true do |t|
    t.string "did",     limit: 10, null: false
    t.string "app",     limit: 20, null: false
    t.string "app_arg", limit: 80
  end

  create_table "extensions", force: true do |t|
    t.integer  "user_id"
    t.string   "name",              limit: 80,  default: "",                 null: false
    t.string   "accountcode",       limit: 20
    t.string   "amaflags",          limit: 7
    t.string   "callgroup",         limit: 10
    t.string   "callerid",          limit: 80
    t.string   "canreinvite",       limit: 3,   default: "no",               null: false
    t.string   "context",           limit: 80
    t.string   "defaultip",         limit: 15
    t.string   "dtmfmode",          limit: 7,   default: "rfc2833",          null: false
    t.string   "fromuser",          limit: 80
    t.string   "fromdomain",        limit: 80
    t.string   "host",              limit: 31,  default: "dynamic",          null: false
    t.string   "insecure",          limit: 40,  default: "invite",           null: false
    t.string   "language",          limit: 2
    t.string   "mailbox",           limit: 50
    t.string   "md5secret",         limit: 80
    t.string   "nat",               limit: 20,  default: "auto_force_rport", null: false
    t.string   "permit",            limit: 95
    t.string   "mask",              limit: 95
    t.string   "pickupgroup",       limit: 10
    t.string   "port",              limit: 5,   default: "5060",             null: false
    t.string   "qualify",           limit: 3,   default: "yes",              null: false
    t.string   "restrictcid",       limit: 1
    t.string   "rtptimeout",        limit: 3
    t.string   "rtpholdtimeout",    limit: 3
    t.string   "secret",            limit: 80,  default: "",                 null: false
    t.string   "type",                          default: "friend",           null: false
    t.string   "username",          limit: 80,  default: "",                 null: false
    t.string   "disallow",          limit: 100, default: "all"
    t.string   "allow",             limit: 100, default: "all"
    t.string   "musiconhold",       limit: 100
    t.integer  "regseconds",        limit: 8
    t.string   "ipaddr",            limit: 45
    t.string   "regexten",          limit: 80
    t.string   "cancallforward",    limit: 3,   default: "yes"
    t.integer  "lastms",                        default: 0,                  null: false
    t.string   "defaultuser",       limit: 80,  default: "",                 null: false
    t.string   "fullcontact",       limit: 80
    t.string   "regserver",         limit: 30
    t.string   "useragent",         limit: 40
    t.string   "callbackextension", limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "extensions", ["defaultuser"], name: "index_extensions_on_defaultuser", unique: true, using: :btree
  add_index "extensions", ["name"], name: "index_extensions_on_name", unique: true, using: :btree

  create_table "locations", force: true do |t|
    t.integer "region"
    t.string  "name"
    t.string  "capital"
    t.string  "code"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
