Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C77C47089
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 10:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354043AbiDEKLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbiDEIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B915FED;
        Tue,  5 Apr 2022 01:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA58C60AFB;
        Tue,  5 Apr 2022 08:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C217EC385A1;
        Tue,  5 Apr 2022 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147291;
        bh=+meF9PkKtpTanUbYRtKk8E3df2KpV2NIkMy3Tats4EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8RIlkMyiO469LebPtnXtGKiIcPFrXNrRl+qe2vkZuxIWu9Vjhm+upkk2jiL9+QNg
         NDCZ0eCa1vHMLTKqi0J4i/mMO5CsfvefEBzsbBPIhKb2FyJQkyZDX+RW+hKHoT1y2T
         hOnrZ/tSgUmwQh6G+SjeWfEUlLVnyn5ytSyWeM74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: [PATCH 5.17 1071/1126] arm64: mm: Drop const from conditional arm64_dma_phys_limit definition
Date:   Tue,  5 Apr 2022 09:30:18 +0200
Message-Id: <20220405070438.891963315@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 770093459b9b333380aa71f2c31c60b14895c1df upstream.

Commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
platforms with no DMA memory zones") introduced different definitions
for 'arm64_dma_phys_limit' depending on CONFIG_ZONE_DMA{,32} based on
a late suggestion from Pasha. Sadly, this results in a build error when
passing W=1:

  | arch/arm64/mm/init.c:90:19: error: conflicting type qualifiers for 'arm64_dma_phys_limit'

Drop the 'const' for now and use '__ro_after_init' consistently.

Link: https://lore.kernel.org/r/202203090241.aj7paWeX-lkp@intel.com
Link: https://lore.kernel.org/r/CA+CK2bDbbx=8R=UthkMesWOST8eJMtOGJdfMRTFSwVmo0Vn0EA@mail.gmail.com
Fixes: 031495635b46 ("arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones")
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -87,7 +87,7 @@ EXPORT_SYMBOL(memstart_addr);
 #if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
 phys_addr_t __ro_after_init arm64_dma_phys_limit;
 #else
-const phys_addr_t arm64_dma_phys_limit = PHYS_MASK + 1;
+phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
 #ifdef CONFIG_KEXEC_CORE


