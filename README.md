# Description

Imported my old gists into a proper github project to make them easier to search

# Info

Mostly generated with  the following prompts to ChatGPT below. Fork info was missing, and some repos were ignored. The shell script is available on [import.sh](https://github.com/danielribeiro/my_imported_gists/blob/main/import.sh)

Original

```
create me a shell script that leverage githbu's gh command line too to 
list all my PUBLIC gists, and import them each into its own folder. Each 
folder should have the all the files of the gist inside it (no ID), a 
README.md (with the description of the gist and a Extra section 
including the original fork, if it was forked). The gists's folder name
should be the name of the one file if the gist has only one file, or
should be the name of the largest file, if that gist has more than one
file.
```

Into

```
errors out oh gh list. Maybe you are using an outdated version?:
Fetching public gists...
unknown flag: --json

Usage:  gh gist list [flags]

Flags:
      --filter expression   Filter gists using a regular expression
      --include-content     Include gists' file content when filtering
  -L, --limit int           Maximum number of gists to fetch (default 10)
      --public              Show only public gists
      --secret              Show only secret gists

```

After

```
now errors with:
Fetching public gists via GitHub API...
gh: Invalid request.

Invalid input: object is missing required key: files. (HTTP 422)
```

Finally

```
"gh api /gists --paginate -F per_page=100" is giving me an error:
{
  "message": "Invalid request.\n\nInvalid input: object is missing required key: files.",
  "documentation_url": "https://docs.github.com/rest/gists/gists#create-a-gist",
  "status": "422"
}
gh: Invalid request.

Invalid input: object is missing required key: files. (HTTP 422)
```

