Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66EBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 20:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiGYUWh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGYUWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:22:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48721830
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vgFump+2dPkbIVpP+fI0kGQRSeixHS0B4cJwInaPF04=; b=c4wSCEy0R8W2Vx//0HHTJDreGn
        v8C9vDissYtPVTnRhHVSfUcageaBkBYQwvG9Di64Vn/ehN/+6JfC6qRVufMl0nSBpeKNCGwrjGI05
        ju+3qZaZdF6Ma6MKuee4wh+ldOVSLwJ+hLuuYOxAOkoi5bGRIr6bMzpnbetBB9ZedeChhFYwVPamH
        wO4MJKvL1L85ou+xOH40vzPKfkb9S3qgEPoN7VXh4ribslLR7DPXpw6MFllKMq1FjPId7qymN3qGh
        lG4s1oil4NSAZHWYK/rdXdeMcvZPOYLx3x85dIYBHecTIo1w2xxcUSSteI4LsaQSWeGMbmG0x7+xe
        YNsfSTHA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oG4b0-001Pcl-U5; Mon, 25 Jul 2022 20:22:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stafford Horne <shorne@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: [PATCH -next] x86/cyrix: include header linux/isa-dma.h
Date:   Mon, 25 Jul 2022 13:22:24 -0700
Message-Id: <20220725202224.29269-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86/kernel/cpu/cyrix.c now needs to include <linux/isa-dma.h>
since the 'isa_dma_bridge_buggy' variable was moved to it.

Fixes this build error:

../arch/x86/kernel/cpu/cyrix.c: In function ‘init_cyrix’:
../arch/x86/kernel/cpu/cyrix.c:277:17: error: ‘isa_dma_bridge_buggy’ undeclared (first use in this function)
  277 |                 isa_dma_bridge_buggy = 2;

Fixes: abb4970ac335 ("PCI: Move isa_dma_bridge_buggy out of asm/dma.h")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/cyrix.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/isa-dma.h>
 #include <linux/pci.h>
 #include <asm/dma.h>
 #include <linux/io.h>
