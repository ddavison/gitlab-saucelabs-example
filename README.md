# Running Selenium Tests against SauceLabs using GitLab CI

> This project serves as a minimal example of how to run UI tests against SauceLabs
> through GitLab CI using the Selenium Ruby bindings.

There are essentially two pieces required to get GitLab CI working with SauceLabs.

  1. A `.gitlab-ci.yml` file
  1. `sauce:options` passed as Desired Capabilities.
  
## How it works

### [`spec/saucelabs_spec.rb`]
In this example, [`spec/saucelabs_spec.rb`] 
is the main piece and is an RSpec test file.

This file contains one essential piece to getting SauceLabs configured:

```ruby
let(:capabilities) do
  {
    browser_name: :chrome,
    browser_version: '77.0',
    platform_name: 'macOS 10.14',
    'sauce:options': {
      username: ENV['SAUCELABS_USER'],
      accesskey: ENV['SAUCELABS_ACCESS_KEY'],
      tags: 'gitlab-saucelabs-example',
      name: 'gitlab-saucelabs-example',
      build: ENV['CI_JOB_ID']
    }
  }
end
```

Here we are configuring the [Desired Capabilities](https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities)
for Selenium as well as SauceLabs.

Under the `sauce:options` hash, we specify
[everything we'd like to configure SauceLabs](https://wiki.saucelabs.com/display/DOCS/Test+Configuration+Options) with.

- Username
- Access Key
- Tags / Name / Build for naming your build in SauceLabs

### [`.gitlab-ci.yml`]

Our [GitLab CI](https://docs.gitlab.com/ee/ci/README.html) configuration file contains one stage called `test`, that 
runs when we run the job manually.

> In an actual CI/CD environment, you'd most likely have `when:manual` removed, meaning that these
> tests will run against SauceLabs on every push / merge request to `master`.
>

[`spec/saucelabs_spec.rb`]: https://gitlab.com/ddavison/gitlab-saucelabs-example/tree/master/spec/saucelabs_spec.rb
[`.gitlab-ci.yml`]: https://gitlab.com/ddavison/gitlab-saucelabs-example/tree/master/.gitlab-ci.yml
