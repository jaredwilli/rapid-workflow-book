include_dir=build
stylesheets_dir=stylesheets
chapters_dir=chapters
source=$(chapters_dir)/*.md
title="Rapid Workflow: Using modern tools to build modern webapps"
filename='rapid-workflow'

all: html epub rtf pdf mobi

html:
	pandoc -s $(source) -t html5 -o index.html -c $(stylesheets_dir)/screen.css \
		--include-in-header $(include_dir)/head.html \
		--include-before-body $(include_dir)/author.html \
		--include-after-body $(include_dir)/stats.html \
		--title-prefix $(title) \
		--normalize \
		--section-divs \
		--smart \
		--toc

epub:
	pandoc -s $(source) --normalize --smart -t epub -o $(filename).epub \
		--epub-metadata $(include_dir)/metadata.xml \
		--epub-stylesheet epub.css \
		--epub-cover-image chapters/img/placeholder.png \
		--title-prefix $(title) \
		--normalize \
		--section-divs \
		--smart \
		--toc

rtf:
	pandoc -s $(source) -o $(filename).rtf \
		--title-prefix $(title) \
		--normalize \
		--smart

pdf:
	# You need `pdflatex`
	# OS X: http://www.tug.org/mactex/
	# Then find its path: find /usr/ -name "pdflatex"
	# Then symlink it: ln -s /path/to/pdflatex /usr/local/bin
	pandoc -s $(source) -o $(filename).pdf \
		--title-prefix $(title) \
		--normalize \
		--smart \
		--toc

mobi: epub
	# Download: http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211
	# Symlink bin: ln -s /path/to/kindlegen /usr/local/bin
	kindlegen $(filename).epub
