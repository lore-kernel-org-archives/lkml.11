Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF75BC3527A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385249AbiDEMcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbiDEI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:58:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D624BCE;
        Tue,  5 Apr 2022 01:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A8BDB81B92;
        Tue,  5 Apr 2022 08:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA196C385A0;
        Tue,  5 Apr 2022 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148796;
        bh=JYxTO2rIP6G3utofM/I3wsvMma8X+tPaET/r2PEszRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwxoksrzXIQIEYKhL+d1UCMfPECzEeCp3tvwrP5lsHKLYpEZ0Hg6z6OgNhfO8yX5s
         gCbjbu8U80BKGNEAeYGvyWZBNkMP/RrXTdPc2ajabWD6RRY2gzABHG8QrPqHHsTMhw
         1lMRK47LlCbg+1tPcXlbm8UWj0cZizWUrzTBGYtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0485/1017] PCI: aardvark: Fix reading PCI_EXP_RTSTA_PME bit on emulated bridge
Date:   Tue,  5 Apr 2022 09:23:18 +0200
Message-Id: <20220405070408.695551923@linuxfoundation.org>
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

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 735f5ae49e1b44742cc63ca9b5c1ffde3e94ba91 ]

The emulated bridge returns incorrect value for PCI_EXP_RTSTA register
during readout in advk_pci_bridge_emul_pcie_conf_read() function: the
correct bit is BIT(16), but we are setting BIT(23), because the code
does
  *value = (isr0 & PCIE_MSG_PM_PME_MASK) << 16
where
  PCIE_MSG_PM_PME_MASK
is
  BIT(7).

The code should probably have been something like
  *value = (!!(isr0 & PCIE_MSG_PM_PME_MASK)) << 16,
but we are better of using an if() and using the proper macro for this
bit.

Link: https://lore.kernel.org/r/20220110015018.26359-15-kabel@kernel.org
Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 7aa6d6336223..a924564fdbbc 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -844,7 +844,9 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_EXP_RTSTA: {
 		u32 isr0 = advk_readl(pcie, PCIE_ISR0_REG);
 		u32 msglog = advk_readl(pcie, PCIE_MSG_LOG_REG);
-		*value = (isr0 & PCIE_MSG_PM_PME_MASK) << 16 | (msglog >> 16);
+		*value = msglog >> 16;
+		if (isr0 & PCIE_MSG_PM_PME_MASK)
+			*value |= PCI_EXP_RTSTA_PME;
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
 
-- 
2.34.1



