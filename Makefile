SRC                 ?= bot.py
FUNCTION             = patlamis_misir_bot
AWS_DEFAULT_PROFILE ?= msimav

package: | create-target install-pip copy-sources create-zip

re-package: | copy-sources create-zip

deploy: | clean package update clean

test:
ifndef TOKEN
	$(error TOKEN is not set)
endif
	@python test.py

clean:
	@rm -rf target
	@find . -name \*.pyc | xargs rm

update:
ifndef FUNCTION
	$(error FUNCTION is not set)
endif
	@aws lambda update-function-code \
		--function-name $(FUNCTION) \
		--zip-file fileb://$(PWD)/target/package.zip \
		--profile $(AWS_DEFAULT_PROFILE)

create-target: clean
	@mkdir target

copy-sources:
	@cp -r "$(SRC)" target

create-zip:
	@cd target && zip -q -r package.zip *

install-pip:
	@pip install -q -r requirements.txt -t target
