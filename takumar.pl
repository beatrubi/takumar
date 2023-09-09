#!/usr/bin/perl
#
# Display the picture of the day
#
# Version 1.0 (C) 9.2023 by Beat Rubischon <beat@0x1b.ch>
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
use strict;
use warnings;
use Cwd qw(cwd);

my $debug=1;
my $today;

#
# mapping
my %pic=(
  "0101" => "7N9A9713.jpeg",
  "0102" => "7N9A9721.jpeg",
  "0103" => "7N9A9723.jpeg",
  "0104" => "7N9A9727.jpeg",
  "0105" => "7N9A9736.jpeg",
  "0106" => "7N9A9743.jpeg",
  "0107" => "7N9A9745.jpeg",
  "0108" => "7N9A9805.jpeg",
  "0109" => "7N9A9814.jpeg",
  "0110" => "7N9A9817.jpeg",
  "0111" => "7N9A9819.jpeg",
  "0112" => "7N9A9823.jpeg",
  "0113" => "7N9A9828.jpeg",
  "0114" => "7N9A9830.jpeg",
  "0115" => "7N9A9834.jpeg",
  "0116" => "7N9A9837.jpeg",
  "0117" => "7N9A9845.jpeg",
  "0118" => "7N9A9855.jpeg",
  "0119" => "7N9A9857.jpeg",
  "0120" => "7N9A9863.jpeg",
  "0121" => "7N9A9868.jpeg",
  "0122" => "7N9A9872.jpeg",
  "0123" => "7N9A9876.jpeg",
  "0124" => "7N9A0071.jpeg",
  "0125" => "7N9A0074.jpeg",
  "0126" => "7N9A0077.jpeg",
  "0127" => "7N9A0083.jpeg",
  "0128" => "7N9A0086.jpeg",
  "0129" => "7N9A0108.jpeg",
  "0130" => "7N9A0371.jpeg",
  "0131" => "7N9A0373.jpeg",
  "0201" => "7N9A1029.jpeg",
  "0202" => "7N9A1031.jpeg",
  "0203" => "7N9A1041.jpeg",
  "0204" => "7N9A1050.jpeg",
  "0205" => "7N9A1115.jpeg",
  "0206" => "7N9A1120.jpeg",
  "0207" => "7N9A1124.jpeg",
  "0208" => "7N9A1126.jpeg",
  "0209" => "7N9A1131.jpeg",
  "0210" => "7N9A1133.jpeg",
  "0211" => "7N9A1136.jpeg",
  "0212" => "7N9A1138.jpeg",
  "0213" => "7N9A1140.jpeg",
  "0214" => "7N9A1142.jpeg",
  "0215" => "7N9A1144.jpeg",
  "0216" => "7N9A1148.jpeg",
  "0217" => "7N9A1152.jpeg",
  "0218" => "7N9A1154.jpeg",
  "0219" => "7N9A1156.jpeg",
  "0220" => "7N9A1158.jpeg",
  "0221" => "7N9A1163.jpeg",
  "0222" => "7N9A1166.jpeg",
  "0223" => "7N9A1168.jpeg",
  "0224" => "7N9A1172.jpeg",
  "0225" => "7N9A1176.jpeg",
  "0226" => "7N9A1283.jpeg",
  "0227" => "7N9A1287.jpeg",
  "0228" => "7N9A1291.jpeg",
  "0229" => "7N9A1291.jpeg",
  "0301" => "7N9A1296.jpeg",
  "0302" => "7N9A1301.jpeg",
  "0303" => "7N9A1308.jpeg",
  "0304" => "7N9A1319.jpeg",
  "0305" => "7N9A1324.jpeg",
  "0306" => "7N9A1326.jpeg",
  "0307" => "7N9A1331.jpeg",
  "0308" => "7N9A1334.jpeg",
  "0309" => "7N9A1341.jpeg",
  "0310" => "7N9A1343.jpeg",
  "0311" => "7N9A1347.jpeg",
  "0312" => "7N9A1351.jpeg",
  "0313" => "7N9A1358.jpeg",
  "0314" => "7N9A1361.jpeg",
  "0315" => "7N9A1364.jpeg",
  "0316" => "7N9A1368.jpeg",
  "0317" => "7N9A1375.jpeg",
  "0318" => "7N9A1377.jpeg",
  "0319" => "7N9A1383.jpeg",
  "0320" => "7N9A1385.jpeg",
  "0321" => "7N9A1390.jpeg",
  "0322" => "7N9A1392.jpeg",
  "0323" => "7N9A1395.jpeg",
  "0324" => "7N9A1398.jpeg",
  "0325" => "7N9A1402.jpeg",
  "0326" => "7N9A1410.jpeg",
  "0327" => "7N9A1412.jpeg",
  "0328" => "7N9A1415.jpeg",
  "0329" => "7N9A1417.jpeg",
  "0330" => "7N9A1419.jpeg",
  "0331" => "7N9A1420.jpeg",
  "0401" => "7N9A1423.jpeg",
  "0402" => "7N9A1426.jpeg",
  "0403" => "7N9A1428.jpeg",
  "0404" => "7N9A1430.jpeg",
  "0405" => "7N9A1434.jpeg",
  "0406" => "7N9A1436.jpeg",
  "0407" => "7N9A1445.jpeg",
  "0408" => "7N9A1449.jpeg",
  "0409" => "7N9A1453.jpeg",
  "0410" => "7N9A1456.jpeg",
  "0411" => "7N9A1458.jpeg",
  "0412" => "7N9A1464.jpeg",
  "0413" => "7N9A1467.jpeg",
  "0414" => "7N9A1468.jpeg",
  "0415" => "7N9A1471.jpeg",
  "0416" => "7N9A1478.jpeg",
  "0417" => "7N9A1514.jpeg",
  "0418" => "7N9A1568.jpeg",
  "0419" => "7N9A1572.jpeg",
  "0420" => "7N9A1575.jpeg",
  "0421" => "7N9A1581.jpeg",
  "0422" => "7N9A1584.jpeg",
  "0423" => "7N9A1592.jpeg",
  "0424" => "7N9A1593.jpeg",
  "0425" => "7N9A1608.jpeg",
  "0426" => "7N9A1618.jpeg",
  "0427" => "7N9A1627.jpeg",
  "0428" => "7N9A1636.jpeg",
  "0429" => "7N9A1640.jpeg",
  "0430" => "7N9A1666.jpeg",
  "0501" => "7N9A1672.jpeg",
  "0502" => "7N9A1676.jpeg",
  "0503" => "7N9A1680.jpeg",
  "0504" => "7N9A1683.jpeg",
  "0505" => "7N9A1697.jpeg",
  "0506" => "7N9A1704.jpeg",
  "0507" => "7N9A1706.jpeg",
  "0508" => "7N9A1710.jpeg",
  "0509" => "7N9A1714.jpeg",
  "0510" => "7N9A1718.jpeg",
  "0511" => "7N9A1721.jpeg",
  "0512" => "7N9A1786.jpeg",
  "0513" => "7N9A1795.jpeg",
  "0514" => "7N9A1800.jpeg",
  "0515" => "7N9A1806.jpeg",
  "0516" => "7N9A1809.jpeg",
  "0517" => "7N9A1813.jpeg",
  "0518" => "7N9A2062.jpeg",
  "0519" => "7N9A2066.jpeg",
  "0520" => "7N9A2068.jpeg",
  "0521" => "7N9A2072.jpeg",
  "0522" => "7N9A2083.jpeg",
  "0523" => "7N9A2089.jpeg",
  "0524" => "7N9A2091.jpeg",
  "0525" => "7N9A2093.jpeg",
  "0526" => "7N9A2100.jpeg",
  "0527" => "7N9A2104.jpeg",
  "0528" => "7N9A2110.jpeg",
  "0529" => "7N9A2134.jpeg",
  "0530" => "7N9A2141.jpeg",
  "0531" => "7N9A2143.jpeg",
  "0601" => "7N9A2145.jpeg",
  "0602" => "7N9A2147.jpeg",
  "0603" => "7N9A2159.jpeg",
  "0604" => "7N9A2161.jpeg",
  "0605" => "7N9A2173.jpeg",
  "0606" => "7N9A2175.jpeg",
  "0607" => "7N9A2179.jpeg",
  "0608" => "7N9A2187.jpeg",
  "0609" => "7N9A2192.jpeg",
  "0610" => "7N9A2193.jpeg",
  "0611" => "7N9A2195.jpeg",
  "0612" => "7N9A2206.jpeg",
  "0613" => "7N9A2208.jpeg",
  "0614" => "7N9A2209.jpeg",
  "0615" => "7N9A2215.jpeg",
  "0616" => "7N9A2223.jpeg",
  "0617" => "7N9A2237.jpeg",
  "0618" => "7N9A2240.jpeg",
  "0619" => "7N9A2252.jpeg",
  "0620" => "7N9A2259.jpeg",
  "0621" => "7N9A2273.jpeg",
  "0622" => "7N9A2275.jpeg",
  "0623" => "7N9A2287.jpeg",
  "0624" => "7N9A2293.jpeg",
  "0625" => "7N9A2340.jpeg",
  "0626" => "7N9A2347.jpeg",
  "0627" => "7N9A2351.jpeg",
  "0628" => "7N9A2358.jpeg",
  "0629" => "7N9A2367.jpeg",
  "0630" => "7N9A2372.jpeg",
  "0701" => "7N9A2380.jpeg",
  "0702" => "7N9A2391.jpeg",
  "0703" => "7N9A2395.jpeg",
  "0704" => "7N9A2397.jpeg",
  "0705" => "7N9A2400.jpeg",
  "0706" => "7N9A2493.jpeg",
  "0707" => "7N9A2496.jpeg",
  "0708" => "7N9A2847.jpeg",
  "0709" => "7N9A3310.jpeg",
  "0710" => "7N9A3313.jpeg",
  "0711" => "7N9A3318.jpeg",
  "0712" => "7N9A3323.jpeg",
  "0714" => "7N9A3325.jpeg",
  "0714" => "7N9A3335.jpeg",
  "0715" => "7N9A3337.jpeg",
  "0716" => "7N9A3342.jpeg",
  "0717" => "7N9A3344.jpeg",
  "0718" => "7N9A3346.jpeg",
  "0719" => "7N9A3355.jpeg",
  "0720" => "7N9A3365.jpeg",
  "0721" => "7N9A3372.jpeg",
  "0722" => "7N9A3377.jpeg",
  "0723" => "7N9A3396.jpeg",
  "0724" => "7N9A3460.jpeg",
  "0725" => "7N9A3464.jpeg",
  "0726" => "7N9A3490.jpeg",
  "0727" => "7N9A3493.jpeg",
  "0728" => "7N9A3498.jpeg",
  "0729" => "7N9A3501.jpeg",
  "0730" => "7N9A3505.jpeg",
  "0731" => "7N9A3509.jpeg",
  "0801" => "7N9A3513.jpeg",
  "0802" => "7N9A3520.jpeg",
  "0803" => "7N9A3523.jpeg",
  "0804" => "7N9A3525.jpeg",
  "0805" => "7N9A3529.jpeg",
  "0806" => "7N9A3531.jpeg",
  "0807" => "7N9A3539.jpeg",
  "0808" => "7N9A3548.jpeg",
  "0809" => "7N9A3555.jpeg",
  "0810" => "7N9A3561.jpeg",
  "0811" => "7N9A3562.jpeg",
  "0812" => "7N9A3567.jpeg",
  "0813" => "7N9A3578.jpeg",
  "0814" => "7N9A3594.jpeg",
  "0815" => "7N9A3603.jpeg",
  "0816" => "7N9A3609.jpeg",
  "0817" => "7N9A3624.jpeg",
  "0818" => "7N9A3752.jpeg",
  "0819" => "7N9A4917.jpeg",
  "0820" => "7N9A5043.jpeg",
  "0821" => "7N9A5062.jpeg",
  "0822" => "7N9A5067.jpeg",
  "0823" => "7N9A5072.jpeg",
  "0824" => "7N9A5085.jpeg",
  "0825" => "7N9A5090.jpeg",
  "0826" => "7N9A5097.jpeg",
  "0827" => "7N9A5100.jpeg",
  "0828" => "7N9A5103.jpeg",
  "0829" => "7N9A5105.jpeg",
  "0830" => "7N9A5113.jpeg",
  "0831" => "7N9A5120.jpeg",

  "0901" => "7N9A3513.jpeg",
  "0902" => "7N9A3520.jpeg",
  "0903" => "7N9A3523.jpeg",
  "0904" => "7N9A3525.jpeg",
  "0905" => "7N9A3529.jpeg",
  "0906" => "7N9A3531.jpeg",
  "0907" => "7N9A3539.jpeg",
  "0908" => "7N9A3548.jpeg",
  "0909" => "7N9A3555.jpeg",
  "0910" => "7N9A3561.jpeg",
  "0911" => "7N9A3562.jpeg",
  "0912" => "7N9A3567.jpeg",
  "0913" => "7N9A3578.jpeg",
  "0914" => "7N9A3594.jpeg",
  "0915" => "7N9A3603.jpeg",
  "0916" => "7N9A3609.jpeg",
  "0917" => "7N9A3624.jpeg",
  "0918" => "7N9A3752.jpeg",
  "0919" => "7N9A4917.jpeg",
  "0920" => "7N9A5043.jpeg",
  "0921" => "7N9A5062.jpeg",
  "0922" => "7N9A5067.jpeg",
  "0923" => "7N9A5072.jpeg",
  "0924" => "7N9A5085.jpeg",
  "0925" => "7N9A5090.jpeg",
  "0926" => "7N9A5097.jpeg",
  "0927" => "7N9A5100.jpeg",
  "0928" => "7N9A5103.jpeg",
  "0929" => "7N9A5105.jpeg",
  "0930" => "7N9A5113.jpeg",

  "1001" => "7N9A6236.jpeg",
  "1002" => "7N9A6237.jpeg",
  "1003" => "7N9A6243.jpeg",
  "1004" => "7N9A6248.jpeg",
  "1005" => "7N9A6252.jpeg",
  "1006" => "7N9A6256.jpeg",
  "1007" => "7N9A6260.jpeg",
  "1008" => "7N9A6278.jpeg",
  "1009" => "7N9A6283.jpeg",
  "1010" => "7N9A6284.jpeg",
  "1011" => "7N9A6286.jpeg",
  "1012" => "7N9A6288.jpeg",
  "1013" => "7N9A6307.jpeg",
  "1014" => "7N9A6313.jpeg",
  "1015" => "7N9A6321.jpeg",
  "1016" => "7N9A6325.jpeg",
  "1017" => "7N9A6337.jpeg",
  "1018" => "7N9A6344.jpeg",
  "1019" => "7N9A6349.jpeg",
  "1020" => "7N9A6358.jpeg",
  "1021" => "7N9A6360.jpeg",
  "1022" => "7N9A6374.jpeg",
  "1023" => "7N9A6403.jpeg",
  "1024" => "7N9A6404.jpeg",
  "1025" => "7N9A6441.jpeg",
  "1026" => "7N9A6445.jpeg",
  "1027" => "7N9A6448.jpeg",
  "1028" => "7N9A6453.jpeg",
  "1029" => "7N9A6457.jpeg",
  "1030" => "7N9A6500.jpeg",
  "1031" => "7N9A6548.jpeg",
  "1101" => "7N9A6549.jpeg",
  "1102" => "7N9A6554.jpeg",
  "1103" => "7N9A6566.jpeg",
  "1104" => "7N9A6568.jpeg",
  "1105" => "7N9A6573.jpeg",
  "1106" => "7N9A6743.jpeg",
  "1107" => "7N9A6749.jpeg",
  "1108" => "7N9A6756.jpeg",
  "1109" => "7N9A6767.jpeg",
  "1110" => "7N9A6773.jpeg",
  "1111" => "7N9A6849.jpeg",
  "1112" => "7N9A6853.jpeg",
  "1113" => "7N9A6947.jpeg",
  "1114" => "7N9A6972.jpeg",
  "1115" => "7N9A6990.jpeg",
  "1116" => "7N9A6993.jpeg",
  "1117" => "7N9A6997.jpeg",
  "1118" => "7N9A7005.jpeg",
  "1119" => "7N9A7166.jpeg",
  "1120" => "7N9A7168.jpeg",
  "1121" => "7N9A7169.jpeg",
  "1122" => "7N9A7171.jpeg",
  "1123" => "7N9A7176.jpeg",
  "1124" => "7N9A7177.jpeg",
  "1125" => "7N9A7179.jpeg",
  "1126" => "7N9A7182.jpeg",
  "1127" => "7N9A7189.jpeg",
  "1128" => "7N9A7389.jpeg",
  "1129" => "7N9A7390.jpeg",
  "1130" => "7N9A7648.jpeg",
  "1201" => "7N9A7766.jpeg",
  "1202" => "7N9A7774.jpeg",
  "1203" => "7N9A7778.jpeg",
  "1204" => "7N9A7780.jpeg",
  "1205" => "7N9A7786.jpeg",
  "1206" => "7N9A7801.jpeg",
  "1207" => "7N9A7803.jpeg",
  "1208" => "7N9A7806.jpeg",
  "1209" => "7N9A7817.jpeg",
  "1210" => "7N9A7822.jpeg",
  "1211" => "7N9A7827.jpeg",
  "1212" => "7N9A7836.jpeg",
  "1213" => "7N9A7839.jpeg",
  "1214" => "7N9A8237.jpeg",
  "1215" => "7N9A8240.jpeg",
  "1216" => "7N9A8242.jpeg",
  "1217" => "7N9A8247.jpeg",
  "1218" => "7N9A8258.jpeg",
  "1219" => "7N9A8269.jpeg",
  "1220" => "7N9A8276.jpeg",
  "1221" => "7N9A8312.jpeg",
  "1222" => "7N9A8314.jpeg",
  "1223" => "7N9A8321.jpeg",
  "1224" => "7N9A8326.jpeg",
  "1225" => "7N9A9307.jpeg",
  "1226" => "7N9A9635.jpeg",
  "1228" => "7N9A9637.jpeg",
  "1228" => "7N9A9639.jpeg",
  "1229" => "7N9A9641.jpeg",
  "1230" => "7N9A9647.jpeg",
  "1231" => "7N9A9653.jpeg",
);

