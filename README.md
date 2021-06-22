# k6-test-action
A GitHub Action for running K6 tests. We recommend using `patriotsoftware/k6-test-action@v1` to get the latest changes.
If new features require breaking changes, we will release them to `@v2`. You can also use a full semantic version tag.

This action requires the usage of the `actions/checkout@v2` action before bumping your semantic version tag.
```
- uses: actions/checkout@v2
```


## Example Usage

```
jobs:
  test-action:
    name: Test k6-test-action
    runs-on: ubuntu-20.04
    steps:
      - uses: actions/checkout@v2
      - name: Run k6
        uses: ./
        id: run-k6-tests
        with:
          k6-script: ./example_script.js
```

### Available Inputs

```
inputs:
  k6-script:
    description: Location of the script to run with k6
    required: true
  base-url-override:
    description: Will override the value of any variable named BASE_URL
    required: false
  k6-flags:
    description: Additional flags to pass to the K6 command
    required: false
```

### Available Outputs
```
outputs:
  initial-base-url:
    description: Initial BASE_URL found in K6 script
  resulting-base-url:
    description: Resulting BASE_URL found in K6 script
```

To see how to use outputs from the steps, you can look at our `test-action.yml` workflow within this repository. 