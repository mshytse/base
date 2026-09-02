package terraform

# ~15s (httpbin caps delay at 10s, so two calls). Always passes.
resp1 := http.send({
	"method": "GET",
	"url": "https://httpbin.org/delay/10",
	"timeout": "15s",
	"raise_error": false,
})

resp2 := http.send({
	"method": "GET",
	"url": "https://httpbin.org/delay/5",
	"timeout": "10s",
	"raise_error": false,
})

deny[reason] {
	sum := resp1.status_code + resp2.status_code
	sum == -1
	reason := "sleep_15"
}
