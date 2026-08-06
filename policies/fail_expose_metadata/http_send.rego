package terraform

import future.keywords.if

# Verify http.send works against a public endpoint (OPA 0.58.0)
response := http.send({
	"method": "GET",
	"url": "https://www.random.org/integers/?num=1&min=0&max=9&base=10&col=1&format=plain",
	"raise_error": false,
	"cache": false,
})

deny[sprintf("http_send status=%v body=%v", [response.status_code, response.raw_body])] {
	true
}
