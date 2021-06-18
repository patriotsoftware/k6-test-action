# k6-test-action
A GitHub Action for running K6 tests. We recommend using `patriotsoftware/k6-test-action@v1` to get the latest changes.
If new features require breaking changes, we will release them to `@v2`. You can also use a full semantic version tag.

This action requires the usage of the `actions/checkout@v2` action before bumping your semantic version tag.
```
- uses: actions/checkout@v2
```

In order to bump a specific part of the version, you can use `#patch` (which is the default), `#minor`, or `#major` in your commit message. 

When pushing the tags it will tag both the full semantic version, as well as the shortened major version number, prefixed with `v`. For example, if your commit states:

```
"Added this new feature #minor"
```

Assuming your previously tagged version is `v1.0.1`, your commit would be tagged with:
- `v1.1.0`
- `v1`

## Example Usage

```
- uses: actions/checkout@v2
  with:
    fetch-depth: 0
- uses: patriotsoftware/k6-test-action@v1
```

### Additional Inputs

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