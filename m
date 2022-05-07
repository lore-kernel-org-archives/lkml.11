Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB0C433FE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 May 2022 05:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445563AbiEGFbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 May 2022 01:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445674AbiEGFay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FDF69CE3;
        Fri,  6 May 2022 22:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E36B60018;
        Sat,  7 May 2022 05:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7B6C385A9;
        Sat,  7 May 2022 05:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651901216;
        bh=ZjbsEZQJBzG3/a4R3vRaYmBIoAGsBlFrywvQgv/c/us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHNzQ569t7yK14qvXJtnYrYC66J/bi8/raTsfdLTF7SzBRPCNoknSVuKoRP7dS90P
         l+/C76jHPBOST2k00zSZWirCewfB9zH4/f3cskvCBmZhQtwm+k5bVB97jn07geZOD5
         kZ7XivLXPGnjwq+/jpYdwyjLuU88/FVFcbVF/LXnp1ep5BTYYowkmiOJsd4wm6BPUR
         uIVZ9XCcduJ/2RCW2U7ATAXjAWGEGf8gxWjyEemcwQNckzvj170cxU+dV203kHYBI4
         RUuNUsj/3vYd1fPu6Gz6lo/jDRynxVfr8iGsu0aSrTsPEmVH4r5GTM9DwZGr45NKj6
         AQ4qqmHvwlyxg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v6 13/23] rust: export generated symbols
Date:   Sat,  7 May 2022 07:24:11 +0200
Message-Id: <20220507052451.12890-14-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-1-ojeda@kernel.org>
References: <20220507052451.12890-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All symbols are reexported reusing the `EXPORT_SYMBOL_GPL` macro
from C. The lists of symbols are generated on the fly.

There are three main sets of symbols to distinguish:

  - The ones from the `core` and `alloc` crates (from the Rust
    standard library). The code is licensed as Apache/MIT.

  - The ones from our abstractions in the `kernel` crate.

  - The helpers (already exported since they are not generated).

We export everything as GPL. This ensures we do not mistakenly
expose GPL kernel symbols/features as non-GPL, even indirectly.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/exports.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 rust/exports.c

diff --git a/rust/exports.c b/rust/exports.c
new file mode 100644
index 000000000000..fe3dcfdd6fbf
--- /dev/null
+++ b/rust/exports.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A hack to export Rust symbols for loadable modules without having to redo
+ * the entire `include/linux/export.h` logic in Rust.
+ *
+ * This requires the Rust's new/future `v0` mangling scheme because the default
+ * one ("legacy") uses invalid characters for C identifiers (thus we cannot use
+ * the `EXPORT_SYMBOL_*` macros).
+ *
+ * All symbols are exported as GPL-only to guarantee no GPL-only feature is
+ * accidentally exposed.
+ */
+
+#include <linux/module.h>
+
+#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym);
+
+#include "exports_core_generated.h"
+#include "exports_alloc_generated.h"
+#include "exports_kernel_generated.h"
-- 
2.35.3

