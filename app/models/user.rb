require 'active_resource'
class User  < Api::Base
  self.site = 'http://diufvm31.unifr.ch:8090'
  #self.site = 'http://diufpc46.unifr.ch:8080'
  self.prefix = '/CyberCoachServer/resources/'

  self.user = "newuser1"
  self.password = "newuser"

  # To handle the issue with getting the resources by name (e.g. ../resources/sports/Running not ../sports/1)
  # you can set the primary_key to the created api class extending the ActiveResource::Base class.
  self.primary_key = 'username'

  # singular name of the resource. you only need to specify this if this class name is not the resource name
  self.element_name = 'user'

  class << self
    def instantiate_collection(collection, prefix_options = {}, b = nil)
      collection = collection['users'] if collection.instance_of?(Hash)
      collection.collect! { |record| instantiate_record(record, prefix_options) }
    end
  end

  schema do
    string 'uri', 'username', 'password', 'realname', 'email', 'subscriptions', 'partnerships'
    integer 'publicvisible'
  end

  #validates :lastName,  :presence => true, :length => { :maximum => 50 }
  #validates :firstName, :presence => true, :length => { :minimum => 6 }

end
