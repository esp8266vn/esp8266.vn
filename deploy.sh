git config user.name "tuanpmt"
git config user.email "tuanpm@live.com"
git remote add gh-token "https://${GH_TOKEN}@github.com/esp8266vn/esp8266.vn.git"
git fetch gh-token && git fetch gh-token gh-pages:gh-pages
pip install mkdocs -U
mkdocs gh-deploy -v --clean --remote-name gh-token