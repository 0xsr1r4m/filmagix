#!/bin/sh
echo "window._env_ = {" > ./env.js
echo "  REACT_APP_TMDB_KEY: \"${REACT_APP_TMDB_KEY}\"" >> ./env.js
echo "}" >> ./env.js