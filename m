Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D9BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 06:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbiBNG4I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 01:56:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiBNG4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:56:07 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D55575C5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:55:59 -0800 (PST)
Received: from localhost.localdomain (ip5f5aebfe.dynamic.kabel-deutschland.de [95.90.235.254])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 95F0661EA1924;
        Mon, 14 Feb 2022 07:55:57 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Geoff Levand <geoff@infradead.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: Add `otheros-too-big.bld` to .gitignore
Date:   Mon, 14 Feb 2022 07:55:43 +0100
Message-Id: <20220214065543.198992-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, `git status` lists the file as untracked by git, so tell git
to ignore it.

Fixes: aa3bc365ee73 ("powerpc/ps3: Add check for otheros image size")
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 arch/powerpc/boot/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 1eee61b82341..a4716d138cfc 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -16,6 +16,7 @@ kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
 mktree
 otheros.bld
+otheros-too-big.bld
 uImage
 cuImage.*
 dtbImage.*
-- 
2.34.1

