package terraform

# ~20s (two 10s delays). Always fails (soft-mandatory).
resp1 := http.send({
	"method": "GET",
	"url": "https://httpbin.org/delay/10",
	"timeout": "15s",
	"raise_error": false,
})

resp2 := http.send({
	"method": "GET",
	"url": "https://httpbin.org/delay/10",
	"timeout": "15s",
	"raise_error": false,
})

deny[reason] {
	reason := sprintf("sleep_20 failed after delay (status=%v,%v)", [resp1.status_code, resp2.status_code])
}
