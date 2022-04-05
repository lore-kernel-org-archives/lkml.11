Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCF7C47087
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 14:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359760AbiDEOET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 10:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbiDEJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C264D9;
        Tue,  5 Apr 2022 02:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05768B81B7F;
        Tue,  5 Apr 2022 09:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70534C385A2;
        Tue,  5 Apr 2022 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649150306;
        bh=8/YNMu7+LX6RHTLGnnonVq5mzG5eSceZVaeyn/2kX5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uv2QnbToB4vwyiHNhGxwJQMh8caAkaDgOt235k09txgHxz+VjMl/UcQn77aCnP9oe
         ApGpA73xgH4FdzJRlEy4nyoTzt+gLUo0pCy5y5NtQHgbcmLtG9bxnbLTGcdygxHH8k
         tKr9ILa2pSVz8mBqlrab8Bqk1syucZcxBPw8e0fI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 011/913] ARM: mstar: Select HAVE_ARM_ARCH_TIMER
Date:   Tue,  5 Apr 2022 09:17:53 +0200
Message-Id: <20220405070340.152583446@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

[ Upstream commit ea49432d184a6a09f84461604b7711a4e9f5ec9c ]

The mstar SoCs have an arch timer but HAVE_ARM_ARCH_TIMER wasn't
selected. If MSC313E_TIMER isn't selected then the kernel gets
stuck at boot because there are no timers available.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Link: https://lore.kernel.org/r/20220301104349.3040422-1-daniel@0x0f.com'
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-mstar/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
index cd300eeedc20..0bf4d312bcfd 100644
--- a/arch/arm/mach-mstar/Kconfig
+++ b/arch/arm/mach-mstar/Kconfig
@@ -3,6 +3,7 @@ menuconfig ARCH_MSTARV7
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select ARM_HEAVY_MB
+	select HAVE_ARM_ARCH_TIMER
 	select MST_IRQ
 	select MSTAR_MSC313_MPLL
 	help
-- 
2.34.1



