# fed51

The three branches of the US federal government, right in your terminal: who your senators and representative are,
what bills are moving, what the president has signed, what the courts have decided, what happens this week, and the
Constitution itself.

```
fed51> reps 33067
fed51> member warren ma money
fed51> bill hr 1
fed51> order 14434 analyze
fed51> justices
fed51> today
```

New to it? Type `tour` for a two-minute walk through six commands.

It works the moment you install it: no account and no key needed to start. A few things use an optional free key,
described [below](#keys-all-optional).

Pick your computer and follow that section from top to bottom:

- [Mac](#mac-apple-silicon-m1-or-newer) (Apple Silicon: M1 or newer)
- [Windows](#windows-10-or-11-64-bit) (10 or 11, 64-bit)

---

## Mac (Apple Silicon: M1 or newer)

### Install

1. Open **Terminal**: press `Cmd + Space`, type `Terminal`, press Enter.
2. Paste this line (`Cmd + V`) and press Enter:

   ```sh
   curl -fsSL https://raw.githubusercontent.com/josejmorales/fed51-releases/main/install.sh | bash
   ```

3. When it says it has finished, **close Terminal and open it again** (`Cmd + Space`, `Terminal`, Enter).
4. Type `fed51` and press Enter. Then type `tour` for a two-minute walkthrough, or `help` to see everything it can do.

You don't need to change any settings: the installer adds fed51 to your PATH for you (it writes one line
to `~/.zshrc`, or `~/.bash_profile` if you use bash), which is why step 3 needs a fresh window.

### Update

Inside fed51, type `update`. It checks for a newer release, downloads it, verifies it and replaces the old program;
`update check` only looks. You can also run the install line again, which does the same. Your settings are kept either way.

### Uninstall

In Terminal:

```sh
rm ~/.local/bin/fed51          # the program
rm -r ~/.config/fed51          # your keys, settings and saved lists
```

Then open `~/.zshrc` (or `~/.bash_profile`) and delete the line ending in `# added by the fed51 installer`.
You can also leave that line; it does no harm.

### Trouble on Mac

- **"command not found: fed51":** close Terminal and open a new window. If it still isn't found, run
  `source ~/.zshrc` and try again.
- **The installer printed a line starting with `export PATH=`:** you use a shell other than zsh or bash.
  Add that line to your shell's startup file, then open a new window.
- **Mac says it can't be opened:** tell whoever sent you this; it shouldn't happen with the install line above.

---

## Windows 10 or 11 (64-bit)

### Install

1. Open **PowerShell**: click the Start menu, type `PowerShell`, press Enter. (Windows Terminal also works.)
2. Paste this line (right-click in the window to paste) and press Enter:

   ```powershell
   irm https://raw.githubusercontent.com/josejmorales/fed51-releases/main/install.ps1 | iex
   ```

3. When it says it has finished, **close PowerShell and open it again** (Start menu, `PowerShell`, Enter).
4. Type `fed51` and press Enter. Then type `tour` for a two-minute walkthrough, or `help` to see everything it can do.

You don't need to change any settings: the installer adds fed51 to your PATH for you (it installs to
`%LOCALAPPDATA%\fed51`), which is why step 3 needs a fresh window.

**Prefer to read the installer before running it?** Download it, open it, then run it:

```powershell
irm https://raw.githubusercontent.com/josejmorales/fed51-releases/main/install.ps1 -OutFile install.ps1
notepad install.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

It is short: it downloads the program and its checksum file from this page's
[latest release](https://github.com/josejmorales/fed51-releases/releases/latest), stops if they don't match,
copies the program to `%LOCALAPPDATA%\fed51`, and adds that folder to your PATH.

### Update

Inside fed51, type `update`. It checks for a newer release, downloads it, verifies it and replaces the old program;
`update check` only looks. You can also run the install line again, which does the same. Your settings are kept either way.

### Uninstall

In PowerShell:

```powershell
Remove-Item -Recurse "$env:LOCALAPPDATA\fed51"      # the program
Remove-Item -Recurse "$HOME\.config\fed51"          # your keys, settings and saved lists
```

Then remove it from your PATH: search Windows for *Edit the environment variables for your account*, select
`Path`, and delete the `fed51` entry. You can also leave it; it does no harm.

### If your antivirus flags fed51

Security programs sometimes report a new, unsigned program like this with a generic name such as
`W32.Malware.Gen`. That is a *false positive*: it is flagged because it is new and from an independent developer,
so it has no reputation yet. It is not because it does anything harmful. It isn't code-signed yet, which is the
main reason.

You don't have to take that on trust. **Check that your copy is exactly the file that was published:**

1. In PowerShell, print your copy's fingerprint. (If your antivirus already removed it, download
   `fed51-windows-x64.exe` from the [latest release](https://github.com/josejmorales/fed51-releases/releases/latest)
   and use that file's path instead.)

   ```powershell
   Get-FileHash "$env:LOCALAPPDATA\fed51\fed51.exe" -Algorithm SHA256
   ```

2. On the same release page, open `SHA256SUMS`. The long string of letters and numbers beside
   `fed51-windows-x64.exe` must be the same as the `Hash` PowerShell printed (capitals don't matter).

**If they match,** the file is genuine. Restore it from your antivirus's quarantine or choose *allow*, and consider
reporting it to the vendor as a false positive so it stops happening to others. **If they don't match,** delete the
file, don't run it, and [open an issue](https://github.com/josejmorales/fed51-releases/issues).

What fed51 does on your computer, so you can judge for yourself:

- It talks only to public government sources (the Federal Register, Congress.gov, the Senate and House, the Supreme
  Court, USAspending.gov, the Federal Election Commission's OpenFEC, the White House's cabinet page, CourtListener), plus a couple of open data sets (the
  congress-legislators project on GitHub, civicAPI for election results) and **GitHub** (the installer, to fetch the
  release). If you turn on AI summaries, it also sends the text of the document you ask about, with your own key, to
  the AI provider you chose, and to nobody else.
- It saves your settings, any keys you add, and small caches in `.config\fed51` in your user folder, and puts its own
  folder on your user PATH.
- It doesn't need administrator rights, doesn't start with Windows, and doesn't install services or scheduled tasks.

### Trouble on Windows

- **"fed51 is not recognized":** close PowerShell and open a new window.
- **Your antivirus removed or blocked fed51:** see [If your antivirus flags fed51](#if-your-antivirus-flags-fed51)
  above. Check the fingerprint first, then restore the file.
- **Windows (SmartScreen) warns about the file:** it isn't signed yet, so Windows may question it. If the fingerprint
  matches, choose *More info*, then *Run anyway*.

---

## What you can do

Some commands to start with (type `help` for the full list):

| Command | What it shows |
|---|---|
| `reps 33067` | Your senators and representative for a ZIP code, with phone numbers and email |
| `members` | The Senate and House by party, as bars; `members next` projects the incoming Congress |
| `member warren ma` | One member of Congress: committees, how to reach them, and their latest bills |
| `member warren ma money` | Who funds a member's campaign: raised, spent, small vs. large donors, biggest PAC donors (FEC data) |
| `bills fl`, `bill hr 1` | Bills by state, ZIP or member; one bill's status, what it's waiting for, and votes by party |
| `president`, `cabinet` | The president and their term, the cabinet and each member's biography |
| `orders`, `order 14434` | Executive orders and other presidential documents, with their text |
| `spending`, `spending defense` | Where federal money goes, and one agency's budget |
| `justices`, `courts` | The Supreme Court's justices, and the court system as a hierarchy |
| `opinions miranda`, `opinion 11057881` | Search court opinions; read one |
| `today`, `tomorrow`, `calendar 30` | What is scheduled across all three branches |
| `constitution`, `constitution amendment 14` | The Constitution, a part at a time |
| `tour` | A two-minute walk through six commands, with live results |

Add `analyze` to an order, an opinion or a bill (`order 14434 analyze`) for a plain-English AI summary. See
[AI summaries](#ai-summaries-optional).

If you mistype, fed51 guesses what you meant: `bils fl` offers `bills fl`, a ZIP code offers `reps`, `vote` and `bills`, and a
member's surname offers `member` commands. Under most results a dim `Next:` line suggests what to type next; `hints off` turns
those off.

## Keys (all optional)

fed51 runs without any of these. Add one only if you want the feature it unlocks:

| Key | Unlocks | How |
|---|---|---|
| Congress.gov | Heavy use of `bills`, `bill`, `member` and `member … money` (the built-in shared key is limited to about 10 requests an hour; the same key also covers the FEC's campaign finance data) | Free: get one at <https://api.congress.gov/sign-up/>, then `apikey set congress` |
| CourtListener | `opinions`, `opinion` and `courts list` | Free: register at <https://www.courtlistener.com/sign-in/>, copy your token from <https://www.courtlistener.com/profile/api-token/>, then `apikey set courtlistener` |
| An AI provider | `analyze` | Your own Anthropic or OpenAI key (see below) |

`apikey` on its own shows which keys are set. Keys are stored in a file only you can read.

## AI summaries (optional)

Orders, opinions and bills can run long. With your own key from [Anthropic](https://console.anthropic.com/settings/keys)
(Claude) or [OpenAI](https://platform.openai.com/api-keys), fed51 can summarize them:

```
apikey set anthropic
order 14434 analyze
```

`ai` shows and changes the setup: the provider and model (`ai model haiku`), the answer length (`ai max 500`), your own
instructions (`ai prompt ...`), or a local OpenAI-compatible server (`ai url ...`). Each summary ends with an
estimated cost and `ai usage` totals what you've used. You pay your provider for the tokens; a summary on the default
model usually costs a fraction of a cent. AI summaries can be wrong: check the original, which fed51 points you to.

**Follow-up questions.** After you analyze something, keep going at the prompt:

```
order 14434 analyze
ask who does this apply to?
ask and when does it take effect?
order 14400 analyze
compare
```

`ask` answers from that document only and says so when the document doesn't cover something; follow-ups remember the earlier
answers. `compare` sets the last two documents side by side. They also work on people: after `member pelosi ca money`, ask
`is she raising more than she spends?`, or look up a second member and `compare` their campaign finances. These only work at the
prompt, not in one-shot commands, and each answer shows its estimated cost.

Every download is checked against the release's `SHA256SUMS` before it is installed.
