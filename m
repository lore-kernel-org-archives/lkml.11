Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9399C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 14:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356397AbiCPOPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356347AbiCPOPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD9F1EEE5;
        Wed, 16 Mar 2022 07:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D57961240;
        Wed, 16 Mar 2022 14:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12651C36AF9;
        Wed, 16 Mar 2022 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647440066;
        bh=8/YNMu7+LX6RHTLGnnonVq5mzG5eSceZVaeyn/2kX5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYMZTaycAF1B1e8fkOA6TVfZEKfwlpsMa9fDx5kgPr83R/t4ibNFsnVrsKIlexqBZ
         svvRDWVVHP/lYq5Ly4kB5O89giMybbjdEjIZNIiVTyRPapOZSgu9aBHgNmcS2+NtIQ
         DFa5Ho9KlD0QJqS5deZpGQ0uOFbISXfCxvkgwk/VQHYtwMGY0jBA+7HULXRI3GgNZ8
         D7xjECesfQ4O1r+iFc8NoUgxPxJXhRgOHsnt5rMdwKCtjR8/hvH73n2d65Bx4C+n9w
         gfQsBpTfpkJ+1ow4G3+1OnRdYhnk+MRq3MwiPti11jEbFffxKwG4LjEWyYu8/dhEik
         JgiNZ9pa0fQjg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Palmer <daniel@0x0f.com>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>, daniel@thingy.jp,
        romain.perier@gmail.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.16 05/13] ARM: mstar: Select HAVE_ARM_ARCH_TIMER
Date:   Wed, 16 Mar 2022 10:13:46 -0400
Message-Id: <20220316141354.247750-5-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220316141354.247750-1-sashal@kernel.org>
References: <20220316141354.247750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

