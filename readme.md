# Static site generation setup with Nanoc

This is intended to be a workflow setup for Github pages. To use locally, clone the repo as a hidden dir in the root of your docs and build the site.

```sh
cd docs/
git clone https://github.com/cacc-ufpa/webgen-nanoc .nanoc
cd .nanoc
bundle install
bundle exec nanoc compile
```

## Github pages worflow

```yaml
name: Deploy Nanoc Output to GitHub Pages

on:
  push:
    # Update this branch name.
    branches: ["docs-branch"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Clone Repo with Nanoc Config
        uses: actions/checkout@v4
        with:
          # Or put your fork here, idk.
          repository: cacc-ufpa/webgen-nanoc
          path: .nanoc

      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '4.0'
          bundler-cache: true
          working-directory: .nanoc

      - name: Generate style for md codeblocks
        run: bundle exec rougify style github > layouts/syntax.css
        working-directory: .nanoc

      - name: Compile Nanoc site
        run: bundle exec nanoc compile
        working-directory: .nanoc

      - name: Setup GitHub Pages
        uses: actions/configure-pages@v4

      - name: Upload compiled output
        uses: actions/upload-pages-artifact@v3
        with:
          path: '.nanoc/output/'

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

