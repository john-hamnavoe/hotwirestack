# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                                       Controller#Action
#                                                 /assets                                                                                           Propshaft::Server
#                              about_index GET    /about/index(.:format)                                                                            about#index
#                                     root GET    /                                                                                                 home#index
#                                documents GET    /documents(.:format)                                                                              documents#index
#                                          POST   /documents(.:format)                                                                              documents#create
#                             new_document GET    /documents/new(.:format)                                                                          documents#new
#                            edit_document GET    /documents/:id/edit(.:format)                                                                     documents#edit
#                                 document GET    /documents/:id(.:format)                                                                          documents#show
#                                          PATCH  /documents/:id(.:format)                                                                          documents#update
#                                          PUT    /documents/:id(.:format)                                                                          documents#update
#                                          DELETE /documents/:id(.:format)                                                                          documents#destroy
#                                   boards GET    /boards(.:format)                                                                                 boards#index
#                                          POST   /boards(.:format)                                                                                 boards#create
#                                new_board GET    /boards/new(.:format)                                                                             boards#new
#                               edit_board GET    /boards/:id/edit(.:format)                                                                        boards#edit
#                                    board GET    /boards/:id(.:format)                                                                             boards#show
#                                          PATCH  /boards/:id(.:format)                                                                             boards#update
#                                          PUT    /boards/:id(.:format)                                                                             boards#update
#                                          DELETE /boards/:id(.:format)                                                                             boards#destroy
#                       index_view_filters GET    /index_views/:index_view_id/filters(.:format)                                                     index_views/filters#index
#                                          POST   /index_views/:index_view_id/filters(.:format)                                                     index_views/filters#create
#                    new_index_view_filter GET    /index_views/:index_view_id/filters/new(.:format)                                                 index_views/filters#new
#                   edit_index_view_filter GET    /index_views/:index_view_id/filters/:id/edit(.:format)                                            index_views/filters#edit
#                        index_view_filter GET    /index_views/:index_view_id/filters/:id(.:format)                                                 index_views/filters#show
#                                          PATCH  /index_views/:index_view_id/filters/:id(.:format)                                                 index_views/filters#update
#                                          PUT    /index_views/:index_view_id/filters/:id(.:format)                                                 index_views/filters#update
#                                          DELETE /index_views/:index_view_id/filters/:id(.:format)                                                 index_views/filters#destroy
#                 index_view_active_filter PATCH  /index_views/:index_view_id/active_filter(.:format)                                               index_views/active_filter#update
#                                          PUT    /index_views/:index_view_id/active_filter(.:format)                                               index_views/active_filter#update
#                              index_views GET    /index_views(.:format)                                                                            index_views#index
#                                          POST   /index_views(.:format)                                                                            index_views#create
#                           new_index_view GET    /index_views/new(.:format)                                                                        index_views#new
#                          edit_index_view GET    /index_views/:id/edit(.:format)                                                                   index_views#edit
#                               index_view GET    /index_views/:id(.:format)                                                                        index_views#show
#                                          PATCH  /index_views/:id(.:format)                                                                        index_views#update
#                                          PUT    /index_views/:id(.:format)                                                                        index_views#update
#                                          DELETE /index_views/:id(.:format)                                                                        index_views#destroy
#               index_view_column_position PATCH  /index_view_columns/:index_view_column_id/position(.:format)                                      index_view_columns/position#update
#                                          PUT    /index_view_columns/:index_view_column_id/position(.:format)                                      index_view_columns/position#update
#                       rails_health_check GET    /up(.:format)                                                                                     rails/health#show
#         turbo_recede_historical_location GET    /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
#         turbo_resume_historical_location GET    /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
#        turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
#            rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#            rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
# new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create

Rails.application.routes.draw do
  get "about/index"
  root "home#index"

  resources :documents
  resources :boards

  resources :index_views do
    resources :filters, only: [:index, :show, :new, :create, :edit, :update, :destroy], controller: "index_views/filters"
    resource :active_filter, only: [:update], controller: "index_views/active_filter"
  end
  resources :index_view_columns, only: [] do
    resource :position, only: [:update], controller: "index_view_columns/position"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
