Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F321C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 23:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348830AbiEPXrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 19:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiEPXrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 19:47:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAFF25C5B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 16:47:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: cristicc)
        with ESMTPSA id BB36F1F44019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652744821;
        bh=DHUSCwf9UzRa0+0DDqpAhAGHmXhK7Som9a0VSUoUloA=;
        h=From:To:Cc:Subject:Date:From;
        b=WV/ydii3S9IARwutxe0d2LFbLFutuHDN83jr9tnlOq0+XjhcZ9Ow41EUEjhux8If/
         f1KYOiQAcaG3abHVHHq+jADysHwNEJnB9eBJShO5Vl2oTo4T2qgmd2NQ5hUVTKLs/W
         RSOqK8Fq9A0sBG3LzcYN6fTkOXQIWyQ8eewttw3fOty48bDXs35tl2I80+unOvDy9y
         f/bDx0Up3KHMdB6FCU/GT6geFc+uwz/2jUDkpHQ+VUoPM/ASlnWvgoc81aSyfbLH2Q
         q6TPSwNpz7o07duG+bn4X1H6Umsn6RRwx6M90o/f1WCVFwVDj6ZrboMOZ0CM/hH/Rn
         UzaM/4CUkFLUA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Philip K. Gisslow" <ripxorip@gmail.com>,
        Zhaoyu Liu <zackary.liu.pro@gmail.com>,
        cristian.ciocaltea@collabora.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] scripts/tags.sh: Invoke 'realpath' via 'xargs'
Date:   Tue, 17 May 2022 02:46:46 +0300
Message-Id: <20220516234646.531208-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When COMPILED_SOURCE is set, running

  make ARCH=x86_64 COMPILED_SOURCE=1 cscope tags

could throw the following errors:

scripts/tags.sh: line 98: /usr/bin/realpath: Argument list too long
cscope: no source files found
scripts/tags.sh: line 98: /usr/bin/realpath: Argument list too long
ctags: No files specified. Try "ctags --help".

This is most likely to happen when the kernel is configured to build a
large number of modules, which has the consequence of passing too many
arguments when calling 'realpath' in 'all_compiled_sources()'.

Let's improve this by invoking 'realpath' through 'xargs', which takes
care of properly limiting the argument list.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 scripts/tags.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 16d475b3e203..01fab3d4f90b 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -95,10 +95,13 @@ all_sources()

 all_compiled_sources()
 {
-	realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) \
-		include/generated/autoconf.h $(find $ignore -name "*.cmd" -exec \
-		grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
-		awk '!a[$0]++') | sort -u
+	{
+		echo include/generated/autoconf.h
+		find $ignore -name "*.cmd" -exec \
+			grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
+		awk '!a[$0]++'
+	} | xargs realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
+	sort -u
 }

 all_target_sources()
--
2.36.1
