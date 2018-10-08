#!/usr/bin/env bats

load _helpers

@test "server-external/Role: disabled by default" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/server-external-role.yaml  \
      . | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "false" ]
}

@test "server-external/Role: enable with global.enabled false" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/server-external-role.yaml  \
      --set 'global.enabled=false' \
      --set 'external.enabled=true' \
      --set 'rbac.enabled=true' \
      . | tee /dev/stderr |
      yq -s 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "true" ]
}

@test "server-external/Role: disable with external.enabled" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/server-external-role.yaml  \
      --set 'external.enabled=false' \
      --set 'rbac.enabled=true' \
      . | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "false" ]
}

@test "server-external/Role: disable with rbac.enabled" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/server-external-role.yaml  \
      --set 'external.enabled=true' \
      --set 'rbac.enabled=false' \
      . | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "false" ]
}

@test "server-external/Role: disable with global.enabled" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/server-external-role.yaml  \
      --set 'global.enabled=false' \
      . | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "false" ]
}
