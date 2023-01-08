# Cagebreak: A Wayland Tiling Compositor

[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/6532/badge)](https://bestpractices.coreinfrastructure.org/projects/6532) [![Packaging status](https://repology.org/badge/tiny-repos/cagebreak.svg)](https://repology.org/project/cagebreak/versions) [![AUR package](https://repology.org/badge/version-for-repo/aur/cagebreak.svg?minversion=2.0.0)](https://repology.org/project/cagebreak/versions)

## Quick Introduction

Cagebreak is a [Wayland](https://wayland.freedesktop.org/) tiling compositor
based on [Cage](https://github.com/Hjdskes/cage) and inspired by [ratpoison](https://www.nongnu.org/ratpoison/).

### Purpose

The goal of this project is to provide a successor to ratpoison for Wayland.
However, this is no reimplementation of ratpoison.

#### New Features, Bugs and Contact Information

Should you want to know if a feature will be implemented, file a bug or
get in touch, [open an issue](https://github.com/project-repo/cagebreak/issues/new)
or write an e-mail (See [SECURITY.md](SECURITY.md) for details.).

The Roadmap section outlines what is planned for the future.

#### Compatibility & Development Distribution

Cagebreak supports [Arch Linux](https://archlinux.org/) and uses the libraries
(and software versions) as they are obtained through [pacman](https://wiki.archlinux.org/title/Pacman)
at the time of release. Any other use is out of scope.

Most other setups probably work with a bit of luck. We
make no guarantees.

### Quick Installation

This assumes Arch Linux:

1. Use the [cagebreak PKGBUILD](https://aur.archlinux.org/packages/cagebreak).
2. Add an example config such as [config](examples/config) to `$USER/.config/cagebreak/config`
3. Execute cagebreak like any other binary.

See the [ArchWiki](https://wiki.archlinux.org/title/Cagebreak#Getting_started) for
details on getting started and the documentation for everything else.

### Documentation

  * the rest of this file
  * the man pages:
    * [cagebreak](man/cagebreak.1.md)
    * [configuration](man/cagebreak-config.5.md)
    * [socket](man/cagebreak-socket.7.md)
  * the [FAQ](FAQ.md)
  * [SECURITY.md](SECURITY.md)

#### What's new?

See the [Changelog](Changelog.md).

### Uninstallation

`pacman -R cagebreak` should be sufficient.

### Contributing

  * Just [open an issue](https://github.com/project-repo/cagebreak/issues/new) and state your idea.
    We will consider the proposal and get back to you.
  * Don't open a pull request. We might not accept your code and
    it would be sad to waste the effort.
  * Respect the [Code of Conduct](CODE_OF_CONDUCT.md) (To date, we never
    had to intervene - Keep it that way!)

### Name

Cagebreak is based on [Cage](https://github.com/Hjdskes/cage), a Wayland kiosk
compositor. Since it breaks the kiosk into tiles the name
Cagebreak seemed appropriate.

## Installation

On Arch Linux, just use the PKGBUILDs from the [AUR](https://aur.archlinux.org/):

  * Using [cagebreak](https://aur.archlinux.org/packages/cagebreak), Cagebreak is
    compiled on the target system (since release 1.3.0)
  * Using [cagebreak-bin](https://aur.archlinux.org/packages/cagebreak-bin),
    the pre-built binaries are extracted to
    appropriate paths on the target system (since release 1.3.2)

See [cagebreak-pkgbuild](https://github.com/project-repo/cagebreak-pkgbuild) for details.

### Obtaining Source Code

There are different ways to obtain cagebreak source:

  * [git clone](https://github.com/project-repo/cagebreak) (for all releases)
  * [download release asset tarballs](https://github.com/project-repo/cagebreak/releases) (starting at release 1.2.1)

#### Verifying Source Code

There are corresponding methods of verifying that you obtained the correct code:

  * our git history includes signed tags for releases
  * release assets starting at release 1.2.1 contain a signature for the tarball

## Building Cagebreak

You can build Cagebreak with the [meson](https://mesonbuild.com/) build system. It
requires wayland, wlroots and xkbcommon to be installed. Note that Cagebreak is
developed against the latest tag of wlroots, in order not to constantly chase
breaking changes as soon as they occur.

Simply execute the following steps to build Cagebreak:

```
$ meson setup build
$ ninja -C build
```

#### Release Build

By default, this builds a debug build. To build a release build, use `meson
setup build --buildtype=release`.

##### Xwayland Support

Cagebreak comes with compile-time support for XWayland. To enable this,
first make sure that your version of wlroots is compiled with this
option. Then, add `-Dxwayland=true` to the `meson` command above. Note
that you'll need to have the XWayland binary installed on your system
for this to work.

##### Man Pages

Cagebreak has man pages. To use them, make sure that you have `scdoc`
installed. Then, add `-Dman-pages=true` to the `meson` command.

### Running Cagebreak

You can start Cagebreak by running `./build/cagebreak`. If you run it from
within an existing X11 or Wayland session, it will open in a virtual output as
a window in your existing session. If you run it in a TTY, it'll run with the
KMS+DRM backend. Note that a configuration file is required. For more
configuration options, see the man pages.

Please see `example_scripts/` for example scripts and a basis to customize
from.

#### Usage Philosophy

Cagebreak was originally built to suit the needs of its creators. This section outlines
how we intended some parts of cagebreak and might ease learning how to use cagebreak a
little bit. Please note that this does not replace the man pages or the FAQ.
Also, this is in no way intended as a guide on how cagebreak must be used but rather
as a source of inspiration and of explanations for why certain particularities.

1. Cagebreak is keyboard-based. Everything regarding cagebreak can be done
   through the keyboard and it is our view that it should be. This does not mean
   that pointers, touchpads and such are not available for the few applications
   that do require them.

2. Cagebreak is a tiling compositor. Every view takes up as much screen space
   as possible. We believe this is useful, as only very few programs are typically
   necessary to complete a task. To manage multiple tasks concurrently, we use
   workspaces.

3. Each task deserves its own workspace. Any given task (the sort of thing you
   might find in your calendar or on your todo list) probably requires very few
   views and ideally, these take up as much of the screen as possible.

> Combining 2. and 3. might look like this in practice:

>  * Task 1: Edit introduction section for paper on X
>  * Task 2: Coordinate event with person Y

>  * split screen vertically
>  * open web browser or pdf viewer to read literature
>  * focus next
>  * open editor
>  * change to a different workspace
>  * split screen vertically
>  * open calendar application
>  * focus next
>  * open chat application

> Now each task has its own workspace and switching between tasks is possible
> by switching between workspaces.

> Note that, for example by using the socket, more advanced setups are
> possible. But the user is warned that excessive tweaking eats into the work
> to be done.

4. Use keybindings and terminal emulators for the right purpose. Given the
   philosophy outlined above you probably launch the same few programs very
   often and others are very rarely used. We believe that commonly
   used programs should have their own keybindings together with the most
   important cagebreak commands. All the rarely used programs should be launched
   from a terminal emulator as they probably require special flags, environment
   variables and file paths anyway.

> In practice this means thinking about the applications and cagebreak commands
> you use and taking your keyboard layout into account when defining keybindings for
> your individual needs.

5. Cagebreak can't do everything, but with scripting you can do most things.
   Through the socket and with a bit of scripting, you can use the internal state
   of cagebreak in combination with cagebreak commands and the full power of
   a scripting language of your choice to do almost whatever you want.

> Example scripts can be found in the repository under `example_scripts/`.

## Contributing

  * Read this document.
  * Just [open an issue](https://github.com/project-repo/cagebreak/issues/new) and state your feature request.
    We will consider the proposal and get back to you.
  * Don't open a pull request without asking first. We might not accept your
    code and it would be sad to waste the effort.
  * Respect the [Code of Conduct](CODE_OF_CONDUCT.md) (To date, we never
    had to intervene - Please keep it that way!)

### Good First Contributions

  * Reviewing the project is always welcome.
    * Read the code.
    * Read the documentation.
    * Test whether the documentation matches the code.
    * Test Cagebreak in more esoteric setups (many monitors, for instance).
    * Compile the code.
  * Ideas on improving the testing and quality assurance are particularly
    welcome.
  * If you want, you can share your cagebreak scripts and we might include them
    in the repository provided you agree to release them under MIT and we agree
    with the use case and coding style.
  * Iff you are happy with Cagebreak and use Arch Linux, you may vote for
    [Cagebreak in the AUR](https://aur.archlinux.org/packages/cagebreak).
  * The points above still apply.

### Philosophy

Cagebreak is currently developed to fit the needs of its creators.

The feature set is intentionally limited - we removed
support for a desktop background image for example.

Nonetheless, don't be intimidated by any other part of this file.
Do your best and we will collaborate toward a solution.

## Development

### Compatibility & Development Distribution

Cagebreak supports [Arch Linux](https://archlinux.org/) and uses the libraries
(and software versions) as they are obtained through [pacman](https://wiki.archlinux.org/title/Pacman)
at the time of release. Any other use is out of scope.

However, Cagebreak may also work on other distributions given the
proper library versions (Some package maintainers have done this and it
seems to work (To date, we dealt with a few Issues and never felt the
need to ask for the distribution the user was having the issue on.)).

[![Packaging status](https://repology.org/badge/vertical-allrepos/cagebreak.svg)](https://repology.org/project/cagebreak/versions)

You should use Arch Linux if you want to modify Cagebreak
for yourself.

### GCC and -fanalyzer

Cagebreak should compile with any reasonably new gcc or clang. Consider
a gcc version of at least [10.1](https://gcc.gnu.org/gcc-10/changes.html) if
you want to get the benefit of the brand-new
[-fanalyzer](https://gcc.gnu.org/onlinedocs/gcc/Static-Analyzer-Options.html)
flag. However, this new flag sometimes produces false-postives and we
selectively disable warnings for affected code segments as described below.

Meson is configured to set `CG_HAS_FANALYZE` if `-fanalyzer` is available.
Therefore, to maintain portability, false-positive fanalyzer warnings are to be
disabled using the following syntax:

```
#if CG_HAS_FANALYZE
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "WARNING OPTION"
#endif
```
and after

```
#if CG_HAS_FANALYZE
#pragma GCC diagnostic pop
#endif
```

### Fuzzing

Along with the project source code, a fuzzing framework based on `libfuzzer` is
supplied. This allows for the testing of the parsing code responsible for reading
the `cagebreak` configuration file. When `libfuzzer` is available (please
use the `clang` compiler to enable it), building the fuzz-testing software can
be enabled by passing `-Dfuzz=true` to meson. This generates a `build/fuzz/fuzz-parse`
binary according to the `libfuzzer` specifications. Further documentation on
how to run this binary can be found [here](https://llvm.org/docs/LibFuzzer.html).

Here is an example workflow:

```
rm -rf build
CC=clang meson setup build -Dfuzz=true -Db_sanitize=address,undefined -Db_lundef=false
ninja -C build/
mkdir build/fuzz_corpus
cp examples/config build/fuzz_corpus/
WLR_BACKENDS=headless ./build/fuzz/fuzz-parse -jobs=12 -max_len=50000 -close_fd_mask=3 build/fuzz_corpus/
```

You may want to tweak `-jobs` or add other options depending on your own setup.
We have found code path discovery to increase rapidly when the fuzzer is supplied
with an initial config file. We are working on improving our fuzzing coverage to
find bugs in other areas of the code.

#### Caveat

Currently, there are memory leaks which do not seem to stem from our code but rather
the code of wl-roots or some other library we depend on. We are working on the problem.
In the meantime, add `-Db_detect-leaks=0` to the meson command to exclude memory leaks.

### Reproducible Builds

Cagebreak offers reproducible builds given the exact library versions specified
in `meson.build`. Should a version mismatch occur, a warning will be emitted. We have
decided on this compromise to allow flexibility and security. In general we will
adapt the versions to the packages available under Arch Linux at the time of
release.

There are reproducibility issues up to and including release `1.2.0`. See
`Issue 5` in [Bugs.md](Bugs.md).

#### Reproducible Build Instructions

All hashes and signatures are provided for the following build instructions.

```
meson setup build -Dxwayland=true -Dman-pages=true --buildtype=release
ninja -C build
```

#### Hashes for Builds

For every release after 1.0.5, hashes will be provided.

For every release after 1.7.0, hashes will be provided for man pages too.

See [Hashes.md](Hashes.md)

#### GPG Signatures

For every release after 1.0.5, a GPG signature will be provided in `signatures`.

The current signature is called `cagebreak.sig`, whereas all older signatures
will be named after their release version.

Due to errors in the release process, the releases 1.7.1 and 1.7.2 did not include the release
signatures in the appropriate folder of the git repository. However, signatures were provided
as release-artefacts at the time of release. The signatures were introduced into the
repository with 1.7.3. The integrity of cagebreak is still the same because the signatures were
provided as release-artefacts (which were themselves signed) and the hashes in Hashes.md
are part of a signed release tag.

#### Signing Keys

All releases are signed by at least one of the following collection of
keys.

  * E79F6D9E113529F4B1FFE4D5C4F974D70CEC2C5B
  * 4739D329C9187A1C2795C20A02ABFDEC3A40545F
  * 7535AB89220A5C15A728B75F74104CC7DCA5D7A8
  * 827BC2320D535AEAD0540E6E2E66F65D99761A6F
  * A88D7431E5BAAD0B6EAE550AC8D61D8BD4FA3C46
  * 8F872885968EB8C589A32E9539ACC012896D450F
  * 896B92AF738C974E0065BF42F2576BD366156BB9
  * AA927AFD50AF7C6810E69FE8274F2C605359E31B
  * BE2DED372287BC4EB2213E13A0C743848A638955
  * 0F3476E4B2404F95EC41600683D5810F7911B020

Should we at any point retire a key, we will only replace it with keys signed
by at least one of the above collection.

We registered project-repo.co and added mail addresses after release `1.3.0`.

We now have a mail address and its key is signed by signing keys. See Security
Bugs for details.

The full public keys can be found in `keys/` along with any revocation certificates.

### Versioning & Branching Strategy

Cagebreak uses [semantic versioning](https://semver.org).

There are three permanent branches in cagebreak:

  * `master` (for releases)
  * `development` (for polishing code between releases)
  * `hotfix` (for small emergent releases, usually up-to-date with master)

Releases are merged to master as per the release procedure, with
reasonable exceptions as the situation requires.

The release commit is tagged with the release version.

In the past, our git history did not perfectly reflect this scheme.

### Release Procedure

The release procedure outlines the process for a release to occur.

  * [ ] `git checkout development`
  * [ ] `git pull origin development`
  * [ ] `git push origin development`
  * [ ] New semantic version number determined
  * [ ] Adjust version number
    * [ ] meson.build
    * [ ] git tag
    * [ ] man pages
    * [ ] README.md repology badges minversion
  * [ ] Relevant Documentation completed
    * [ ] New features
      * [ ] man pages
        * [ ] cagebreak
        * [ ] cagebreak-config
        * [ ] cagebreak-socket
        * [ ] example config
        * [ ] Set EPOCH to release day in man generation in meson.build
      * [ ] FAQ.md
      * [ ] Changelog.md for major and minor releases but not patches
    * [ ] Check features for SECURITY.md relevance (changes to socket scope
          for example)
      * [ ] Synchronize any socket changes to cagebreak-socket man page
    * [ ] Fixed bugs documented in Bugs.md
      * [ ] Include issue discussion from github, where applicable
  * [ ] Testing
    * [ ] Manual testing
    * [ ] Libfuzzer testing
    * [ ] Build version without xwayland support
  * [ ] meson.build reproducible build versions are current archlinux libraries and gcc
  * [ ] wlr_xdg_shell version check
  * [ ] `ninja -C build clang-format` makes no changes
  * [ ] `ninja -C build scan-build` shows no issues
  * [ ] Cagebreak is reproducible on multiple machines
  * [ ] Documented reproducible build artefacts
    * [ ] Hashes of the artefacts in Hashes.md
    * [ ] Renamed previous signatures
    * [ ] Created gpg signature of the artefacts
      * [ ] `gpg --detach-sign -u keyid cagebreak`
      * [ ] `gpg --detach-sign -u keyid cagebreak.1`
      * [ ] `gpg --detach-sign -u keyid cagebreak-config.5`
      * [ ] `gpg --detach-sign -u keyid cagebreak-socket.7`
  * [ ] `git add` relevant files
  * [ ] `git commit`
  * [ ] `git push origin development`
  * [ ] Determined commit and tag message (Start with "Release version_number\n\n")
    * [ ] Mentioned fixed Bugs.md issues ("Fixed Issue n")
    * [ ] Mentioned other important changes
  * [ ] `git checkout master`
  * [ ] `git merge --squash development`
  * [ ] `git commit` and insert message
  * [ ] `git tag -u keyid version HEAD` and insert message
  * [ ] `git tag -v version` and check output
  * [ ] `git push --tags origin master`
  * [ ] `git checkout development` (merge to development depends on whether release was a hotfix)
  * [ ] `git merge master`
  * [ ] `git push --tags origin development`
  * [ ] `git checkout hotfix` (hotfix is to be kept current with master after releases)
  * [ ] `git merge master`
  * [ ] `git push --tags origin hotfix`
  * [ ] `git archive --prefix=cagebreak/ -o release_version.tar.gz tags/version .`
  * [ ] Create release-artefacts_version.tar.gz
    * [ ] `mkdir release-artefacts_version`
    * [ ] `cp build/cagebreak release-artefacts_version/`
    * [ ] `cp build/cagebreak.sig release-artefacts_version/`
    * [ ] `cp build/cagebreak.1 release-artefacts_version/`
    * [ ] `cp build/cagebreak.1.sig release-artefacts_version/`
    * [ ] `cp build/cagebreak-config.5 release-artefacts_version/`
    * [ ] `cp build/cagebreak-config.5.sig release-artefacts_version/`
    * [ ] `cp build/cagebreak-socket.7 release-artefacts_version/`
    * [ ] `cp build/cagebreak-socket.7.sig release-artefacts_version/`
    * [ ] `cp LICENSE release-artefacts_version/`
    * [ ] `cp README.md release-artefacts_version/`
    * [ ] `cp SECURITY.md release-artefacts_version/`
    * [ ] `cp FAQ.md release-artefacts_version/`
    * [ ] `export SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct) ; tar --sort=name --mtime= --owner=0 --group=0 --numeric-owner -czf release-artefacts_version.tar.gz release-artefacts_version`
  * [ ] Checked archive
    * [ ] tar -xvf release_version.tar.gz
    * [ ] cd cagebreak
    * [ ] meson setup build -Dxwayland=true -Dman-pages=true --buildtype=release
    * [ ] ninja -C build
    * [ ] gpg --verify ../signatures/cagebreak.sig build/cagebreak
    * [ ] cd ..
    * [ ] rm -rf cagebreak
  * [ ] `gpg --detach-sign -u keyid release_version.tar.gz`
  * [ ] `gpg --detach-sign -u keyid release-artefacts_version.tar.gz`
  * [ ] Upload archives and signatures as release assets

## Roadmap

Cagebreak plans to do or keep doing the following things
in the future:

  * React to all issues.
  * Add or modify features, which the authors find convenient or important.
  * Improve the [OpenSSF Best Practices Badge Program](https://bestpractices.coreinfrastructure.org/en) level

## Governance

Cagebreak is managed by project-repo.

Project-repo is a pseudonym of at least two individuals acting
as benevolent dictators for the project by the others mutual consent.

The individuals comprising project-repo are not otherwise associated
by payment from any organisation or grant.

For all intents and purposes consider project-repo as a single
benevolent dictator for life that happens to occupy at least two brains.

### Roles

There are members of project-repo and those who are not.

There are no specific roles forced unto anyone.

### Bus Factor

The Bus Factor is a measure of how many people have to be
incapacitated for a project to be unable to continue.

The current bus factor for Cagebreak is: 1

Project-repo could still react to issues (even confidential
e-mails) and fix easier issues if any one individual were
incapacitated.

However, not all aspects of the code or release engineering
are fully resilient to the loss of any one individual.

We strive to improve the Bus Factor to at least two in all
aspects of Cagebreak.

### Governance Issues

Anyone can use the information in [SECURITY.md](SECURITY.md) to
contact the members of project-repo and bring governance
issues to their attention.

## Bugs

For any bug, please [create an issue](https://github.com/project-repo/cagebreak/issues/new) on
[GitHub](https://github.com/project-repo/cagebreak).

Fixed bugs are to be assigned a number and summarized inside Bugs.md for future reference
independent of github, in case this service is unavailable.

For other means of contacting the Cagebreak authors and for security issues
see [SECURITY.md](SECURITY.md).

## Contributors

  * Aisha Tammy
    * [make man pages optional](https://github.com/project-repo/cagebreak/pull/4), released
      in 1.6.0 with slight modifications
  * Oliver Friedmann
    * [Add output scaling](https://github.com/project-repo/cagebreak/pull/34), released
      in 2.0.0 with slight modifications

## License

MIT, please see [LICENSE](https://github.com/project-repo/cagebreak/blob/master/LICENSE).

