-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2021-01-22 13:56:59
-- 服务器版本： 5.5.62-log
-- PHP 版本： 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `web_xihongshi_w`
--

-- --------------------------------------------------------

--
-- 表的结构 `web2020_admin`
--

CREATE TABLE `web2020_admin` (
  `id` mediumint(6) UNSIGNED NOT NULL,
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `encrypt` varchar(6) NOT NULL DEFAULT '',
  `lastloginip` int(10) NOT NULL DEFAULT '0',
  `lastlogintime` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(40) NOT NULL DEFAULT '',
  `mobile` varchar(11) NOT NULL DEFAULT '',
  `realname` varchar(50) NOT NULL DEFAULT '',
  `openid` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(2:无效,1:有效)',
  `updatetime` int(10) NOT NULL DEFAULT '0',
  `num` int(1) NOT NULL DEFAULT '3',
  `code` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `web2020_admin`
--

INSERT INTO `web2020_admin` (`id`, `username`, `password`, `encrypt`, `lastloginip`, `lastlogintime`, `email`, `mobile`, `realname`, `openid`, `status`, `updatetime`, `num`, `code`) VALUES
(1, 'admin', 'dc5f3be547f6e1b177578e33ee0508ba', '', 2084574016, 1611277648, '11948276253@qq.com', '15235415335', '张三', '', 1, 0, 3, 1),
(12, 'dee', 'dc5f3be547f6e1b177578e33ee0508ba', '', 2084574016, 1611277031, '', '', '', '', 1, 0, 3, 1),
(13, 'deeGood', 'dc5f3be547f6e1b177578e33ee0508ba', '', 2084574016, 1611277080, '987654321@qq.com', '15288769980', '李四', '', 1, 0, 3, 1),
(14, 'deeOrder', 'dc5f3be547f6e1b177578e33ee0508ba', '', 2084574016, 1611277154, '', '', '', '', 1, 0, 3, 1),
(15, 'deeLeader', 'dc5f3be547f6e1b177578e33ee0508ba', '', 2084574016, 1611277198, '465377823@qq.com', '15233445566', '王五', '', 1, 0, 3, 1);

-- --------------------------------------------------------

--
-- 表的结构 `web2020_admin_group`
--

CREATE TABLE `web2020_admin_group` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  `listorder` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `updatetime` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `web2020_admin_group`
--

INSERT INTO `web2020_admin_group` (`id`, `name`, `description`, `rules`, `listorder`, `updatetime`) VALUES
(1, '系统管理员', '管理系统基本配置', '1,2,7,12,18,23,27,31,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67', 0, 1477622552),
(2, '商品管理员', '管理商品可用状态等', '23,31,32,37,38,39,40,41,42,47,48', 0, 1476067479),
(3, '订单管理员', '处理订单', '23,31,33,34,35,43,44,45,46,47,48', 0, 1479969527),
(4, '高层领导', '查询统计功能', '23,31,47,48', 0, 1479969527);

-- --------------------------------------------------------

--
-- 表的结构 `web2020_admin_group_access`
--

CREATE TABLE `web2020_admin_group_access` (
  `uid` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) UNSIGNED NOT NULL COMMENT '用户组id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `web2020_admin_group_access`
--

INSERT INTO `web2020_admin_group_access` (`uid`, `group_id`) VALUES
(12, 1),
(13, 2),
(14, 3),
(15, 4);

-- --------------------------------------------------------

--
-- 表的结构 `web2020_admin_log`
--

CREATE TABLE `web2020_admin_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `m` varchar(15) NOT NULL,
  `c` varchar(20) NOT NULL,
  `a` varchar(20) NOT NULL,
  `querystring` varchar(255) NOT NULL,
  `userid` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `username` varchar(20) NOT NULL,
  `ip` int(10) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `web2020_admin_log`
--

INSERT INTO `web2020_admin_log` (`id`, `m`, `c`, `a`, `querystring`, `userid`, `username`, `ip`, `time`) VALUES
(487, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610937683),
(488, 'admin', 'Admin', 'dee_edit', '?void=9', 1, 'admin', 2084574016, 1610937691),
(489, 'admin', 'Admin', 'dee_edit', '?void=10', 1, 'admin', 2084574016, 1610937711),
(490, 'admin', 'Admin', 'dee_edit', '?void=9', 1, 'admin', 2084574016, 1610937743),
(491, 'admin', 'Admin', 'index', '?findbyname=dee', 1, 'admin', 2084574016, 1610937756),
(492, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610937758),
(493, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610937761),
(494, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610937768),
(495, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610937796),
(496, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610937799),
(497, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610937800),
(498, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610937802),
(499, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610937826),
(500, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610937876),
(501, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610937878),
(502, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610937879),
(503, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1610937880),
(504, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610937884),
(505, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610937886),
(506, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610938025),
(507, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610938027),
(508, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610938324),
(509, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610938381),
(510, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610938427),
(511, 'admin', 'Group', 'index', '?findbyname=%E5%95%86%E5%93%81%E7%AE%A1%E7%90%86%E5%91%98', 1, 'admin', 2084574016, 1610938436),
(512, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610938442),
(513, 'admin', 'Group', 'index', '?findbyname=s', 1, 'admin', 2084574016, 1610938468),
(514, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610938475),
(515, 'admin', 'Group', 'index', '?findbyname=s', 1, 'admin', 2084574016, 1610938502),
(516, 'admin', 'Group', 'index', '?findbyname=%E5%95%86%E5%93%81%E7%AE%A1%E7%90%86%E5%91%98', 1, 'admin', 2084574016, 1610938510),
(517, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610938793),
(518, 'admin', 'Group', 'dee_edit', '?void=4', 1, 'admin', 2084574016, 1610939029),
(519, 'admin', 'Group', 'dee_add', '', 1, 'admin', 2084574016, 1610939632),
(520, 'admin', 'Group', 'dee_add', '', 1, 'admin', 2084574016, 1610939710),
(521, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610939714),
(522, 'admin', 'Group', 'add', '', 1, 'admin', 2084574016, 1610939717),
(523, 'admin', 'Group', 'add', '', 1, 'admin', 2084574016, 1610939865),
(524, 'admin', 'Group', 'add', '', 1, 'admin', 2084574016, 1610940030),
(525, 'admin', 'Group', 'add', '', 1, 'admin', 2084574016, 1610940053),
(526, 'admin', 'Group', 'do_dee_add', '', 1, 'admin', 2084574016, 1610940068),
(527, 'admin', 'Group', 'add', '', 1, 'admin', 2084574016, 1610940357),
(528, 'admin', 'Group', 'do_add', '', 1, 'admin', 2084574016, 1610940401),
(529, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610940403),
(530, 'admin', 'Group', 'dee_edit', '?void=5', 1, 'admin', 2084574016, 1610941336),
(531, 'admin', 'Group', 'dee_edit', '?void=5', 1, 'admin', 2084574016, 1610941349),
(532, 'admin', 'Group', 'dee_edit', '?void=5', 1, 'admin', 2084574016, 1610941483),
(533, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610941486),
(534, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610941488),
(535, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610941527),
(536, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610941611),
(537, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610941630),
(538, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610941686),
(539, 'admin', 'Group', 'add', '', 1, 'admin', 2084574016, 1610941694),
(540, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610941724),
(541, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610941788),
(542, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610941892),
(543, 'admin', 'Admin', 'do_edit', '', 1, 'admin', 2084574016, 1610941915),
(544, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610941936),
(545, 'admin', 'Group', 'do_edit', '', 1, 'admin', 2084574016, 1610941941),
(546, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610941961),
(547, 'admin', 'Group', 'do_edit', '', 1, 'admin', 2084574016, 1610941966),
(548, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610942090),
(549, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610942133),
(550, 'admin', 'Group', 'do_edit', '', 1, 'admin', 2084574016, 1610942144),
(551, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610942160),
(552, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610942161),
(553, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610942162),
(554, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610942163),
(555, 'admin', 'Group', 'do_edit', '', 1, 'admin', 2084574016, 1610942168),
(556, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610942170),
(557, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610942172),
(558, 'admin', 'Group', 'edit', '?void=5', 1, 'admin', 2084574016, 1610942218),
(559, 'admin', 'Group', 'do_edit', '', 1, 'admin', 2084574016, 1610942223),
(560, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610942224),
(561, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610942330),
(562, 'admin', 'Group', 'del', '?void=5', 1, 'admin', 2084574016, 1610942331),
(563, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610942333),
(564, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610942355),
(565, 'admin', 'Group', 'add', '', 1, 'admin', 2084574016, 1610942408),
(566, 'admin', 'Group', 'do_add', '', 1, 'admin', 2084574016, 1610942427),
(567, 'admin', 'Group', 'add', '', 1, 'admin', 2084574016, 1610942428),
(568, 'admin', 'Group', 'do_add', '', 1, 'admin', 2084574016, 1610942436),
(569, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610942438),
(570, 'admin', 'Group', 'dee_delall', '?tag=6,7,', 1, 'admin', 2084574016, 1610942442),
(571, 'admin', 'Group', 'dee_delall', '?tag=6,7,', 1, 'admin', 2084574016, 1610942497),
(572, 'admin', 'Group', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610942499),
(573, 'admin', 'Group', 'delall', '?tag=6,7,', 1, 'admin', 2084574016, 1610942502),
(574, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610942504),
(575, 'admin', 'Group', 'index', '?findbyname=%E9%AB%98%E5%B1%82%E9%A2%86%E5%AF%BC', 1, 'admin', 2084574016, 1610942524),
(576, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610942543),
(577, 'admin', 'Log', 'delall', '?tag=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,8', 1, 'admin', 2084574016, 1610942798),
(578, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610942800),
(579, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943219),
(580, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943263),
(581, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943314),
(582, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610943468),
(583, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610943471),
(584, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610943473),
(585, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610943475),
(586, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610943476),
(587, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610943477),
(588, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943485),
(589, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943745),
(590, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943777),
(591, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943806),
(592, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943807),
(593, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943834),
(594, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943835),
(595, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943881),
(596, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610943911),
(597, 'admin', 'Group', 'add', '', 1, 'admin', 2084574016, 1610943913),
(598, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943917),
(599, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943953),
(600, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943955),
(601, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610943980),
(602, 'admin', 'Menu', 'edit', '?void=35', 1, 'admin', 2084574016, 1610944054),
(603, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610951689),
(604, 'admin', 'Menu', 'edit', '?void=35', 1, 'admin', 2084574016, 1610951693),
(605, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610951703),
(606, 'admin', 'Menu', 'add', '', 1, 'admin', 2084574016, 1610951729),
(607, 'admin', 'Menu', 'add', '', 1, 'admin', 2084574016, 1610951773),
(608, 'admin', 'Menu', 'add', '', 1, 'admin', 2084574016, 1610952137),
(609, 'admin', 'Menu', 'add', '', 1, 'admin', 2084574016, 1610952474),
(610, 'admin', 'Menu', 'do_add', '', 1, 'admin', 2084574016, 1610952501),
(611, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610952503),
(612, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610952547),
(613, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610952808),
(614, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610952981),
(615, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610953001),
(616, 'admin', 'Menu', 'add', '', 1, 'admin', 2084574016, 1610953107),
(617, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610953120),
(618, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610953139),
(619, 'admin', 'Group', 'do_edit', '', 1, 'admin', 2084574016, 1610953148),
(620, 'admin', 'Menu', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610953152),
(621, 'admin', 'Menu', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610953154),
(622, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610953158),
(623, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610953255),
(624, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610953258),
(625, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610953262),
(626, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610953289),
(627, 'admin', 'Menu', 'do_edit', '', 1, 'admin', 2084574016, 1610953312),
(628, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610953420),
(629, 'admin', 'Menu', 'do_edit', '', 1, 'admin', 2084574016, 1610953425),
(630, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610953460),
(631, 'admin', 'Menu', 'do_edit', '', 1, 'admin', 2084574016, 1610953480),
(632, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610953530),
(633, 'admin', 'Group', 'add', '', 1, 'admin', 2084574016, 1610953531),
(634, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610953535),
(635, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610953537),
(636, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610953571),
(637, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610953573),
(638, 'admin', 'Menu', 'do_edit', '', 1, 'admin', 2084574016, 1610953626),
(639, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610953629),
(640, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610953741),
(641, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610953744),
(642, 'admin', 'Admin', 'dee_edit', '?void=15', 1, 'admin', 2084574016, 1610953749),
(643, 'admin', 'Admin', 'dee_edit', '?void=15', 1, 'admin', 2084574016, 1610953776),
(644, 'admin', 'Admin', 'dee_edit', '?void=15', 1, 'admin', 2084574016, 1610953854),
(645, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610954073),
(646, 'admin', 'Menu', 'add', '', 1, 'admin', 2084574016, 1610954076),
(647, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610954079),
(648, 'admin', 'Menu', 'do_edit', '', 1, 'admin', 2084574016, 1610954088),
(649, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610954105),
(650, 'admin', 'Menu', 'do_edit', '', 1, 'admin', 2084574016, 1610954107),
(651, 'admin', 'Menu', 'edit', '?void=36', 1, 'admin', 2084574016, 1610954118),
(652, 'admin', 'Menu', 'do_edit', '', 1, 'admin', 2084574016, 1610954124),
(653, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610954126),
(654, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610954156),
(655, 'admin', 'Admin', 'dee_edit', '?void=15', 1, 'admin', 2084574016, 1610954158),
(656, 'admin', 'Admin', 'do_dee_edit', '', 1, 'admin', 2084574016, 1610954164),
(657, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610954716),
(658, 'admin', 'Menu', 'del', '?void=36', 1, 'admin', 2084574016, 1610954735),
(659, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610954737),
(660, 'admin', 'Menu', 'index', '?findbyname=%E9%80%80%E8%B4%A7', 1, 'admin', 2084574016, 1610954744),
(661, 'admin', 'Menu', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610954746),
(662, 'admin', 'Menu', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610955350),
(663, 'admin', 'Menu', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610955351),
(664, 'admin', 'Log', 'delall', '', 1, 'admin', 2084574016, 1610955469),
(665, 'admin', 'Log', 'delall', '', 1, 'admin', 2084574016, 1610955495),
(666, 'admin', 'Log', 'delall', '', 1, 'admin', 2084574016, 1610955652),
(667, 'admin', 'Log', 'delall', '', 1, 'admin', 2084574016, 1610955701),
(668, 'admin', 'Log', 'delall', '', 1, 'admin', 2084574016, 1610955706),
(669, 'admin', 'Log', 'delall', '', 1, 'admin', 2084574016, 1610955727),
(670, 'admin', 'Log', 'delall', '', 1, 'admin', 2084574016, 1610955833),
(671, 'admin', 'Log', 'delall', '', 1, 'admin', 2084574016, 1610955845),
(672, 'admin', 'Log', 'delall', '', 1, 'admin', 2084574016, 1610955863),
(673, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610955911),
(674, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610956055),
(675, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610956066),
(676, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610956181),
(677, 'admin', 'Goods', 'add', '', 1, 'admin', 2084574016, 1610957405),
(678, 'admin', 'Goods', 'add', '', 1, 'admin', 2084574016, 1610958264),
(679, 'admin', 'Goods', 'do_add', '', 1, 'admin', 2084574016, 1610958273),
(680, 'admin', 'Goods', 'add', '', 1, 'admin', 2084574016, 1610958521),
(681, 'admin', 'Goods', 'do_add', '', 1, 'admin', 2084574016, 1610958527),
(682, 'admin', 'Goods', 'add', '', 1, 'admin', 2084574016, 1610958594),
(683, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610958628),
(684, 'admin', 'Goods', 'add', '', 1, 'admin', 2084574016, 1610958630),
(685, 'admin', 'Goods', 'do_add', '', 1, 'admin', 2084574016, 1610958720),
(686, 'admin', 'Goods', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610958722),
(687, 'admin', 'Goods', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610958854),
(688, 'admin', 'Goods', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610959156),
(689, 'admin', 'Goods', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610959299),
(690, 'admin', 'Goods', 'edit', '?void=8', 1, 'admin', 2084574016, 1610959302),
(691, 'admin', 'Goods', 'do_edit', '', 1, 'admin', 2084574016, 1610959318),
(692, 'admin', 'Goods', 'edit', '?void=8', 1, 'admin', 2084574016, 1610959338),
(693, 'admin', 'Goods', 'do_edit', '', 1, 'admin', 2084574016, 1610959344),
(694, 'admin', 'Goods', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610959347),
(695, 'admin', 'Goods', 'delall', '?tag=7,8,', 1, 'admin', 2084574016, 1610959643),
(696, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610959646),
(697, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610959682),
(698, 'admin', 'Goods', 'delall', '?tag=7,8,', 1, 'admin', 2084574016, 1610959687),
(699, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610959689),
(700, 'admin', 'Goods', 'del', '?void=8', 1, 'admin', 2084574016, 1610959692),
(701, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610959694),
(702, 'admin', 'Goods', 'delall', '?tag=8,', 1, 'admin', 2084574016, 1610959715),
(703, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610959716),
(704, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610959718),
(705, 'admin', 'Goods', 'index', '?findbyname=iPone', 1, 'admin', 2084574016, 1610959732),
(706, 'admin', 'Goods', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610959736),
(707, 'admin', 'Goods', 'index', '?findbyname=Huawei', 1, 'admin', 2084574016, 1610959742),
(708, 'admin', 'Goods', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610959744),
(709, 'admin', 'Goods', 'index', '?findbyname=', 1, 'admin', 2084574016, 1610959760),
(710, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610959766),
(711, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1610959804),
(712, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1610959831),
(713, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610959875),
(714, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610960065),
(715, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610960066),
(716, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610960067),
(717, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610960068),
(718, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610960084),
(719, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610960089),
(720, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610960090),
(721, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610960698),
(722, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610960821),
(723, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962061),
(724, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962255),
(725, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962415),
(726, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962437),
(727, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962476),
(728, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962505),
(729, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962515),
(730, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962535),
(731, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962616),
(732, 'admin', 'Orders', 'send', '', 1, 'admin', 2084574016, 1610962652),
(733, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962654),
(734, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962656),
(735, 'admin', 'Orders', 'edit', '?void=1', 1, 'admin', 2084574016, 1610962658),
(736, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610962705),
(737, 'admin', 'Orders', 'sendgoods', '?findbyname=6', 1, 'admin', 2084574016, 1610962709),
(738, 'admin', 'Orders', 'sendgoods', '?findbyname=', 1, 'admin', 2084574016, 1610962711),
(739, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610965674),
(740, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610965677),
(741, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610965680),
(742, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610965687),
(743, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610965916),
(744, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1610968000),
(745, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1610968001),
(746, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1610968004),
(747, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1610968006),
(748, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1610968189),
(749, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610968212),
(750, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1610968619),
(751, 'admin', 'Orders', 'sendedit', '?void=9', 1, 'admin', 2084574016, 1610968625),
(752, 'admin', 'Orders', 'sendgoods', '?findbyname=', 1, 'admin', 2084574016, 1610968699),
(753, 'admin', 'Orders', 'sendedit', '?void=9', 1, 'admin', 2084574016, 1610968701),
(754, 'admin', 'Orders', 'sendedit', '?void=9', 1, 'admin', 2084574016, 1610968790),
(755, 'admin', 'Orders', 'sendedit', '?void=9', 1, 'admin', 2084574016, 1610968834),
(756, 'admin', 'Orders', 'sendgoods', '?findbyname=', 1, 'admin', 2084574016, 1610968993),
(757, 'admin', 'Orders', 'sendgoods', '?findbyname=', 1, 'admin', 2084574016, 1610968994),
(758, 'admin', 'Orders', 'sendgoods', '?findbyname=', 1, 'admin', 2084574016, 1610969011),
(759, 'admin', 'Orders', 'sendgoods', '?findbyname=', 1, 'admin', 2084574016, 1610969059),
(760, 'admin', 'Orders', 'sendedit', '?void=6', 1, 'admin', 2084574016, 1610969061),
(761, 'admin', 'Orders', 'do_sendedit', '', 1, 'admin', 2084574016, 1610969063),
(762, 'admin', 'Orders', 'sendgoods', '?findbyname=', 1, 'admin', 2084574016, 1610969065),
(763, 'admin', 'Orders', 'sendgoods', '?findbyname=', 1, 'admin', 2084574016, 1610969066),
(764, 'admin', 'Orders', 'sendgoods', '?findbyname=', 1, 'admin', 2084574016, 1610969101),
(765, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610969447),
(766, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610969449),
(767, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610969452),
(768, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610969520),
(769, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610969521),
(770, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610969522),
(771, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610969575),
(772, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610969576),
(773, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610969643),
(774, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1610969749),
(775, 'admin', 'Orders', 'backedit', '?void=6', 1, 'admin', 2084574016, 1610969753),
(776, 'admin', 'Orders', 'do_backedit', '', 1, 'admin', 2084574016, 1610969760),
(777, 'admin', 'Orders', 'backgoods', '?findbyname=', 1, 'admin', 2084574016, 1610969763),
(778, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1610969776),
(779, 'admin', 'Admin', 'public_edit_info', '', 11, 'admin', 2084574016, 1611031828),
(780, 'admin', 'Admin', 'public_edit_info', '', 11, 'admin', 2084574016, 1611031856),
(781, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611031890),
(782, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1611031892),
(783, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1611031895),
(784, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1611031897),
(785, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611031902),
(786, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1611031907),
(787, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1611031909),
(788, 'admin', 'Orders', 'backedit', '?void=3', 1, 'admin', 2084574016, 1611031912),
(789, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611031917),
(790, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611032470),
(791, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611032856),
(792, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611032881),
(793, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611032905),
(794, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611032936),
(795, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611032966),
(796, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611032986),
(797, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611033000),
(798, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611033091),
(799, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611033122),
(800, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611033131),
(801, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1611033178),
(802, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1611033181),
(803, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611033182),
(804, 'admin', 'Goods', 'edit', '?void=7', 1, 'admin', 2084574016, 1611033193),
(805, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1611033199),
(806, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611033200),
(807, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611033256),
(808, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611033257),
(809, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611033408),
(810, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611033527),
(811, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611036326),
(812, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611036329),
(813, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611036371),
(814, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611036390),
(815, 'admin', 'Admin', 'do_change', '', 1, 'admin', 2084574016, 1611036391),
(816, 'admin', 'Admin', 'do_change', '', 1, 'admin', 2084574016, 1611036463),
(817, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611036465),
(818, 'admin', 'Admin', 'do_change', '', 1, 'admin', 2084574016, 1611036467),
(819, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611036542),
(820, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611036587),
(821, 'admin', 'Admin', 'do_change', '', 1, 'admin', 2084574016, 1611036665),
(822, 'admin', 'Admin', 'do_change', '', 1, 'admin', 2084574016, 1611036727),
(823, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611036728),
(824, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611037317),
(825, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611037322),
(826, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611038023),
(827, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611038661),
(828, 'admin', 'Admin', 'do_changepsd', '', 1, 'admin', 2084574016, 1611038716),
(829, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611038718),
(830, 'admin', 'Admin', 'do_changepsd', '', 1, 'admin', 2084574016, 1611038730),
(831, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611038733),
(832, 'admin', 'Admin', 'do_changepsd', '', 1, 'admin', 2084574016, 1611038767),
(833, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611038769),
(834, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611038820),
(835, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611038822),
(836, 'admin', 'Admin', 'do_changepsd', '', 1, 'admin', 2084574016, 1611038837),
(837, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611038839),
(838, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611038848),
(839, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611042460),
(840, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611042826),
(841, 'admin', 'Goods', 'index', '', 13, 'dee_good', 2084574016, 1611126764),
(842, 'admin', 'Admin', 'public_edit_info', '', 13, 'dee_good', 2084574016, 1611126766),
(843, 'admin', 'Admin', 'public_edit_info', '', 13, 'dee_good', 2084574016, 1611126836),
(844, 'admin', 'Admin', 'public_edit_info', '', 13, 'dee_good', 2084574016, 1611126871),
(845, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611126928),
(846, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611126940),
(847, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611127116),
(848, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611127195),
(849, 'admin', 'Goods', 'index', '?findbyname=HuaWei', 13, 'deeGood', 2084574016, 1611127204),
(850, 'admin', 'Goods', 'index', '?findbyname=', 13, 'deeGood', 2084574016, 1611127206),
(851, 'admin', 'Goods', 'index', '?findbyname=HuaWei', 13, 'deeGood', 2084574016, 1611127219),
(852, 'admin', 'Goods', 'index', '?findbyname=', 13, 'deeGood', 2084574016, 1611127222),
(853, 'admin', 'Admin', 'public_edit_info', '', 13, 'deeGood', 2084574016, 1611127223),
(854, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611127224),
(855, 'admin', 'Admin', 'public_edit_info', '', 13, 'deeGood', 2084574016, 1611127227),
(856, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611127239),
(857, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611127663),
(858, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611127678),
(859, 'admin', 'Admin', 'public_edit_info', '', 13, 'deeGood', 2084574016, 1611127687),
(860, 'admin', 'Admin', 'public_edit_info', '', 13, 'deeGood', 2084574016, 1611127689),
(861, 'admin', 'Admin', 'public_edit_info', '', 13, 'deeGood', 2084574016, 1611127691),
(862, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611127693),
(863, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611127727),
(864, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611127808),
(865, 'admin', 'Goods', 'add', '', 13, 'deeGood', 2084574016, 1611127811),
(866, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611128393),
(867, 'admin', 'Goods', 'add', '', 13, 'deeGood', 2084574016, 1611128395),
(868, 'admin', 'Goods', 'add', '', 13, 'deeGood', 2084574016, 1611128649),
(869, 'admin', 'Goods', 'edit', '?void=7', 13, 'deeGood', 2084574016, 1611128658),
(870, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611128718),
(871, 'admin', 'Goods', 'edit', '?void=7', 13, 'deeGood', 2084574016, 1611128721),
(872, 'admin', 'Goods', 'edit', '?void=7', 13, 'deeGood', 2084574016, 1611128788),
(873, 'admin', 'Goods', 'add', '', 13, 'deeGood', 2084574016, 1611128889),
(874, 'admin', 'Goods', 'add', '', 13, 'deeGood', 2084574016, 1611128892),
(875, 'admin', 'Goods', 'edit', '?void=7', 13, 'deeGood', 2084574016, 1611128895),
(876, 'admin', 'Goods', 'do_edit', '', 13, 'deeGood', 2084574016, 1611128905),
(877, 'admin', 'Goods', 'index', '?findbyname=', 13, 'deeGood', 2084574016, 1611128907),
(878, 'admin', 'Admin', 'public_edit_info', '', 13, 'deeGood', 2084574016, 1611130107),
(879, 'admin', 'Admin', 'do_change', '', 13, 'deeGood', 2084574016, 1611130131),
(880, 'admin', 'Admin', 'public_edit_info', '', 13, 'deeGood', 2084574016, 1611130132),
(881, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611130138),
(882, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611131316),
(883, 'admin', 'Admin', 'public_edit_info', '', 13, 'deeGood', 2084574016, 1611131321),
(884, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611131337),
(885, 'admin', 'Admin', 'public_edit_info', '', 15, 'deeLeader', 2084574016, 1611131696),
(886, 'admin', 'Admin', 'do_change', '', 15, 'deeLeader', 2084574016, 1611131728),
(887, 'admin', 'Admin', 'public_edit_info', '', 15, 'deeLeader', 2084574016, 1611131730),
(888, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611135952),
(889, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611135954),
(890, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611135956),
(891, 'admin', 'Admin', 'public_edit_info', '', 12, 'dee', 2084574016, 1611200080),
(892, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1611276622),
(893, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1611276627),
(894, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611276630),
(895, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1611276637),
(896, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1611276638),
(897, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1611276640),
(898, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611276640),
(899, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1611276651),
(900, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1611276656),
(901, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1611276920),
(902, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1611276928),
(903, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611276929),
(904, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611276931),
(905, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1611276938),
(906, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1611276944),
(907, 'admin', 'Admin', 'public_edit_info', '', 1, 'admin', 2084574016, 1611276949),
(908, 'admin', 'Group', 'index', '', 12, 'dee', 2084574016, 1611277035),
(909, 'admin', 'Goods', 'index', '', 13, 'deeGood', 2084574016, 1611277083),
(910, 'admin', 'Orders', 'sendgoods', '', 14, 'deeOrder', 2084574016, 1611277156),
(911, 'admin', 'Orders', 'backgoods', '', 14, 'deeOrder', 2084574016, 1611277162),
(912, 'admin', 'Admin', 'public_edit_info', '', 15, 'deeLeader', 2084574016, 1611277200),
(913, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611277710),
(914, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1611277715),
(915, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1611277719),
(916, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611277761),
(917, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1611277768),
(918, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1611277773),
(919, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611277778),
(920, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1611277787),
(921, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1611277790),
(922, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611277997),
(923, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611278039),
(924, 'admin', 'Admin', 'do_dee_add', '', 1, 'admin', 2084574016, 1611278071),
(925, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611278073),
(926, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611278105),
(927, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611278288),
(928, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611279475),
(929, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611279582),
(930, 'admin', 'Admin', 'dee_edit', '?void=16', 1, 'admin', 2084574016, 1611279892),
(931, 'admin', 'Admin', 'dee_edit', '?void=16', 1, 'admin', 2084574016, 1611280099),
(932, 'admin', 'Admin', 'do_dee_edit', '', 1, 'admin', 2084574016, 1611280107),
(933, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280109),
(934, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280184),
(935, 'admin', 'Admin', 'dee_edit', '?void=16', 1, 'admin', 2084574016, 1611280237),
(936, 'admin', 'Admin', 'do_dee_edit', '', 1, 'admin', 2084574016, 1611280241),
(937, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280243),
(938, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280245),
(939, 'admin', 'Admin', 'dee_edit', '?void=16', 1, 'admin', 2084574016, 1611280246),
(940, 'admin', 'Admin', 'do_dee_edit', '', 1, 'admin', 2084574016, 1611280249),
(941, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280251),
(942, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280252),
(943, 'admin', 'Admin', 'dee_edit', '?void=16', 1, 'admin', 2084574016, 1611280266),
(944, 'admin', 'Admin', 'dee_edit', '?void=16', 1, 'admin', 2084574016, 1611280386),
(945, 'admin', 'Admin', 'do_dee_edit', '', 1, 'admin', 2084574016, 1611280390),
(946, 'admin', 'Admin', 'dee_edit', '?void=16', 1, 'admin', 2084574016, 1611280392),
(947, 'admin', 'Admin', 'dee_edit', '?void=16', 1, 'admin', 2084574016, 1611280463),
(948, 'admin', 'Admin', 'dee_del', '?void=16', 1, 'admin', 2084574016, 1611280466),
(949, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611280467),
(950, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611280469),
(951, 'admin', 'Admin', 'do_dee_add', '', 1, 'admin', 2084574016, 1611280473),
(952, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280476),
(953, 'admin', 'Admin', 'dee_edit', '?void=17', 1, 'admin', 2084574016, 1611280520),
(954, 'admin', 'Admin', 'do_dee_edit', '', 1, 'admin', 2084574016, 1611280524),
(955, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280526),
(956, 'admin', 'Admin', 'dee_edit', '?void=17', 1, 'admin', 2084574016, 1611280537),
(957, 'admin', 'Admin', 'do_dee_edit', '', 1, 'admin', 2084574016, 1611280541),
(958, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280542),
(959, 'admin', 'Admin', 'index', '?findbyname=deeGood', 1, 'admin', 2084574016, 1611280604),
(960, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280935),
(961, 'admin', 'Admin', 'dee_del', '?void=17', 1, 'admin', 2084574016, 1611280937),
(962, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611280940),
(963, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611280952),
(964, 'admin', 'Admin', 'do_dee_add', '', 1, 'admin', 2084574016, 1611280954),
(965, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611280957),
(966, 'admin', 'Admin', 'dee_del', '?void=18', 1, 'admin', 2084574016, 1611280958),
(967, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611280961),
(968, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611281358),
(969, 'admin', 'Admin', 'do_dee_add', '', 1, 'admin', 2084574016, 1611281364),
(970, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611281366),
(971, 'admin', 'Admin', 'do_dee_add', '', 1, 'admin', 2084574016, 1611281369),
(972, 'admin', 'Admin', 'dee_add', '', 1, 'admin', 2084574016, 1611281370),
(973, 'admin', 'Admin', 'do_dee_add', '', 1, 'admin', 2084574016, 1611281372),
(974, 'admin', 'Admin', 'index', '?findbyname=', 1, 'admin', 2084574016, 1611281373),
(975, 'admin', 'Admin', 'dee_delall', '?tag=19,20,21,', 1, 'admin', 2084574016, 1611281410),
(976, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611281414),
(977, 'admin', 'Admin', 'index', '', 1, 'admin', 2084574016, 1611281532),
(978, 'admin', 'Group', 'index', '', 1, 'admin', 2084574016, 1611281533),
(979, 'admin', 'Menu', 'index', '', 1, 'admin', 2084574016, 1611281536),
(980, 'admin', 'Log', 'delall', '', 1, 'admin', 2084574016, 1611281612),
(981, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611281646),
(982, 'admin', 'Goods', 'edit', '?void=1', 1, 'admin', 2084574016, 1611281653),
(983, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1611281673),
(984, 'admin', 'Orders', 'sendedit', '?void=3', 1, 'admin', 2084574016, 1611281676),
(985, 'admin', 'Goods', 'index', '', 1, 'admin', 2084574016, 1611281686),
(986, 'admin', 'Goods', 'add', '', 1, 'admin', 2084574016, 1611281689),
(987, 'admin', 'Goods', 'edit', '?void=1', 1, 'admin', 2084574016, 1611281695),
(988, 'admin', 'Orders', 'sendgoods', '', 1, 'admin', 2084574016, 1611281874),
(989, 'admin', 'Orders', 'backgoods', '', 1, 'admin', 2084574016, 1611281875),
(990, 'admin', 'Orders', 'backedit', '?void=7', 1, 'admin', 2084574016, 1611281884);

-- --------------------------------------------------------

--
-- 表的结构 `web2020_goods`
--

CREATE TABLE `web2020_goods` (
  `id` int(6) NOT NULL,
  `name` varchar(20) NOT NULL,
  `des` varchar(200) NOT NULL,
  `num` int(6) NOT NULL DEFAULT '0',
  `price` float NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '是否有效(2:无效,1:有效)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `web2020_goods`
--

INSERT INTO `web2020_goods` (`id`, `name`, `des`, `num`, `price`, `status`) VALUES
(1, 'iPhone', '【24期免息】苹果12PRO Apple/苹果iPhone 12 Pro 5G手机官方天猫店国行苹果12pro 新品全新12Pro', 500, 9789, 1),
(2, 'Huawei', '24期免息/减740元 HUAWEI/华为 Mate 30 Pro 5G手机正品官方旗舰店mate30pro直降华为p40pro', 1000, 5399, 1),
(3, 'Xiaomi', 'Xiaomi/小米 小米11 pro 5G至尊版手机正品官方小米11全新骁龙888', 799, 3699, 1),
(4, 'OPPO', '[最新品手机]OPPO Reno5 opporeno5手机 5g新款上市 oppo手机官方旗舰店官网0ppo手机4se正品限量版 reno5pro', 5000, 2499, 1),
(5, 'Vivo', '【晒单赠爱奇艺月卡】vivo Y3s新款智能手机大电池官方旗舰店官网正品新品老人机vivoy3s y5s y51s y3 y70', 3999, 2299, 1),
(6, 'Samsung', '【三星W21 新品首销】Samsung/三星 心系天下 W21 5G SM-W2021 折叠屏手机 骁龙865+ 5G官方正品三星 W21', 999, 4899, 1),
(7, 'DOOV', 'DOOV/朵唯X11promax学生价游戏智能手机全面屏全网通千百元官方旗舰曲面正品网送老人老年oppo小米鼠华为耳机', 4500, 1899.99, 1);

-- --------------------------------------------------------

--
-- 表的结构 `web2020_menu`
--

CREATE TABLE `web2020_menu` (
  `id` smallint(6) UNSIGNED NOT NULL,
  `name` char(40) NOT NULL DEFAULT '',
  `parentid` smallint(6) DEFAULT '0',
  `icon` varchar(20) NOT NULL DEFAULT '',
  `c` varchar(20) DEFAULT NULL,
  `a` varchar(20) DEFAULT NULL,
  `data` varchar(50) NOT NULL DEFAULT '',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `listorder` smallint(6) UNSIGNED NOT NULL DEFAULT '999',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示(1:显示,2:不显示)',
  `updatetime` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `web2020_menu`
--

INSERT INTO `web2020_menu` (`id`, `name`, `parentid`, `icon`, `c`, `a`, `data`, `tip`, `group`, `listorder`, `display`, `updatetime`) VALUES
(1, '管理设置(系统管理员)', 0, 'xe6a3', 'Admin', 'admin', '', '', '', 1, 1, 1476175413),
(2, '用户管理', 1, '', 'Admin', 'index', '', '', '', 0, 1, 1476175413),
(7, '分组管理', 1, '', 'Group', 'index', '', '', '', 0, 1, 1476175413),
(12, '菜单管理', 18, '', 'Menu', 'index', '', '', '', 0, 1, 1476175413),
(18, '系统设置（系统管理员）', 0, 'xe6a3', 'Menu', 'index', '', '', '', 2, 1, 1476175413),
(23, '个人设置', 0, 'xe761', 'Admin', 'public_edit_info', '', '', '', 4, 1, 1476175413),
(27, '日志管理', 18, '', 'Log', 'index', '', '', '', 999, 1, 1476175413),
(31, '系统首页', 0, 'xe761', 'Index', 'index', '', '', '', 0, 1, 1476175413),
(32, '商品管理（商品管理员）', 0, 'xe6a3', 'Goods', 'index', '', '', '', 2, 1, 1476175413),
(33, '订单管理（订单管理员）', 0, 'xe6a3', 'Orders', 'index', '', '', '', 2, 1, 1476175413),
(34, '发货', 33, '', 'Orders', 'sendgoods', '', '', '', 2, 1, 1476175413),
(35, '退货', 33, '', 'Orders', 'backgoods', '', '', '', 2, 1, 1476175413),
(37, '商品管理增', 32, '', 'Goods', 'add', '', '', '', 0, 2, 1476175413),
(38, '商品管理增处理', 32, '', 'Goods', 'do_add', '', '', '', 0, 2, 1476175413),
(39, '商品管理改', 32, '', 'Goods', 'edit', '', '', '', 0, 2, 1476175413),
(40, '商品管理改处理', 32, '', 'Goods', 'do_edit', '', '', '', 0, 2, 1476175413),
(41, '商品管理删', 32, '', 'Goods', 'del', '', '', '', 0, 2, 1476175413),
(42, '商品管理删批量', 32, '', 'Goods', 'delall', '', '', '', 0, 2, 1476175413),
(43, '订单管理发货', 33, '', 'Orders', 'sendedit', '', '', '', 0, 2, 1476175413),
(44, '订单管理发货处理', 33, '', 'Orders', 'do_sendedit', '', '', '', 0, 2, 1476175413),
(45, '订单管理退货', 33, '', 'Orders', 'backedit', '', '', '', 0, 2, 1476175413),
(46, '订单管理退货处理', 33, '', 'Orders', 'do_backedit', '', '', '', 0, 2, 1476175413),
(47, '个人设置改基本信息', 23, '', 'Admin', 'do_change', '', '', '', 0, 2, 1476175413),
(48, '个人设置改密码', 23, '', 'Admin', 'do_changepsd', '', '', '', 0, 2, 1476175413),
(49, '用户管理增', 2, '', 'Admin', 'dee_add', '', '', '', 0, 2, 1476175413),
(50, '用户管理增处理', 2, '', 'Admin', 'do_dee_add', '', '', '', 0, 2, 1476175413),
(51, '用户管理改', 2, '', 'Admin', 'dee_edit', '', '', '', 0, 2, 1476175413),
(52, '用户管理改处理', 2, '', 'Admin', 'do_dee_edit', '', '', '', 0, 2, 1476175413),
(53, '用户管理删', 2, '', 'Admin', 'dee_del', '', '', '', 0, 2, 1476175413),
(54, '用户管理删批量', 2, '', 'Admin', 'dee_delall', '', '', '', 0, 2, 1476175413),
(55, '分组管理增', 7, '', 'Group', 'add', '', '', '', 0, 2, 1476175413),
(56, '分组管理增处理', 7, '', 'Group', 'do_add', '', '', '', 0, 2, 1476175413),
(57, '分组管理改', 7, '', 'Group', 'edit', '', '', '', 0, 2, 1476175413),
(58, '分组管理改处理', 7, '', 'Group', 'do_edit', '', '', '', 0, 2, 1476175413),
(59, '分组管理删', 7, '', 'Group', 'del', '', '', '', 0, 2, 1476175413),
(60, '分组管理删批量', 7, '', 'Group', 'delall', '', '', '', 0, 2, 1476175413),
(61, '菜单管理增', 12, '', 'Menu', 'add', '', '', '', 0, 2, 1476175413),
(62, '菜单管理增处理', 12, '', 'Menu', 'do_add', '', '', '', 0, 2, 1476175413),
(63, '菜单管理改', 12, '', 'Menu', 'edit', '', '', '', 0, 2, 1476175413),
(64, '菜单管理改处理', 12, '', 'Menu', 'do_edit', '', '', '', 0, 2, 1476175413),
(65, '菜单管理删', 12, '', 'Menu', 'del', '', '', '', 0, 2, 1476175413),
(66, '菜单管理删批量', 12, '', 'Menu', 'delall', '', '', '', 0, 2, 1476175413),
(67, '日志管理删批量', 27, '', 'Log', 'delall', '', '', '', 0, 2, 1476175413);

-- --------------------------------------------------------

--
-- 表的结构 `web2020_orders`
--

CREATE TABLE `web2020_orders` (
  `id` int(6) NOT NULL,
  `user_id` int(6) NOT NULL,
  `good_id` int(6) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'waiting' COMMENT '等待（waiting）接收（accept）付款（payment）发货（delivery）成功（success）失败（failure）',
  `createtime` int(10) NOT NULL DEFAULT '0' COMMENT '本状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `web2020_orders`
--

INSERT INTO `web2020_orders` (`id`, `user_id`, `good_id`, `status`, `createtime`) VALUES
(1, 1, 1, 'accept', 1610700785),
(3, 2, 4, 'payment', 1610700800),
(4, 2, 2, 'failure', 1610700810),
(5, 1, 4, 'waiting', 1610700785),
(6, 1, 5, 'failure', 1610700785),
(7, 1, 6, 'delivery', 1610700785),
(8, 1, 7, 'success', 1610700785),
(16, 3, 1, 'waiting', 1611051996),
(17, 3, 2, 'accept', 1611052178),
(18, 3, 3, 'accept', 1611237819),
(19, 3, 4, 'accept', 1611237992),
(20, 3, 5, 'accept', 1611238409),
(21, 3, 6, 'accept', 1611238503),
(23, 4, 4, 'accept', 1611289836),
(24, 4, 4, 'accept', 1611289836),
(25, 4, 4, 'accept', 1611289836),
(26, 4, 4, 'accept', 1611289836),
(27, 4, 4, 'accept', 1611289836),
(28, 4, 4, 'accept', 1611289836),
(29, 4, 4, 'accept', 1611289836),
(30, 4, 4, 'accept', 1611289836),
(31, 4, 4, 'failure', 1611289836),
(32, 4, 4, 'failure', 1611289836),
(33, 4, 4, 'failure', 1611289836),
(34, 4, 4, 'failure', 1611289836),
(35, 4, 4, 'failure', 1611289836),
(36, 4, 4, 'failure', 1611289836),
(37, 4, 4, 'failure', 1611289836),
(38, 4, 4, 'failure', 1611289836),
(39, 4, 4, 'failure', 1611289836),
(40, 4, 4, 'failure', 1611289836),
(41, 4, 4, 'failure', 1611289836),
(42, 4, 4, 'failure', 1611289836),
(43, 4, 4, 'failure', 1611289836),
(44, 4, 4, 'failure', 1611289836),
(45, 4, 4, 'failure', 1611289836),
(46, 4, 4, 'failure', 1611289836),
(47, 4, 4, 'failure', 1611289836),
(48, 4, 4, 'failure', 1611289836),
(49, 4, 4, 'failure', 1611289836),
(50, 4, 4, 'failure', 1611289836),
(51, 4, 4, 'failure', 1611289836),
(52, 4, 4, 'failure', 1611289836),
(53, 4, 4, 'failure', 1611289836),
(54, 4, 4, 'failure', 1611289836),
(55, 4, 4, 'failure', 1611289836),
(56, 4, 4, 'failure', 1611289836),
(57, 4, 4, 'failure', 1611289836),
(58, 4, 4, 'failure', 1611289836),
(59, 4, 4, 'failure', 1611289836),
(60, 4, 4, 'failure', 1611289836),
(61, 4, 4, 'failure', 1611289836),
(62, 4, 4, 'failure', 1611289836),
(63, 4, 4, 'failure', 1611289836),
(64, 4, 4, 'failure', 1611289836),
(65, 4, 4, 'failure', 1611289836),
(66, 4, 4, 'failure', 1611289836),
(67, 4, 4, 'failure', 1611289836),
(68, 4, 4, 'failure', 1611289836),
(69, 4, 4, 'failure', 1611289836),
(70, 4, 4, 'failure', 1611289836),
(71, 4, 4, 'failure', 1611289836),
(72, 4, 4, 'failure', 1611289836),
(73, 4, 4, 'failure', 1611289836),
(74, 4, 4, 'failure', 1611289836),
(75, 4, 4, 'failure', 1611289836),
(76, 4, 4, 'failure', 1611289836),
(77, 4, 4, 'failure', 1611289836),
(78, 4, 4, 'failure', 1611289836),
(79, 4, 4, 'failure', 1611289836),
(80, 4, 4, 'failure', 1611289836),
(81, 4, 4, 'failure', 1611289836),
(82, 4, 4, 'failure', 1611289836),
(83, 4, 4, 'failure', 1611289836),
(84, 4, 4, 'failure', 1611289836),
(85, 4, 4, 'failure', 1611289836),
(86, 4, 4, 'failure', 1611289836),
(87, 4, 4, 'failure', 1611289836),
(88, 4, 4, 'failure', 1611289836),
(89, 4, 4, 'failure', 1611289836),
(90, 4, 4, 'failure', 1611289836),
(91, 4, 4, 'failure', 1611289836),
(92, 4, 4, 'failure', 1611289836),
(93, 4, 4, 'failure', 1611289836),
(94, 4, 4, 'failure', 1611289836),
(95, 4, 4, 'failure', 1611289836),
(96, 4, 4, 'failure', 1611289836),
(97, 4, 4, 'failure', 1611289836),
(98, 4, 4, 'failure', 1611289836),
(99, 4, 4, 'failure', 1611289836),
(100, 4, 4, 'failure', 1611289836),
(101, 4, 4, 'failure', 1611289836),
(102, 4, 4, 'failure', 1611289836),
(103, 4, 4, 'failure', 1611289836),
(104, 4, 4, 'failure', 1611289836),
(105, 4, 4, 'failure', 1611289836),
(106, 4, 4, 'failure', 1611289836),
(107, 4, 4, 'failure', 1611289836),
(108, 4, 4, 'failure', 1611289836),
(109, 4, 4, 'failure', 1611289836),
(110, 4, 4, 'failure', 1611289836),
(111, 4, 4, 'failure', 1611289836),
(112, 4, 4, 'failure', 1611289836),
(113, 4, 4, 'failure', 1611289836),
(114, 4, 4, 'failure', 1611289836),
(115, 4, 4, 'failure', 1611289836),
(116, 4, 4, 'failure', 1611289836),
(117, 4, 4, 'failure', 1611289836),
(118, 4, 4, 'failure', 1611289836),
(119, 4, 4, 'failure', 1611289836),
(120, 4, 4, 'failure', 1611289836),
(121, 4, 4, 'failure', 1611289836),
(122, 4, 4, 'failure', 1611289836);

-- --------------------------------------------------------

--
-- 表的结构 `web2020_user`
--

CREATE TABLE `web2020_user` (
  `id` int(6) UNSIGNED NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '状态（1：正常 2：危险用户）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `web2020_user`
--

INSERT INTO `web2020_user` (`id`, `username`, `password`, `status`) VALUES
(1, 'user1', 'b562e977a58c33f443df8f3067711a28', 1),
(2, 'user2', 'b562e977a58c33f443df8f3067711a28', 1),
(3, 'user3', 'b562e977a58c33f443df8f3067711a28', 1),
(4, 'user4', 'b562e977a58c33f443df8f3067711a28', 1);

--
-- 转储表的索引
--

--
-- 表的索引 `web2020_admin`
--
ALTER TABLE `web2020_admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`),
  ADD KEY `status` (`status`);

--
-- 表的索引 `web2020_admin_group`
--
ALTER TABLE `web2020_admin_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `listorder` (`listorder`);

--
-- 表的索引 `web2020_admin_group_access`
--
ALTER TABLE `web2020_admin_group_access`
  ADD UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `group_id` (`group_id`);

--
-- 表的索引 `web2020_admin_log`
--
ALTER TABLE `web2020_admin_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `web2020_goods`
--
ALTER TABLE `web2020_goods`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `web2020_menu`
--
ALTER TABLE `web2020_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `listorder` (`listorder`),
  ADD KEY `parentid` (`parentid`);

--
-- 表的索引 `web2020_orders`
--
ALTER TABLE `web2020_orders`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `web2020_user`
--
ALTER TABLE `web2020_user`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `web2020_admin`
--
ALTER TABLE `web2020_admin`
  MODIFY `id` mediumint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- 使用表AUTO_INCREMENT `web2020_admin_group`
--
ALTER TABLE `web2020_admin_group`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `web2020_admin_log`
--
ALTER TABLE `web2020_admin_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=991;

--
-- 使用表AUTO_INCREMENT `web2020_goods`
--
ALTER TABLE `web2020_goods`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `web2020_menu`
--
ALTER TABLE `web2020_menu`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- 使用表AUTO_INCREMENT `web2020_orders`
--
ALTER TABLE `web2020_orders`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- 使用表AUTO_INCREMENT `web2020_user`
--
ALTER TABLE `web2020_user`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
