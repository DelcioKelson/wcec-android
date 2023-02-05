# getting base image
FROM ocaml/opam:ubuntu-ocaml-4.13

USER opam

ARG wcec_dir=/home/opam/wcec


# installing dependencies 
RUN sudo apt-get update && sudo apt-get install -y openjdk-18-jdk lp-solve sdkmanager

# installing wcec analyser
COPY --chown=opam:opam . wcec

RUN sudo sdkmanager "platform-tools" "platforms;android-31"

RUN opam install dune -y 

RUN opam install menhir -y

RUN eval $(opam env)

WORKDIR wcec

CMD [ "dune", "exec", "wcec"]


# dune exec wcec /home/ferramenta/apks/facebook_lite.apk