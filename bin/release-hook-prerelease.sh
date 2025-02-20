#!/bin/bash

declare -a MODULES=(
  'github.com/davidsneighbour/debugprint'
  'github.com/davidsneighbour/garuda'
  'github.com/davidsneighbour/components/favicon'
  'github.com/davidsneighbour/components/functions'
  'github.com/davidsneighbour/components/netlification'
  'github.com/davidsneighbour/components/opensearch'
  'github.com/davidsneighbour/components/pwa'
  'github.com/davidsneighbour/components/renderhooks'
  'github.com/davidsneighbour/components/robots'
  'github.com/davidsneighbour/components/search-algolia'
  'github.com/davidsneighbour/components/sitemap'
  'github.com/davidsneighbour/shortcodes'
  'github.com/davidsneighbour/blocks/bootstrap5'
  'github.com/davidsneighbour/libraries/bootstrap5'
  'github.com/davidsneighbour/libraries/bootstrap-icons'
  'github.com/davidsneighbour/libraries/dayjs'
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
