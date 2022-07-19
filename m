Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B869C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 11:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbiGSL4s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiGSL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:56:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176542AD1;
        Tue, 19 Jul 2022 04:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E413BB81B29;
        Tue, 19 Jul 2022 11:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C16C341CA;
        Tue, 19 Jul 2022 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658231771;
        bh=JvbAeAtnbcUPKYYQMBpl0nkK9xZaQTNviOPQ5mXGdFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8BV0ACRfsMvW/8RP8q9ofFGJrwm7WwyvEWBBAeTzI5WzG2bOv1xsopPpeOfLkUxl
         Gej5bjfGa4AX0t+5fIQqDYsLuEMQ/vB7DnNjGz0VQbS4/nME6phTFjO2sikPywRNTz
         ogGHbDCDbOgnoDhlRkDyjUSxB9/smeEBDvQqXrso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 21/28] x86: Clear .brk area at early boot
Date:   Tue, 19 Jul 2022 13:53:59 +0200
Message-Id: <20220719114458.138605172@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719114455.701304968@linuxfoundation.org>
References: <20220719114455.701304968@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

[ Upstream commit 38fa5479b41376dc9d7f57e71c83514285a25ca0 ]

The .brk section has the same properties as .bss: it is an alloc-only
section and should be cleared before being used.

Not doing so is especially a problem for Xen PV guests, as the
hypervisor will validate page tables (check for writable page tables
and hypervisor private bits) before accepting them to be used.

Make sure .brk is initially zero by letting clear_bss() clear the brk
area, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220630071441.28576-3-jgross@suse.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/head64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index b5785c197e53..2b2060d842d1 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -106,6 +106,8 @@ static void __init clear_bss(void)
 {
 	memset(__bss_start, 0,
 	       (unsigned long) __bss_stop - (unsigned long) __bss_start);
+	memset(__brk_base, 0,
+	       (unsigned long) __brk_limit - (unsigned long) __brk_base);
 }
 
 static unsigned long get_cmd_line_ptr(void)
-- 
2.35.1



