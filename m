Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E3CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 08:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiFHI42 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 04:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiFHIzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:55:51 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31D703CA2DA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:16:32 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id A687C1E80D76;
        Wed,  8 Jun 2022 16:16:04 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b--a_qBEjzwe; Wed,  8 Jun 2022 16:16:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id DE6C51E80CB8;
        Wed,  8 Jun 2022 16:16:01 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH] x86: replace_intsrc_all function removes unused return values
Date:   Wed,  8 Jun 2022 16:16:25 +0800
Message-Id: <20220608081625.82731-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the return value of the replace_intsrc_all function to
void to reduce eAX register calls . 

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 arch/x86/kernel/mpparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fed721f90116..bb2ae610163f 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -723,7 +723,7 @@ static
 inline void __init check_irq_src(struct mpc_intsrc *m, int *nr_m_spare) {}
 #endif /* CONFIG_X86_IO_APIC */
 
-static int  __init replace_intsrc_all(struct mpc_table *mpc,
+static void  __init replace_intsrc_all(struct mpc_table *mpc,
 					unsigned long mpc_new_phys,
 					unsigned long mpc_new_length)
 {
-- 
2.18.2

