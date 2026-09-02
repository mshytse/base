package terraform

# ~5s. Always passes.
resp := http.send({
	"method": "GET",
	"url": "https://httpbin.org/delay/5",
	"timeout": "10s",
	"raise_error": false,
})

deny[reason] {
	resp.status_code == -1
	reason := "sleep_5"
}
