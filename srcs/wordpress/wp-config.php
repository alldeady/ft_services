<?php
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '${DB_NAME}' );

/** MySQL database username */
define( 'DB_USER', '${DB_USER}' );

/** MySQL database password */
define( 'DB_PASSWORD', '${DB_PASS}');

/** MySQL hostname */
define( 'DB_HOST', '${DB_HOST}' );

define('WP_HOME', 'http://192.168.99.202:5050' );
define('WP_SITEURL', 'http://192.168.99.202:5050' );
// define('WP_HOME', 'http://wordpress-svc:5050' );
// define('WP_SITEURL', 'http://wordpress-svc:5050' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define('AUTHOR', 'peer');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '/Tt5JkvXB0jEc_wS`l+XTrJ!K(+A)M]GOhgN8g/.*fwjNR[o*OmBSag|OHj^]0-_');
define('SECURE_AUTH_KEY',  'hPW8{S>hrDdDu:(Qk@3D_@ejE7M>%-`bpO1RBB+L{9+Tznejbnj^s|Aly2*z48%s');
define('LOGGED_IN_KEY',    '&Sg^Q4J)F]%Z )?@b}Y`N2QFAY9!s3t|NfxB4N{^%&|!]G*Hvh>Y [O*xS4=;46e');
define('NONCE_KEY',        'U{ +AU}u!|x> t-/t6-*qL]$T/)~e/rD3cEg{_YjO^XUc9qvN!~X3p8[|z+Em*X9');
define('AUTH_SALT',        '(Qy1[ny*>:4cg.KQX1A-Mwe6#(PJ e zQL{;$dBfp{C*QvT!dytXB1/QxYevrZNa');
define('SECURE_AUTH_SALT', '8QHL[2s;xWq^,W?E`0;CKd#{AyHVL$qpRb[]@|]*LLRS$|7`~Kvu_AVC--O5w7v7');
define('LOGGED_IN_SALT',   '+ZLADBi+gd{c40h}SX1r(sA9ieg1s$jwaT.A(X?G,-gF+cI=d[K&@yHd9)B#f?nZ');
define('NONCE_SALT',       'lZ(0WCJtNV0a+,JqVfe2bAg?jkHRn-D$ ~+Y<[3ln8Lu]7S)Tc=:G^~mq%!Vn6au');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
