Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A4C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 May 2022 05:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445636AbiEGFbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 May 2022 01:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445577AbiEGFaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433BE6A066;
        Fri,  6 May 2022 22:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC90360A21;
        Sat,  7 May 2022 05:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D901C385A5;
        Sat,  7 May 2022 05:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651901176;
        bh=l6bGgj98vMo07Oh2nm6ap2x1Djx2VIyP1PyvH9kWWBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wnpj3pUYFpuIfBlSzUUzPA+ZsGo18qAeAGsWUcdaEqGUz2/7aXPXvW4xHeyWmJgCn
         zDC7ubBqVGBL/vk2cCtMtAVAxoXUXpftbY7qPnV8YUW9Tyd4IUc97IfpRdn48FU9d5
         fafBRmcERO/W7VSAdWq8pygaoustSHsN+qFisFnT84StQVnlj3/V1gVwYkmLsW+nTA
         0EzOjcvC5yvIAKnnIIhuxfHRpgW+NNiaYlQLI3Ue33d+lVu7OMbfqmfwjhyszNnQHK
         rkXAsvO2obbrXLDtViWeioeLPTkS1tVHXp+llD2oakXKqOIbP27CRdfmoAlFLqyr1C
         lxjxyLojjAwKA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>
Subject: [PATCH v6 06/23] rust: add `compiler_builtins` crate
Date:   Sat,  7 May 2022 07:24:04 +0200
Message-Id: <20220507052451.12890-7-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-1-ojeda@kernel.org>
References: <20220507052451.12890-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rust provides `compiler_builtins` as a port of LLVM's `compiler-rt`.
Since we do not need the vast majority of them, we avoid the
dependency by providing our own crate.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/compiler_builtins.rs | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 rust/compiler_builtins.rs

diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
new file mode 100644
index 000000000000..80ca4c0dcd24
--- /dev/null
+++ b/rust/compiler_builtins.rs
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Our own `compiler_builtins`.
+//!
+//! Rust provides [`compiler_builtins`] as a port of LLVM's [`compiler-rt`].
+//! Since we do not need the vast majority of them, we avoid the dependency
+//! by providing this file.
+//!
+//! At the moment, some builtins are required that should not be. For instance,
+//! [`core`] has 128-bit integers functionality which we should not be compiling
+//! in. We will work with upstream [`core`] to provide feature flags to disable
+//! the parts we do not need. For the moment, we define them to [`panic!`] at
+//! runtime for simplicity to catch mistakes, instead of performing surgery
+//! on `core.o`.
+//!
+//! In any case, all these symbols are weakened to ensure we do not override
+//! those that may be provided by the rest of the kernel.
+//!
+//! [`compiler_builtins`]: https://github.com/rust-lang/compiler-builtins
+//! [`compiler-rt`]: https://compiler-rt.llvm.org/
+
+#![feature(compiler_builtins)]
+#![compiler_builtins]
+#![no_builtins]
+#![no_std]
+
+macro_rules! define_panicking_intrinsics(
+    ($reason: tt, { $($ident: ident, )* }) => {
+        $(
+            #[doc(hidden)]
+            #[no_mangle]
+            pub extern "C" fn $ident() {
+                panic!($reason);
+            }
+        )*
+    }
+);
+
+define_panicking_intrinsics!("`i128` should not be used", {
+    __ashrti3,
+    __muloti4,
+    __multi3,
+});
+
+define_panicking_intrinsics!("`u128` should not be used", {
+    __ashlti3,
+    __lshrti3,
+    __udivmodti4,
+    __udivti3,
+    __umodti3,
+});
+
+#[cfg(target_arch = "arm")]
+define_panicking_intrinsics!("`u64` division/modulo should not be used", {
+    __aeabi_uldivmod,
+    __mulodi4,
+});
-- 
2.35.3

