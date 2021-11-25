<h1 align="center">
  <br>
  nvim-dvc
  <br>
</h1>

<h2 align="center">
  <img alt="PR" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat"/>
  <img alt="Lua" src="https://img.shields.io/badge/lua-%232C2D72.svg?&style=flat&logo=lua&logoColor=white"/>
</h2>

<h4 align="center">The DVC plugin for neovim</h4>

<h3 align="center">
  <a href="#Installation">Installation</a> •
  <a href="#Usage">Usage</a> •
  <a href="#Customisation">Customisation</a> •
  <a href="#Feedback">Feedback</a>
</h3>

If only one could interact with [DVC](https://dvc.org) from within neovim. Oh wait, `nvim-dvc` does just that!

## Installation
Install it using your favourite plugin manager; for instance if you are using vim-plug
```
Plug 'gennaro-tedesco/nvim-dvc'
```
Notice that this plugin makes use of bash core utils and `jq` internally (to parse DVC outputs), so it is recommended to have them installed.

## Usage
`nvim-dvc` populates the location list with DVC stages and metrics files for easy access to models performances, or it enables to execute pipelines making use of prompt autocompletion, or it quickly opens up the DVC configurations.

![demo](https://user-images.githubusercontent.com/15387611/143473863-2863ffe9-9ac9-4057-a860-e21f97f2a680.gif)

Default commands

| command            | description
|:------------------ |:-------------
|`DVCStages`         | populate the location list with DVC stages
|`DVCMetrics`        | populate the location list with DVC metrics files
|`DVCRepro`          | prompt autocompletion menu (after `<Tab>`) and execute stage
|`DVCFiles`          | populate the location list with all DVC tracked files


## Customisation
If you prefer to populate the quickfix windown rather than the location list simply override
```
lua require('nvim-dvc.config').use_quickfix = true
```

## Feedback and see also
Do not forget that the best way to browse metrics files and json in general is [nvim-jqx](https://github.com/gennaro-tedesco/nvim-jqx).

If you find this plugin useful consider awarding it a ⭐, it is a great way to give feedback! Otherwise, any additional suggestions or merge request is warmly welcome!
