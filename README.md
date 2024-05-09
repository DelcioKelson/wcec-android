# wcec-android

A tool for static WCEC analysis of android apps.

## dependecies:

ocaml 5.0,0

lp_solve;

dune;

java;

sudo sdkmanager "platform-tools" "platforms;android-31"


## How to execute:

dune exec wcec apk_path

### Example:
dune exec wcec /home/ferramenta/Downloads/APKS/2_DELCIO_app-debug.apk
