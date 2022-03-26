Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFC6C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 10:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiCZK3h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiCZK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:29:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3565D5C3;
        Sat, 26 Mar 2022 03:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC5EFB802C3;
        Sat, 26 Mar 2022 10:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1A0C340EE;
        Sat, 26 Mar 2022 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648290447;
        bh=fCUCDroTYXYqWyLmO/RKepuGt/+Ob6vZ/0OEXNI48dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOn18vpF92boutfkaYVD/c+vPT9O1nXmghUBSb3aUkzl+ZF2+8cXkabG0nKqvg9p1
         cwMpZ8koUid5xCsgO/5yeyZUe2/ipOzBiVC0pdD850PeDgvVfD5J/HzKswBWiq7G9f
         PyXLq/JVFtFwpOIYI/8vHJ1PHcXoeGbtVdX49t72mienTt35Qukui5lU4Ii1uTLYD0
         kgKP/8qgK2O4DJ3I3Q6UDIyElESTA8horrFgXOC6yHr8pyScM0PnO//31D5ZjwGJHg
         //1ZeelDVSI14zc8yuS9DqFDZG6EVTFrYAKqSd1r17DgQOtCsuOiRIQ6PCD4YcLK9t
         Kr/4cuoU+8AqQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nY3dl-00Co0U-20; Sat, 26 Mar 2022 11:27:25 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] scripts/get_feat.pl: allow output the parsed file names
Date:   Sat, 26 Mar 2022 11:27:19 +0100
Message-Id: <11b438ee01e00c866f5ea197d6aecc26e9f86945.1648290305.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648290305.git.mchehab@kernel.org>
References: <cover.1648290305.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such output could be helpful while debugging it, but its main
goal is to tell kernel_feat.py about what files were used
by the script. Thie way, kernel_feat.py can add those as
documentation dependencies.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 0/6] at: https://lore.kernel.org/all/cover.1648290305.git.mchehab@kernel.org/

 scripts/get_feat.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 457712355676..76cfb96b59b6 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -13,6 +13,7 @@ my $man;
 my $debug;
 my $arch;
 my $feat;
+my $enable_fname;
 
 my $basename = abs_path($0);
 $basename =~ s,/[^/]+$,/,;
@@ -31,6 +32,7 @@ GetOptions(
 	'arch=s' => \$arch,
 	'feat=s' => \$feat,
 	'feature=s' => \$feat,
+	"enable-fname" => \$enable_fname,
 	man => \$man
 ) or pod2usage(2);
 
@@ -95,6 +97,10 @@ sub parse_feat {
 	return if ($file =~ m,($prefix)/arch-support.txt,);
 	return if (!($file =~ m,arch-support.txt$,));
 
+	if ($enable_fname) {
+		printf ".. FILE %s\n", abs_path($file);
+	}
+
 	my $subsys = "";
 	$subsys = $2 if ( m,.*($prefix)/([^/]+).*,);
 
@@ -580,6 +586,11 @@ Output features for a single specific feature.
 Changes the location of the Feature files. By default, it uses
 the Documentation/features directory.
 
+=item B<--enable-fname>
+
+Prints the file name of the feature files. This can be used in order to
+track dependencies during documentation build.
+
 =item B<--debug>
 
 Put the script in verbose mode, useful for debugging. Can be called multiple
-- 
2.35.1

