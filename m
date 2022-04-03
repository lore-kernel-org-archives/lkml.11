Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595ECC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 22:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376560AbiDCW1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 18:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbiDCW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 18:27:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752D3982F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1kpWpbZUvs0YrVwXScvvOONeu400CkOl0OCFSWhU8FM=; b=QDdBceEbGix+UwIyXxI1rVaKmh
        LeQsJr6mpNoJZYJoHXDa+EKudQtUIOG+umhJxScO23sPvHWsNalqEq+urwDhHCkStPIy0gF/NjGIU
        Ru9+rwLAsZOmvz8v+EwHuGrprXtZDhVtPv+CXvIYaaobTrMnhNjUx5RCyiBoXYe8W8SzGJ8uxuAmT
        ilXsWQtl3bvX4Uk9J6TzyDrinzUje1lE8t4G697WMu88lroKiy/RL0TyN/gUn5plsgxPadO668gdF
        4EFOWSL3jRjxnVHoUVUHAO9B79zHXL4oDnRy3mnEHQL8kAt8dVa1jx00iPjRm1wFtao/bMnqqNOmV
        1W7atIIw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nb8em-00CTzH-MA; Sun, 03 Apr 2022 22:25:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v2] sound/oss/dmasound: fix build when drivers are mixed =y/=m
Date:   Sun,  3 Apr 2022 15:25:10 -0700
Message-Id: <20220403222510.12670-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DMASOUND_ATARI=m and CONFIG_DMASOUND_Q40=y (or vice versa),
dmasound_core.o can be built without dmasound_deinit() being defined,
causing a build error:

ERROR: modpost: "dmasound_deinit" [sound/oss/dmasound/dmasound_atari.ko] undefined!

Modify dmasound_core.c so that dmasound_deinit() is always available.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202204032138.EFT9qGEd-lkp@intel.com
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
#Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") # "forever, but backport not important"

 sound/oss/dmasound/dmasound.h      |    4 ----
 sound/oss/dmasound/dmasound_core.c |   10 +++++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

--- linux-next-20220401.orig/sound/oss/dmasound/dmasound_core.c
+++ linux-next-20220401/sound/oss/dmasound/dmasound_core.c
@@ -1424,27 +1424,29 @@ int dmasound_init(void)
 	return 0;
 }
 
-#ifdef MODULE
-
 void dmasound_deinit(void)
 {
+#ifdef MODULE
 	if (irq_installed) {
 		sound_silence();
 		dmasound.mach.irqcleanup();
 		irq_installed = 0;
 	}
+#endif
 
 	write_sq_release_buffers();
 
+#ifdef MODULE
 	if (mixer_unit >= 0)
 		unregister_sound_mixer(mixer_unit);
 	if (state_unit >= 0)
 		unregister_sound_special(state_unit);
 	if (sq_unit >= 0)
 		unregister_sound_dsp(sq_unit);
+#endif
 }
 
-#else /* !MODULE */
+#ifndef MODULE
 
 static int dmasound_setup(char *str)
 {
@@ -1577,9 +1579,7 @@ char dmasound_alaw2dma8[] = {
 
 EXPORT_SYMBOL(dmasound);
 EXPORT_SYMBOL(dmasound_init);
-#ifdef MODULE
 EXPORT_SYMBOL(dmasound_deinit);
-#endif
 EXPORT_SYMBOL(dmasound_write_sq);
 EXPORT_SYMBOL(dmasound_catchRadius);
 #ifdef HAS_8BIT_TABLES
--- linux-next-20220401.orig/sound/oss/dmasound/dmasound.h
+++ linux-next-20220401/sound/oss/dmasound/dmasound.h
@@ -88,11 +88,7 @@ static inline int ioctl_return(int __use
      */
 
 extern int dmasound_init(void);
-#ifdef MODULE
 extern void dmasound_deinit(void);
-#else
-#define dmasound_deinit()	do { } while (0)
-#endif
 
 /* description of the set-up applies to either hard or soft settings */
 
