CREATE TABLE `admins` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(40) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(40) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `superadmin` tinyint(1) default '0',
  `personnel_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_admins_on_login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `alerts` (
  `id` int(11) NOT NULL auto_increment,
  `target_id` int(11) default NULL,
  `target_type` varchar(30) default NULL,
  `admin_id` int(11) default NULL,
  `message` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_alerts_on_target_type_and_target_id` (`target_type`,`target_id`),
  KEY `index_alerts_on_admin_id` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `personnels` (
  `id` int(11) NOT NULL auto_increment,
  `personnel_id` int(11) NOT NULL,
  `first_name` varchar(30) default NULL,
  `middle_name` varchar(30) default NULL,
  `last_name` varchar(30) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_personnels_on_personnel_id` (`personnel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `students` (
  `id` int(11) NOT NULL auto_increment,
  `student_id` int(11) NOT NULL,
  `first_name` varchar(30) default NULL,
  `middle_name` varchar(30) default NULL,
  `last_name` varchar(30) default NULL,
  `record_status` char(1) default 'E',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_students_on_student_id` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `terminals` (
  `id` int(11) NOT NULL auto_increment,
  `college` varchar(10) default NULL,
  `name` varchar(30) default NULL,
  `description` varchar(255) default NULL,
  `ip_address` varchar(15) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_terminals_on_college` (`college`),
  KEY `index_terminals_on_ip_address` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20081022090202');

INSERT INTO schema_migrations (version) VALUES ('20081022092601');

INSERT INTO schema_migrations (version) VALUES ('20081024055314');

INSERT INTO schema_migrations (version) VALUES ('20081024065329');

INSERT INTO schema_migrations (version) VALUES ('20081024071214');

INSERT INTO schema_migrations (version) VALUES ('20081029091556');

INSERT INTO schema_migrations (version) VALUES ('20081104105609');