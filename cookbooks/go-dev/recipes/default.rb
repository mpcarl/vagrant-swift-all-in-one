# Copyright (c) 2018 SwiftStack, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

profile_file = "/home/#{node['username']}/.profile"

execute "update-gopath" do
  # /vagrant/go is synced to the user's $GOPATH in the Vagrantfile.
  command "echo 'export GOPATH=/vagrant/go' >> #{profile_file}"
  not_if "grep GOPATH=/vagrant/go #{profile_file}"
  action :run
end

execute "put-gobin-in-gopath" do
  command "echo 'export PATH=$PATH:/vagrant/go/bin' >> #{profile_file}"
  not_if "grep /vagrant/go/bin #{profile_file}"
  action :run
end

package "golang-go" do
  action :install
end
