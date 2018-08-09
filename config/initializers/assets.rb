# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( sb-admin.css sb-admin.js dataTables.bootstrap4.js dataTables.bootstrap4.css datatables-demo.coffee)

controllers = %w(users whatspp_messages registrations)

# Controller CSS Assets
Rails.application.config.assets.precompile += controllers.map{|x| x+".scss"}

# Controller JS Assets
Rails.application.config.assets.precompile += controllers.map{|x| x+".coffee"}