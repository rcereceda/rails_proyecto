ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :email, :password

  controller do 
    def update
      if (params[:user][:password].blank? && params[:user][:password_confirmation].blank?)
        params[:user].delete("password")
        params[:user].delete("password_confirmation") 
      end
      super
    end

    def scoped_collection
      User.includes(:user_services, :services) 
    end
  end

  index do
    column :id
    column :email 
    column :created_at
    column :user_services do |user|
      user.user_services.collect(&:service_name).join(",")
    end
    actions
  end

  form do |f|
    inputs "Agrega un usuario" do
      input :email
      input :password
    end
    actions
  end

end
