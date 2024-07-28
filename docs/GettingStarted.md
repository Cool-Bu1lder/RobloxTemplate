---
sidebar_position: 3
---

# Getting Started

This is a walkthrough for setting up the project. For Linux users, Roblox Studio is not officially supported on Linux, but there are some work arounds that will not be explored on this page.

:::info

I recommend installing [Windows Terminal](https://www.microsoft.com/store/productId/9N0DX20HK701?ocid=pdpshare) if you are going to use GitHub CLI.

:::

## 1. Install [Visual Studio Code](https://code.visualstudio.com/)

Click **Download** in the nav bar.

![vscode1](/img/vscode1.png)

Download the correct version of Visual Studio Code for the operating system you are using.

![vscode1](/img/vscode2.png)

Once the Visual Studio Code Setup executable file has downloaded, click it and install visual studio code.

## 2. Install [Git](https://git-scm.com/)

Click **Downloads**

![git1](/img/git1.png)

Download the correct version of Git for the operating system you are using.

![git2](/img/git2.png)

Once the file has downloaded click on it.

Allow Git to make changes on your device.

Click **Next** after reading the license information.

Click **Next** and leave the install location in the default location.

Click **Next**, leave the components as they are already selected.

Use Visual Studio Code as Git's default editor, click **Next**.

Let Git decide, click **Next**.

Select _Git from the command line and also from 3rd-party software_, click **Next**.

Keep click **Next** and then click **Install**, then click **Finish**.

## 3. Install [Roblox Studio](https://create.roblox.com/)

:::info

If you do not have a Roblox Account create one [**here**](https://www.roblox.com/signup) then try the above link again. If that does not work, while signed in at [**Roblox.com**](https://www.roblox.com) click **Create** in the navbar.

:::

In the Roblox create hub click **Download** under _Get Roblox Studio_.

![roblox1](/img/roblox1.png)

Once the Roblox Studio Installer executable file has downloaded, click it and install Roblox Studio.

## 4. Install [Aftman](https://github.com/LPGhatguy/aftman)

The README in the [Aftman](https://github.com/LPGhatguy/aftman) repository has instructions for installing on other operating systems.

Windows users can install Aftman by downloading a pre-built binary for your platform from Aftman's [GitHub Releases Page](https://github.com/LPGhatguy/aftman/releases).

Click on the release for the operating system you are using.

![aftman2](/img/aftman2.png)

Unzip the folder.

Open Windows PowerShell, this will likely work better if you run PowerShell as an admin.

With the directory of the aftman folder you unzipped, go to the folder that aftman.exe is a child of, for example use the command:

```bash
cd C:\Users\[user]\Downloads\aftman-0.3.0-windows-x86_64
```

Then run the command:

```bash
./aftman self-install
```

## 5. Install [GitHub CLI](https://cli.github.com/) or [Github Desktop](https://github.com/apps/desktop)

### GitHub Desktop

Download [Github Desktop](https://github.com/apps/desktop) and run the file.

Open GitHub Desktop

Click File -> Clone repository -> URL

Paste in the link the the repository `https://github.com/Cool-Bu1lder/RobloxTemplate.git`.

Click **Repository** and Open in **Visual Studio Code**

### GitHub CLI

Download [GitHub CLI](https://cli.github.com/) and run the file.

Run a command line interface like terminal or PowerShell.

Use the `cd` command and navigate to a directory where you would normally have other repositories inside, GitHub CLI will create a new folder inside this directory.

Run the command:

```bash
gh repo clone Cool-Bu1lder/RobloxTemplate

```

Open Visual Studio Code, click the Menu Icon at the Top Left -> File -> Open Folder and open the clones project folder.

:::info

Alternatively, if you have Windows WSL you can run the command the following command to open the folder in Visual Studio Code.

```bash
code [name of cloned repository]

```

:::

## 6. Install Aftman Tools

Hit `` Ctrl+Shift+` `` then run the following command in the terminal in Visual Studio Code:

```bash

aftman install

```

## 7. Install Wally Packages

Run the command:

```bash

wally install

```

:::info

`wally install` is similar to npm install, I usually use react-lua for UI which is most easily installed through wally.

:::

## 8. Build the game with rojo

Run the command:

```bash

rojo build -o game.rbxlx

```
