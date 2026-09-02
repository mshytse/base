package terraform

# ~10s. Always fails (advisory).
resp := http.send({
	"method": "GET",
	"url": "https://httpbin.org/delay/10",
	"timeout": "15s",
	"raise_error": false,
})

deny[reason] {
	reason := sprintf("sleep_10 failed after delay (status=%v)", [resp.status_code])
}
