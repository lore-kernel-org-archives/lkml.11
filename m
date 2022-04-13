Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B88C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 13:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiDMNxN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 09:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiDMNw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:52:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A14D2655A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02A26B824E7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBB5C385AF;
        Wed, 13 Apr 2022 13:49:58 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc:     Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net
Subject: [PATCH RFC 3/4] fs/binfmt_elf: Tell user-space about the DENY_WRITE_EXEC personality flag
Date:   Wed, 13 Apr 2022 14:49:45 +0100
Message-Id: <20220413134946.2732468-4-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413134946.2732468-1-catalin.marinas@arm.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since personality() accepts any flags and does not mask out any unknown
bits, inform user space that such personality flag is supported via an
AT_FLAGS_DENY_WRITE_EXEC flag.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>
---
 fs/binfmt_elf.c              | 2 ++
 include/uapi/linux/binfmts.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6556e13ed95f..4e6cba1f67ee 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -265,6 +265,8 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
 	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
 		flags |= AT_FLAGS_PRESERVE_ARGV0;
+	if (IS_ENABLED(CONFIG_ARCH_ENABLE_DENY_WRITE_EXEC))
+		flags |= AT_FLAGS_DENY_WRITE_EXEC;
 	NEW_AUX_ENT(AT_FLAGS, flags);
 	NEW_AUX_ENT(AT_ENTRY, e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
index c6f9450efc12..304bbb30264c 100644
--- a/include/uapi/linux/binfmts.h
+++ b/include/uapi/linux/binfmts.h
@@ -22,4 +22,8 @@ struct pt_regs;
 #define AT_FLAGS_PRESERVE_ARGV0_BIT 0
 #define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
 
+/* support for DENY_WRITE_EXEC personality flag */
+#define AT_FLAGS_DENY_WRITE_EXEC_BIT 1
+#define AT_FLAGS_DENY_WRITE_EXEC (1 << AT_FLAGS_DENY_WRITE_EXEC_BIT)
+
 #endif /* _UAPI_LINUX_BINFMTS_H */
