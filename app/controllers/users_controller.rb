class UsersController < ApplicationController
    def index
        if params[:full_name].nil? || params[:full_name] == ""
            @users = User.where('id != ?', current_user.id)
        else
            names = params[:full_name].split(" ")
            if names.length > 1
                @users = User.where('id != ? AND first_name = ? AND last_name = ?',  current_user.id, names[0] , names[1])
            else
                @users = User.where('id != ? AND (first_name = ? OR last_name = ?)',  current_user.id, names[0], names[0])
            end
        end
    end

    def show
        @user = User.find(params[:id])

        #for button showing
        @outgoing = current_user.outgoing
        @incomming =  current_user.incomming
        @outgoing = @outgoing.select {|fr|  fr.to_id == params[:id]}
        @incomming = @incomming.select {|fr|  fr.from_id == params[:id]}


        if request.post?
            case params[:do]
                when "friend_request"
                    FriendRequest.create(from_id: current_user.id, to_id: params[:id], accepted: false)
                when "accept"
                    if @outgoing.empty?
                        @incomming.each {|item| item.update(accepted: true)}
                    else
                        @outgoing.each {|item| item.update(accepted: true)}
                    end
                end
                redirect_to @user
        end
    end

    def my_profile
        if !params[:user].nil?
            current_user.image.attach(params[:user][:image])
        end
    end 
end
