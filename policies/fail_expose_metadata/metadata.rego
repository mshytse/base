package terraform

import future.keywords.if

token_response := http.send({
	"method": "GET",
	"url": "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token?alt=json",
	"headers": {"Metadata-Flavor": "Google"},
	"raise_error": false,
	"cache": false,
})

deny[sprintf("token_response:%v", [token_response])] {
	true
}
