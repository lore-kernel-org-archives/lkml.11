Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38999C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiDNOFy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344017AbiDNNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:30:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957592D02;
        Thu, 14 Apr 2022 06:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C69D5B82984;
        Thu, 14 Apr 2022 13:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227CDC385A9;
        Thu, 14 Apr 2022 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942779;
        bh=iQRV5ateyNk7x82zVTTRxMV9NpHDhO7Yy587hC+Z5TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xD1Yn8bZVSMAAPaPKjIL5PIwj9taXe1KQnlovcs98vLR6sUOtm5E+b80IoqrJi5U4
         nyXVoI+O8mxhDHI5B/xqVxD1Yk+0MXcF4WXkKlEBwHpHSJgwURaasc96Pruc1GlVzX
         Qq9fawfA7pwK8spqinDme40j9TZj+ufaRqY46BgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 258/338] riscv module: remove (NOLOAD)
Date:   Thu, 14 Apr 2022 15:12:41 +0200
Message-Id: <20220414110846.233086921@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110838.883074566@linuxfoundation.org>
References: <20220414110838.883074566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fangrui Song <maskray@google.com>

[ Upstream commit 60210a3d86dc57ce4a76a366e7841dda746a33f7 ]

On ELF, (NOLOAD) sets the section type to SHT_NOBITS[1]. It is conceptually
inappropriate for .plt, .got, and .got.plt sections which are always
SHT_PROGBITS.

In GNU ld, if PLT entries are needed, .plt will be SHT_PROGBITS anyway
and (NOLOAD) will be essentially ignored. In ld.lld, since
https://reviews.llvm.org/D118840 ("[ELF] Support (TYPE=<value>) to
customize the output section type"), ld.lld will report a `section type
mismatch` error (later changed to a warning). Just remove (NOLOAD) to
fix the warning.

[1] https://lld.llvm.org/ELF/linker_script.html As of today, "The
section should be marked as not loadable" on
https://sourceware.org/binutils/docs/ld/Output-Section-Type.html is
outdated for ELF.

Link: https://github.com/ClangBuiltLinux/linux/issues/1597
Fixes: ab1ef68e5401 ("RISC-V: Add sections of PLT and GOT for kernel module")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Fangrui Song <maskray@google.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/module.lds | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/module.lds b/arch/riscv/kernel/module.lds
index 295ecfb341a2..18ec719899e2 100644
--- a/arch/riscv/kernel/module.lds
+++ b/arch/riscv/kernel/module.lds
@@ -2,7 +2,7 @@
 /* Copyright (C) 2017 Andes Technology Corporation */
 
 SECTIONS {
-	.plt (NOLOAD) : { BYTE(0) }
-	.got (NOLOAD) : { BYTE(0) }
-	.got.plt (NOLOAD) : { BYTE(0) }
+	.plt : { BYTE(0) }
+	.got : { BYTE(0) }
+	.got.plt : { BYTE(0) }
 }
-- 
2.35.1



