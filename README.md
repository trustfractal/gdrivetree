# Google Drive Tree

Helps you visualize a Google Drive folder as a discount `tree` for quick overviews.

## Installation

`bundle`

## Configuration

You'll need a `credentials.json` file. Get yours at [Google](https://developers.google.com/drive/api/v3/quickstart/ruby). It will have this structure:

```json
{
  "installed" : {
    "client_id" : "hunter2.apps.googleusercontent.com",
    "project_id" : "hunter2",
    "auth_uri" : "https://accounts.google.com/o/oauth2/auth",
    "token_uri" : "https://www.googleapis.com/oauth2/v3/token",
    "auth_provider_x509_cert_url" : "https://www.googleapis.com/oauth2/v1/certs",
    "client_secret" : "hunter2",
    "redirect_uris" : [
      "urn:ietf:wg:oauth:2.0:oob",
      "http://localhost"
    ]
  }
}
```

## Usage

```bash
Usage: ruby main.rb [options]
    -r, --root-id ROOT_ID            Select root ID (default: nil)
    -u, --urls                       Show URLs next to files (default: false)
```

## Testing

*ahem* `bundle exec rubocop`

## Known Issues

I've seen it list a folder that I removed hours prior. Haven't looked much into that.
