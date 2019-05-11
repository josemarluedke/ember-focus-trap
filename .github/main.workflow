workflow "Push" {
  resolves = ["Draft Release"]
  on = "push"
}

action "Draft Release" {
  uses = "toolmantim/release-drafter@v5.1.1"
  secrets = ["GITHUB_TOKEN"]
}
