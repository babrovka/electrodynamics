ActiveAdmin.register User do     
  index do                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :firstname 
      f.input :lastname
      f.input :role, :as => :select, :collection => User::ROLES.map { |r| [  I18n.t(r), r ] }
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end      
  
  show do |user|
    attributes_table do
      row :email
      row :firstname
      row :lastname
      row :role do
        I18n.t(user.role)
      end
    end 
  end
  
  controller do

    def update
      @user = User.find(params[:id])

      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
      end

      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to admin_user_path(@user) }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

  end
                            
end                                   
