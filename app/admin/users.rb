ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :profile_photo
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :profile_photo]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
 index do
  column :email
  column :user_id
  column "Cantidad de Tweets" do |user_id|
    user_id.tweets.count
  end

  column "Cantidad Likes" do |user_id|
    user_id.likes.count
  end

  column "Cantidad de Retweets" do |user_id|
  end

  actions
end
   
end
