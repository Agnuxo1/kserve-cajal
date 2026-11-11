# CAJAL KServe Configuration

A configuration prototype for serving CAJAL scientific-writing inference with KServe and an Ollama-based container.

<!-- impact-note:start -->
<sub><strong>Efficiency and practical value.</strong> The container recipe and KServe manifest provide a reusable starting point for packaging CAJAL inference and expressing replica, concurrency and hardware limits. This can reduce repeated deployment configuration and make proposed resource allocation easier to inspect. The <a href="inferenceservice.yaml">manifest</a> is a prototype configuration; serving compatibility and operational efficiency require validation on an actual deployment.</sub>
<!-- impact-note:end -->

## Repository contents

- [Dockerfile](Dockerfile): container recipe that obtains the model and starts Ollama.
- [inferenceservice.yaml](inferenceservice.yaml): proposed KServe service, resource limits and configuration.
- [test.sh](test.sh): example requests for a configured endpoint.

These files are deployment starting points. A compatible model-serving contract and successful live deployment have not been established by this documentation review.