#
# open debug log
if ($debug) {
  open LOG, ">".$ENV{'HOME'}."/Library/Logs/Takumar.log";
  select LOG;
  $|=1;
  select STDOUT;
}

#
# fork off sleepwatcher
my $pid=open WATCH, "-|";
if ($pid == 0) {
  exec cwd()."/sleepwatcher", "-w", "/bin/echo";
}

#
# main loop
while(1) {

  # get current time
  my $now=time;
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime($now);

  if ($debug) {
    print LOG "now: ".scalar localtime($now);
  }

  # check if we have a new day
  if (! defined $today or $today < $yday or $today != 0 and $yday == 0) {
    $today=$yday;
    my $mmdd=sprintf "%02i%02i", $mon+1, $mday;
    if ($debug) {
      print LOG ", image: $mmdd";
    }
    unlink $ENV{'HOME'}."/Pictures/Wallpaper.jpeg";
    symlink cwd()."/Pictures/".$pic{$mmdd},
      $ENV{'HOME'}."/Pictures/Wallpaper.jpeg";
    system "killall Dock";
  }

  # take a nap until tomorrow
  my $sleep=(23-$hour)*3600 + (59-$min)*60 + (59-$sec) + 2;
  if ($debug) {
    print LOG ", next: ".scalar localtime($now + $sleep)."\n";
  }

  # sleep and listen to sleepwatcher
  my $rin="";
  my $rout;
  vec($rin,fileno(WATCH),1) = 1;
  if (select($rout=$rin, undef, undef, $sleep)) {
    my $byte;
    sysread(WATCH, $byte, 1);
    if ($debug) {
      print LOG "...returned from suspend...\n";
    }
  }
}