---
sidebar_position: 4
---

# Technologies

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

## Technical Requirements

You need to Install these

- [Visual Studio Code](https://code.visualstudio.com/) coding editor.
- [Roblox Studio](https://create.roblox.com/) for developing roblox games.
- [aftman](https://github.com/LPGhatguy/aftman) tool chain manager.
- [git](https://git-scm.com/) version control system.

:::tip

You also need to have a GitHub account. Don't have one, create one at [GitHub](https://github.com/)

:::

## Important Visual Studio Code Extensions

- [Luau Language Server](https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.luau-lsp)
- [Selene](https://marketplace.visualstudio.com/items?itemName=Kampfkarren.selene-vscode) Lua Linter.
- [StyLua](https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.stylua) Lua formatter.

## Recommended Visual Studio Code Extensions

- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
- [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
- [BetterComments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)
- [CodeSnap](https://marketplace.visualstudio.com/items?itemName=adpyke.codesnap)

## Documentation

[moonwave](https://github.com/evaera/moonwave) used to generate a website for github pages from doc comments.

See the [moonwave docs](https://eryn.io/moonwave/) for doc commenting guide.

:::tip

You do not necessarily need to install moonwave as GitHub actions is used to install it and generate a website on github push. Although, if you want to preview the website for your branch of the repository you will need to install moonwave and [node](https://nodejs.org/en/download/prebuilt-installer/current).

:::

## Tools Installed through Aftman

aftman will install these for you. (See aftman.toml)

- [rojo](https://github.com/rojo-rbx/rojo) supports text editors and version control for **Roblox Studio**.
- [selene](https://github.com/Kampfkarren/selene) Lua linter (Anaylzes src for errors) in text editor and GitHub Actions.
- [StyLua](https://github.com/JohnnyMorganz/StyLua) Lua code formatter.
- [rbxcloud](https://github.com/Sleitnick/rbxcloud) CLI and library for Roblox Open Cloud API. Publishes rbxlx file to roblox.com on repository push using GitHub Actions.
- [Wally](https://github.com/UpliftGames/wally) Package manager for roblox projects.

## Packages managed by Wally (See wally.toml)

### Shared Dependencies

- [react-lua](https://wally.run/package/jsdotlua/react)
- [react-roblox](https://wally.run/package/jsdotlua/react-roblox)
- [promise](https://wally.run/package/evaera/promise)
- [janitor](https://wally.run/package/howmanysmall/janitor)

### Server Dependencies

- [suphis-datastore-module](https://wally.run/package/uiscript/suphis-datastore-module)

## GitHub Actions

Selene is run to check for errors, StyLua is run to ensure code format is consistent throughout the project. If either Selene or StyLua return an error, you will be unable to merge your changes into the repository.

## GitHub

Use Pull requests

# Docs TODO

:::danger Link Specific Versions

There may be errors later down the line, I probably should have included specific versions of technologies to install, but thats a problem for another day.

:::
