Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E19C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 23:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiCZXii (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 19:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiCZXig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 19:38:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6226C62BEF;
        Sat, 26 Mar 2022 16:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E216160E9E;
        Sat, 26 Mar 2022 23:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA66DC340E8;
        Sat, 26 Mar 2022 23:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648337817;
        bh=bYtxEVhBwsLpx4G9gMfhBrvUJ4SEy8p440r4DjnWoPc=;
        h=From:To:Cc:Subject:Date:From;
        b=DMJwuMiMwO+6+gn5k3eOlUkWG0/tO8+NQwPE4P7gvPXvVE7cJytO4K4Sfn7MpGRw4
         7lXsM5cI9FFKIehm8C/JdaLCwohATcQGs46iCWTPBQfvtUw/Ubyw2efSFEurnn2Fou
         y61xoRC01rYJuOPRUm3RXIA5K86P0ByYg/DtJDR8FotBUg8ZVfwEHbESSUxzziH/ib
         jRTCCjiNIMyr02FFYMtKKm3+MB/VJRUmFCzzpA1G4f/pr9UM/as7rX/yhVG6PVMIyu
         oxcADMy/iktMy8vNRvYRRN5uRd9qZw+svyhL6AtFN/nncjf/RVq/9ekr0+ztXAFQ5D
         w6e43lg15nUkw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 0/3] bootconfig: Support embedding a bootconfig in kernel for non initrd boot
Date:   Sun, 27 Mar 2022 08:36:53 +0900
Message-Id: <164833781316.2573528.8385063821185577976.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the 4th version of the patchset to enable kernel embedded bootconfig
for non-initrd kernel boot environment. I've fixed Makefile to determine
update by checking the contents of embedding bootconfig file. Thanks
Masahiro!

You can embed a bootconfig file into the kernel as a default bootconfig,
which will be used if there is no initrd or no bootconfig is attached to initrd. 

This needs 2 options: CONFIG_EMBED_BOOT_CONFIG=y and set the file
path to CONFIG_EMBED_BOOT_CONFIG_FILE. Even if you embed the bootconfig file
to the kernel, it will not be enabled unless you pass "bootconfig" kernel
command line option at boot. Moreover, since this is just a "default"
bootconfig, you can override it with a new bootconfig if you attach another
bootconfig to the initrd (if possible).
CONFIG_EMBED_BOOT_CONFIG_FILE can take both absolute and relative path, but
to simplify and make it independent from the build environment, I recommend
you to use an absolute path for that.

This is requested by Padmanabha at the below thread;

 https://lore.kernel.org/all/20220307184011.GA2570@pswork/T/#u

Thank you,

---

Masami Hiramatsu (3):
      bootconfig: Check the checksum before removing the bootconfig from initrd
      bootconfig: Support embedding a bootconfig file in kernel
      docs: bootconfig: Add how to embed the bootconfig into kernel


 Documentation/admin-guide/bootconfig.rst |   30 ++++++++++++++++++++++++++---
 include/linux/bootconfig.h               |   10 ++++++++++
 init/Kconfig                             |   21 ++++++++++++++++++++
 init/main.c                              |   31 +++++++++++++++---------------
 lib/.gitignore                           |    1 +
 lib/Makefile                             |   10 ++++++++++
 lib/bootconfig.c                         |   23 ++++++++++++++++++++++
 7 files changed, 108 insertions(+), 18 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
