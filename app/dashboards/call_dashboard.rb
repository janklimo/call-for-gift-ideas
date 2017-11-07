require "administrate/base_dashboard"

class CallDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    slug: Field::String,
    recipient_name: Field::String,
    recipient_email: Field::String,
    recipient_sex: Enum.with_options(searchable: false),
    sender_name: Field::String,
    sender_email: Field::String,
    status: Enum.with_options(searchable: false),
    preferences: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :slug,
    :recipient_name,
    :recipient_email,
    :recipient_sex,
    :status,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :slug,
    :recipient_name,
    :recipient_email,
    :recipient_sex,
    :sender_name,
    :sender_email,
    :status,
    :preferences,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :slug,
    :recipient_name,
    :recipient_email,
    :recipient_sex,
    :sender_email,
    :status,
    :preferences,
  ].freeze

  # Overwrite this method to customize how calls are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(call)
  #   "Call ##{call.id}"
  # end
end
