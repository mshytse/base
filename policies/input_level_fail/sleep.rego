package terraform

# Stall ~10s so copy vs contribute timing is easy to see. Always passes.
resp := http.send({
	"method": "GET",
	"url": "https://httpbin.org/delay/10",
	"timeout": "15s",
	"raise_error": false,
})

deny[reason] {
	resp.status_code == -1
	reason := "sleep"
}
