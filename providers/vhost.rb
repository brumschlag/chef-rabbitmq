# providers/vhost.rb
#
# Author: Simple Finance <ops@simple.com>
# License: Apache License, Version 2.0
#
# Copyright 2013 Simple Finance Technology Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Create and delete virtualhosts

include RabbitMQ::Management

def initialize(new_resource, run_context)
  super
  
  @vhost   = new_resource.vhost
end

action :add do
  @client  = rabbitmq_client
  @client.create_vhost(@vhost)
  @client.update_permissions_of(
    @vhost,
    rabbitmq_admin_user,
    read: '',
    write: '',
    configure: '.*'
  )
end

action :delete do
  @client  = rabbitmq_client
  @client.delete_vhost(@vhost)
end
