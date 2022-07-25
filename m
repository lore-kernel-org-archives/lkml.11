Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14870C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 02:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiGYCK5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jul 2022 22:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiGYCK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:10:56 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545982600
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:10:55 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 26P28hFx024554;
        Mon, 25 Jul 2022 11:08:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 26P28hFx024554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658714923;
        bh=c5ow9NHdLJRdkK1RaPBlCDWdT/S/S52BRXTnk2dzIcY=;
        h=From:To:Cc:Subject:Date:From;
        b=g0vIzBAfr+ZnbcT2dDdInFOT+uT/sFBai+1LEatmmQZX3G6DP0ueGTFBPWNr9CK3y
         ebdvqiIZ72Z+E9zkL9N87rk6PpnWeEnIAhz3NnoZ2HhC6arILAnGIZbxagzW6QWnOU
         kakaWsqZFMReIShVF6MrMeYrJT/tp0jM8VhaGuU/hLQfM4hpoK6PuY3VdCXv2ioHcz
         GEZD2eo2kB+hnVRI69nhBHJwD2t6bDHFcLtR7y+8hMtAzsp88hIZuatGHob04n+EV5
         vG1U1L9Z+4TXjERM74c7ju6JEQVJdHxEMkqO38o6opm14lrypK52/NqU5cuz1l70b7
         Rmzquv08DlzYg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/purgatory: hard-code obj-y in Makefile
Date:   Mon, 25 Jul 2022 11:08:11 +0900
Message-Id: <20220725020812.622255-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/Kbuild guards the entire purgatory/ directory, and
CONFIG_KEXEC_FILE is bool type.

$(CONFIG_KEXEC_FILE) is always 'y' when this directory is being built.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ae53d54d7959..248b009c4061 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -81,4 +81,4 @@ quiet_cmd_bin2c = BIN2C   $@
 $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
 
-obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
+obj-y += kexec-purgatory.o
-- 
2.34.1

