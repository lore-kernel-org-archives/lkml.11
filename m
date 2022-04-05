Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2F7C4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 20:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383568AbiDEUzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 16:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354645AbiDEKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF16C1D5;
        Tue,  5 Apr 2022 03:02:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C00856172B;
        Tue,  5 Apr 2022 10:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81E7C385A2;
        Tue,  5 Apr 2022 10:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152927;
        bh=WShbQXSabFJ84DUQ7BZubSHOJSxU09EfsVqM5MsbdRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZQ+XQCemkKza0SQY7bZmfbeOpCdsgMW3TTzPRqeMjdvz7wveWD/PnLIumE+Nx39Z
         ZpQ5SPZ5tTyWN1eUo/sNGEdy8FkR7IpV8GD8xZ9bTmwtnObzXWU5T06dYHwrdR5DPH
         hzjXV5H7s9MkO8d1/C6Hq+7PTrEdttOMC+A/4uUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 008/599] ARM: mstar: Select HAVE_ARM_ARCH_TIMER
Date:   Tue,  5 Apr 2022 09:25:02 +0200
Message-Id: <20220405070259.061969249@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
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
index 576d1ab293c8..30560fdf87ed 100644
--- a/arch/arm/mach-mstar/Kconfig
+++ b/arch/arm/mach-mstar/Kconfig
@@ -3,6 +3,7 @@ menuconfig ARCH_MSTARV7
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select ARM_HEAVY_MB
+	select HAVE_ARM_ARCH_TIMER
 	select MST_IRQ
 	help
 	  Support for newer MStar/Sigmastar SoC families that are
-- 
2.34.1



