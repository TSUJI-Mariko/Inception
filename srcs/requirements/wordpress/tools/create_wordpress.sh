#!/bin/sh

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else

	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php
fi
# Check if WordPress is already installed
if ! $(wp --allow-root core is-installed); then
	wp --allow-root core install \
		--url="$WP_URL" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USR" \
		--admin_password="$WP_ADMIN_PWD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email

	# Create additional user
	wp --allow-root user create "$WP_USR" "$WP_EMAIL" \
		--role=editor \
		--user_pass="$WP_PWD" \
		--skip-email
fi

exec "$@"