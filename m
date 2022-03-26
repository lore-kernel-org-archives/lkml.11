Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B3DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 10:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiCZK3R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 06:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiCZK3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:29:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CED1C931;
        Sat, 26 Mar 2022 03:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3464160B70;
        Sat, 26 Mar 2022 10:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F31DC36AE3;
        Sat, 26 Mar 2022 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648290447;
        bh=D/w5PLTmwlSeMty7ZislHjJrVsonNmYqlWvibM6bjos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYE2WOtnWTlVl7RwQCOnNMIUwmKumKCvdrp23AY5azoXD44AJl73c+MNsPxviPKnP
         NXJTUizOR7BdDDgdFzVfUy29edVPStAypwloISfzgXHwbo9Z2kHurdbG7YuAtHhCqp
         mR5xijjlU+ohvBQ33K7z77ole7qNg9a++eL2Fl9b/h/KOXvqIRPRZLnHRfePuKND+w
         qczp0H7hmeWqOQvgCXfZ4acwXAB70MgOxVJhuxOuI9ii3bj4wW3EFGNkxaHyyQ8M7V
         KsLvYhdx+xA2VpAJqr9h4+59SlK0ESXPROcfXLiHmT3sQoWgLK87anBw5KJ0r59gfF
         MCIUFRXHmJ50A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nY3dl-00Co0o-9b; Sat, 26 Mar 2022 11:27:25 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] scripts/kernel-doc: change the line number meta info
Date:   Sat, 26 Mar 2022 11:27:24 +0100
Message-Id: <40725032b5a4a33db740bf1de397523af958ff8a.1648290305.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648290305.git.mchehab@kernel.org>
References: <cover.1648290305.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make it more standard and ReST compatible,
change the meta-tag used with --enable-lineno from:

        #define LINENO

to
        .. LINENO

In practice, no	functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 0/6] at: https://lore.kernel.org/all/cover.1648290305.git.mchehab@kernel.org/

 Documentation/sphinx/kerneldoc.py | 2 +-
 scripts/kernel-doc                | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 8189c33b9dda..9395892c7ba3 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -130,7 +130,7 @@ class KernelDocDirective(Directive):
             result = ViewList()
 
             lineoffset = 0;
-            line_regex = re.compile("^#define LINENO ([0-9]+)$")
+            line_regex = re.compile("^\.\. LINENO ([0-9]+)$")
             for line in lines:
                 match = line_regex.search(line)
                 if match:
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 9c084a2ba3b0..7516949bb049 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -424,7 +424,7 @@ sub get_kernel_version() {
 sub print_lineno {
     my $lineno = shift;
     if ($enable_lineno && defined($lineno)) {
-        print "#define LINENO " . $lineno . "\n";
+        print ".. LINENO " . $lineno . "\n";
     }
 }
 ##
@@ -2478,7 +2478,7 @@ May be specified multiple times.
 
 =item -enable-lineno
 
-Enable output of #define LINENO lines.
+Enable output of .. LINENO lines.
 
 =back
 
-- 
2.35.1

