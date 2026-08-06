package terraform

import future.keywords.if

# Verify http.send works against a public endpoint (OPA 0.58.0)
response := http.send({
	"method": "GET",
	"url": "https://httpbin.org/get",
	"raise_error": false,
	"cache": false,
})

deny[sprintf("http_send status=%v body=%v", [response.status_code, response.body])] {
	true
}
