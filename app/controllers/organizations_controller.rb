class OrganizationsController < InheritedResources::Base
  before_filter :authenticate_user!, only: [:new, :create, :edit]
end
