class CreateSchema < ActiveRecord::Migration

  def change
    create_table "acquisition_categories", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "acquisition_categories_project_areas", :id => false, :force => true do |t|
      t.integer  "acquisition_category_id"
      t.integer  "project_area_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "activity_categories", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.string   "alias"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "activity_categories_project_areas", :id => false, :force => true do |t|
      t.integer  "activity_category_id"
      t.integer  "project_area_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "admin_settings", :force => true do |t|
      t.string   "key"
      t.text     "value"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "attribute_modules", :force => true do |t|
      t.integer  "attribute_id"
      t.integer  "pemodule_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "is_mandatory"
      t.string   "in_out"
      t.text     "description"
      t.boolean  "custom_attribute"
      t.string   "string_data_low"
      t.string   "string_data_most_likely"
      t.string   "string_data_high"
      t.integer  "numeric_data_low"
      t.integer  "numeric_data_most_likely"
      t.integer  "numeric_data_high"
      t.date     "date_data_low"
      t.date     "date_data_most_likely"
      t.date     "date_data_high"
    end

    create_table "attributes", :force => true do |t|
      t.string   "name"
      t.string   "alias"
      t.text     "description"
      t.integer  "attr_type"
      t.text     "options"
      t.text     "aggregation"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "components", :force => true do |t|
      t.integer  "wbs_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "ancestry"
      t.boolean  "is_root"
      t.integer  "work_element_type_id"
      t.string   "name"
      t.integer  "project_link"
      t.integer  "position"
    end

    add_index "components", ["ancestry"], :name => "index_components_on_ancestry"

    create_table "currencies", :force => true do |t|
      t.string   "name"
      t.string   "alias"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "event_types", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.string   "icon_url"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "events", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.date     "start_date"
      t.date     "end_date"
      t.integer  "event_type_id"
      t.integer  "project_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "groups", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.string   "code_group"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "groups_permissions", :id => false, :force => true do |t|
      t.integer  "group_id"
      t.integer  "permission_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "groups_users", :id => false, :force => true do |t|
      t.integer  "group_id"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "help_types", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "helps", :force => true do |t|
      t.text     "content"
      t.integer  "help_type_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "help_code"
    end

    create_table "labor_categories", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "labor_categories_project_areas", :id => false, :force => true do |t|
      t.integer  "labor_category_id"
      t.integer  "project_area_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "languages", :force => true do |t|
      t.string   "name"
      t.string   "locale"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "master_settings", :force => true do |t|
      t.string   "key"
      t.text     "value"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "module_project_attributes", :force => true do |t|
      t.integer  "attribute_id"
      t.string   "string_data_low"
      t.string   "string_data_most_likely"
      t.string   "string_data_high"
      t.float    "numeric_data_low"
      t.float    "numeric_data_most_likely"
      t.float    "numeric_data_high"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "links"
      t.boolean  "is_mandatory"
      t.string   "in_out"
      t.text     "description"
      t.integer  "module_project_id"
      t.boolean  "custom_attribute"
      t.date     "date_data_low"
      t.date     "date_data_most_likely"
      t.date     "date_data_high"
      t.boolean  "undefined_attribute"
      t.integer  "component_id"
    end

    add_index "module_project_attributes", ["links"], :name => "index_attribute_projects_on_links"

    create_table "module_projects", :force => true do |t|
      t.integer  "pemodule_id"
      t.integer  "project_id"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "nb_input_attr"
      t.integer  "nb_output_attr"
    end

    create_table "organization_labor_categories", :force => true do |t|
      t.integer  "organization_id"
      t.integer  "labor_category_id"
      t.string   "level"
      t.string   "name"
      t.text     "description"
      t.float    "cost_per_hour"
      t.integer  "base_year"
      t.integer  "currency_id"
      t.float    "hour_per_day"
      t.integer  "days_per_year"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "organizations", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "organizations_users", :id => false, :force => true do |t|
      t.integer "user_id"
      t.integer "organization_id"
    end

    create_table "pemodules", :force => true do |t|
      t.string   "title"
      t.string   "alias"
      t.text     "description"
      t.integer  "type_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "compliant_component_type"
      t.boolean  "is_typed"
    end

    create_table "permissions", :force => true do |t|
      t.string   "object_associated"
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "is_permission_project"
      t.string   "ancestry"
    end

    add_index "permissions", ["ancestry"], :name => "index_permissions_on_ancestry"

    create_table "permissions_project_security_levels", :id => false, :force => true do |t|
      t.integer  "permission_id"
      t.integer  "project_security_level_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "permissions_users", :id => false, :force => true do |t|
      t.integer  "permission_id"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "platform_categories", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "platform_categories_project_areas", :id => false, :force => true do |t|
      t.integer  "platform_category_id"
      t.integer  "project_area_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "project_areas", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "project_areas_project_categories", :id => false, :force => true do |t|
      t.integer  "project_category_id"
      t.integer  "project_area_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "project_areas_work_element_types", :id => false, :force => true do |t|
      t.integer  "project_area_id"
      t.integer  "work_element_type_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "project_categories", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "project_categories_project_areas", :id => false, :force => true do |t|
      t.integer  "project_category_id"
      t.integer  "project_area_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "project_ressources", :force => true do |t|
      t.string "name"
    end

    create_table "project_securities", :force => true do |t|
      t.integer  "project_id"
      t.integer  "user_id"
      t.integer  "project_security_level_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "project_security_levels", :force => true do |t|
      t.string   "name"
      t.integer  "level"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "project_staffs", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "projects", :force => true do |t|
      t.string   "title"
      t.text     "description"
      t.string   "alias"
      t.string   "state"
      t.date     "start_date"
      t.integer  "organization_id"
      t.integer  "project_area_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "project_category_id"
      t.integer  "platform_category_id"
      t.integer  "acquisition_category_id"
      t.boolean  "is_model"
    end

    create_table "projects_users", :id => false, :force => true do |t|
      t.integer  "project_id"
      t.integer  "user_id"
      t.text     "settings"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "results", :force => true do |t|
      t.integer "functionality_id"
      t.integer "step"
      t.text    "content"
    end

    create_table "roles_users", :id => false, :force => true do |t|
      t.integer  "user_id"
      t.integer  "role_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "users", :force => true do |t|
      t.string   "email"
      t.string   "password_hash"
      t.string   "password_salt"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "user_name"
      t.string   "first_name"
      t.string   "surename"
      t.string   "initials"
      t.date     "last_login"
      t.date     "previous_login"
      t.string   "time_zone"
      t.string   "auth_token"
      t.string   "password_reset_token"
      t.datetime "password_reset_sent_at"
      t.integer  "language_id"
      t.boolean  "is_super_admin"
      t.string   "type_auth"
      t.string   "user_status"
      t.text     "ten_latest_projects"
      t.integer  "organization_id"
    end

    create_table "wbs", :force => true do |t|
      t.integer  "project_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "work_element_types", :force => true do |t|
      t.string   "name"
      t.string   "alias"
      t.text     "description"
      t.integer  "project_area_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
