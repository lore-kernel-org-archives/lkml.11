Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8AAC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 12:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbiGSMGS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiGSMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:04:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBAA4D169;
        Tue, 19 Jul 2022 05:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B53D1B81A8F;
        Tue, 19 Jul 2022 12:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F92CC341C6;
        Tue, 19 Jul 2022 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658232032;
        bh=hkNBwUYHFKGSvzmtLsoGiokgbvyoXmsQTklyeIXqUZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Izjb21XW8oLdKkvpmqVyCKcifea6hx6//vCNf7+GPUxx6gvJKCAuIDeQ4BOwak09
         thcTakhdJ+FdVEVhdwYKLa/DBTbqUbmpBHnO6xWm1YqW+mZajsZd5vd1oJSrTDujP/
         Hq25bVvyjHQji7IxeRkLQqNsQjXab1pu9GG3LYpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 38/48] x86: Clear .brk area at early boot
Date:   Tue, 19 Jul 2022 13:54:15 +0200
Message-Id: <20220719114523.233359797@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719114518.915546280@linuxfoundation.org>
References: <20220719114518.915546280@linuxfoundation.org>
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
index 88dc38b4a147..90c2613af36b 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -383,6 +383,8 @@ static void __init clear_bss(void)
 {
 	memset(__bss_start, 0,
 	       (unsigned long) __bss_stop - (unsigned long) __bss_start);
+	memset(__brk_base, 0,
+	       (unsigned long) __brk_limit - (unsigned long) __brk_base);
 }
 
 static unsigned long get_cmd_line_ptr(void)
-- 
2.35.1



