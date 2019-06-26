workflow "Test my code" {
  on = "push"
  resolves = ["codecov"]
}

action "npm ci" {
  uses = "docker://node:10-alpine"
  runs = "npm"
  args = "ci"
}

action "npm test" {
  needs = "npm ci"
  uses = "docker://node:10-alpine"
  runs = "npm"
  args = "test"
}

action "codecov" {
  needs = "npm test"
  uses = "docker://node:10"
  runs = "npx"
  args = "codecov"
  secrets = ["CODECOV_TOKEN"]
}

workflow "Update activity" {
  resolves = ["update-gist"]
  on = "schedule(*/10 * * * *)"
}

action "update-gist" {
  uses = "JasonEtco/activity-box@master"
  secrets = [
    "9d6b50aa41f485a8f9ee4a785d1857c378009a2c",
    "9d6b50aa41f485a8f9ee4a785d1857c378009a2c"
  ]
  env = {
    GH_USERNAME = "prateekguptaiiitk"
    GIST_ID = "fdca784699acdc2106d8ff8a8c3f3c8b"
  }
}
