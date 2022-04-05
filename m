Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5C9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 13:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbiDENF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242459AbiDEJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:08:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BBF6C95C;
        Tue,  5 Apr 2022 01:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F9EEB81C19;
        Tue,  5 Apr 2022 08:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A41C385A1;
        Tue,  5 Apr 2022 08:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649149010;
        bh=Fuaowa36LZmZrZwM9VAhTPo1a9kG2y7HWx+kfZ1HWT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffeACz8ziiDBheGrw1WTvTP8rTCFNmlnMSuUet4m9JhuxzMlevEFXo5QyBtBrRcFe
         9idsxDTdmOIAP0ukA8Crpui/yub9Mvt6Z21Wsm5VR3YcTKPchOOz4D3YyiBaYPrs0R
         Xdq0+FZhS9Lw9N7xdIKeU0jmSEIR2Zd3w7g2puho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0562/1017] powerpc/Makefile: Dont pass -mcpu=powerpc64 when building 32-bit
Date:   Tue,  5 Apr 2022 09:24:35 +0200
Message-Id: <20220405070410.962528069@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 2863dd2db23e0407f6c50b8ba5c0e55abef894f1 ]

When CONFIG_GENERIC_CPU=y (true for all our defconfigs) we pass
-mcpu=powerpc64 to the compiler, even when we're building a 32-bit
kernel.

This happens because we have an ifdef CONFIG_PPC_BOOK3S_64/else block in
the Makefile that was written before 32-bit supported GENERIC_CPU. Prior
to that the else block only applied to 64-bit Book3E.

The GCC man page says -mcpu=powerpc64 "[specifies] a pure ... 64-bit big
endian PowerPC ... architecture machine [type], with an appropriate,
generic processor model assumed for scheduling purposes."

It's unclear how that interacts with -m32, which we are also passing,
although obviously -m32 is taking precedence in some sense, as the
32-bit kernel only contains 32-bit instructions.

This was noticed by inspection, not via any bug reports, but it does
affect code generation. Comparing before/after code generation, there
are some changes to instruction scheduling, and the after case (with
-mcpu=powerpc64 removed) the compiler seems more keen to use r8.

Fix it by making the else case only apply to Book3E 64, which excludes
32-bit.

Fixes: 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20220215112858.304779-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index e02568f17334..3d2e74ebc014 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -171,7 +171,7 @@ else
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,$(call cc-option,-mtune=power5))
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mcpu=power5,-mcpu=power4)
 endif
-else
+else ifdef CONFIG_PPC_BOOK3E_64
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
 
-- 
2.34.1



