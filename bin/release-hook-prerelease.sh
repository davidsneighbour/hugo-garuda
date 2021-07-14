#!/bin/bash

declare -a MODULES=(
  'github.com/dnb-org/debugprint'
  'github.com/dnb-org/garuda'
  'github.com/dnb-org/components/favicon'
  'github.com/dnb-org/components/functions'
  'github.com/dnb-org/components/netlification'
  'github.com/dnb-org/components/opensearch'
  'github.com/dnb-org/components/pwa'
  'github.com/dnb-org/components/renderhooks'
  'github.com/dnb-org/components/robots'
  'github.com/dnb-org/components/search-algolia'
  'github.com/dnb-org/components/sitemap'
  'github.com/dnb-org/shortcodes'
  'github.com/dnb-org/blocks/bootstrap5'
  'github.com/dnb-org/libraries/bootstrap5'
  'github.com/dnb-org/libraries/bootstrap-icons'
  'github.com/dnb-org/libraries/dayjs'
)
declare -a REPLACE=(
  '/home/patrick/Projects/dnb-hugo/debugprint'
  '/home/patrick/Projects/dnb-hugo/garuda'
  '/home/patrick/Projects/dnb-hugo/components/favicon'
  '/home/patrick/Projects/dnb-hugo/components/functions'
  '/home/patrick/Projects/dnb-hugo/components/netlification'
  '/home/patrick/Projects/dnb-hugo/components/opensearch'
  '/home/patrick/Projects/dnb-hugo/components/pwa'
  '/home/patrick/Projects/dnb-hugo/components/renderhooks'
  '/home/patrick/Projects/dnb-hugo/components/robots'
  '/home/patrick/Projects/dnb-hugo/components/search-algolia'
  '/home/patrick/Projects/dnb-hugo/components/sitemap'
  '/home/patrick/Projects/dnb-hugo/shortcodes'
  '/home/patrick/Projects/dnb-hugo/blocks/bootstrap5'
  '/home/patrick/Projects/dnb-hugo/libraries/bootstrap5'
  '/home/patrick/Projects/dnb-hugo/libraries/bootstrap-icons'
  '/home/patrick/Projects/dnb-hugo/libraries/dayjs'
)

for i in "${MODULES[@]}"
do
  go mod edit -dropreplace "$i"
done

hugo mod get -u ./...
hugo mod tidy

git add --force go.mod
git add --force go.sum

for i in "${!MODULES[@]}"; do
  go mod edit -replace "${MODULES[$i]}"="${REPLACE[$i]}"
done
