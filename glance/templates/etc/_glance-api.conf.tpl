[DEFAULT]
debug = {{.Values.debug}}

registry_host = 127.0.0.1

log_config_append = /etc/glance/logging.conf

show_image_direct_url= True

#disable default admin rights for role 'admin'
admin_role = ''

rpc_response_timeout = {{ .Values.rpc_response_timeout | default .Values.global.rpc_response_timeout | default 300 }}
rpc_workers = {{ .Values.rpc_workers | default .Values.global.rpc_workers | default 1 }}

wsgi_default_pool_size = {{ .Values.wsgi_default_pool_size | default .Values.global.wsgi_default_pool_size | default 100 }}
max_pool_size = {{ .Values.max_pool_size | default .Values.global.max_pool_size | default 5 }}
max_overflow = {{ .Values.max_overflow | default .Values.global.max_overflow | default 10 }}

[database]
connection = postgresql://{{.Values.db_user}}:{{.Values.db_password}}@{{include "glance_db_host" .}}:{{.Values.postgres.port_public}}/{{.Values.db_name}}

[keystone_authtoken]
auth_uri = {{.Values.global.keystone_api_endpoint_protocol_internal}}://{{include "keystone_api_endpoint_host_internal" .}}:{{ .Values.global.keystone_api_port_internal }}
auth_url = {{.Values.global.keystone_api_endpoint_protocol_admin}}://{{include "keystone_api_endpoint_host_admin" .}}:{{ .Values.global.keystone_api_port_admin }}/v3
auth_type = v3password
username = {{ .Values.global.glance_service_user }}
password = {{ .Values.global.glance_service_password }}
user_domain_name = {{.Values.global.keystone_service_domain}}
project_name = {{.Values.global.keystone_service_project}}
project_domain_name = {{.Values.global.keystone_service_domain}}
memcache_servers = {{include "memcached_host" .}}:{{.Values.global.memcached_port_public}}
insecure = True


[paste_deploy]
flavor = keystone


[oslo_middleware]
enable_proxy_headers_parsing = true

[glance_store]

stores = swift,file

default_store = {{.Values.default_store}}

filesystem_store_datadir = /glance_store

swift_store_region={{.Values.global.region}}
swift_store_auth_insecure = True
swift_store_create_container_on_put = True
swift_store_multi_tenant = {{.Values.swift_multi_tenant}}

default_swift_reference = swift-global
swift_store_config_file=/etc/glance/swift-store.conf

swift_store_use_trusts=True

swift_store_large_object_size = {{ .Values.swift_store_large_object_size | default .Values.global.swift_store_large_object_size | default 5120 }}
swift_store_large_object_chunk_size = {{ .Values.swift_store_large_object_chunk_size | default .Values.global.swift_store_large_object_chunk_size | default 200 }}

[oslo_messaging_notifications]
driver = noop
