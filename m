Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C91C28B2B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 16:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351174AbiHSQFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351459AbiHSQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7874B8D;
        Fri, 19 Aug 2022 08:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D7B861745;
        Fri, 19 Aug 2022 15:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B01C433D6;
        Fri, 19 Aug 2022 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660924371;
        bh=r8VC5k8yCnxrmhJJjc40MMt9lv8g2qFUnZotxUDIYhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJKfwvv9MSikoSkyBoqkl0kOkEiKyGxxI5OuuIsS23tFdvNUvPO4rhdns0nsSLxCI
         +qRmqMbPQxXHn4d711u1VQyRmWi/PHJViPItYLQZHGdsvpY9XrhoOoFuBKeKpF/Wri
         cljybbFUFuVv2zIJitU/rs4RlVSrutECJEPZ7BXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 118/545] x86/pmem: Fix platform-device leak in error path
Date:   Fri, 19 Aug 2022 17:38:08 +0200
Message-Id: <20220819153834.571737327@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819153829.135562864@linuxfoundation.org>
References: <20220819153829.135562864@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 229e73d46994f15314f58b2d39bf952111d89193 ]

Make sure to free the platform device in the unlikely event that
registration fails.

Fixes: 7a67832c7e44 ("libnvdimm, e820: make CONFIG_X86_PMEM_LEGACY a tristate option")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220620140723.9810-1-johan@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/pmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pmem.c b/arch/x86/kernel/pmem.c
index 6b07faaa1579..23154d24b117 100644
--- a/arch/x86/kernel/pmem.c
+++ b/arch/x86/kernel/pmem.c
@@ -27,6 +27,11 @@ static __init int register_e820_pmem(void)
 	 * simply here to trigger the module to load on demand.
 	 */
 	pdev = platform_device_alloc("e820_pmem", -1);
-	return platform_device_add(pdev);
+
+	rc = platform_device_add(pdev);
+	if (rc)
+		platform_device_put(pdev);
+
+	return rc;
 }
 device_initcall(register_e820_pmem);
-- 
2.35.1



