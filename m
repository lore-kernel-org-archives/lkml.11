Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E59C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiDELJm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbiDEIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:30:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832813298E;
        Tue,  5 Apr 2022 01:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32B4BB81B92;
        Tue,  5 Apr 2022 08:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAD8C385A0;
        Tue,  5 Apr 2022 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146954;
        bh=BS9+xBaILP2NTve/YGTy5aoxWamiPKm3xneZ2z7LGuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iqr6Wy0xeQpbO836nrDAtRh7Poh0PoIgD2Aed1UBtAGui+6cpcxieD5k232JqacGJ
         wnYHjPq2IMnlWIzHvX66NcgIvwGM1NR8LJVnlsbYYd5mxxSaxW3/b+cloelmODUeAb
         9evwFFS7BmTiYb04rSCAUr43xJS3dKUM5IW3n+2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Daniel=20Gonz=C3=A1lez=20Cabanelas?= <dgcbueu@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0922/1126] media: cx88-mpeg: clear interrupt status register before streaming video
Date:   Tue,  5 Apr 2022 09:27:49 +0200
Message-Id: <20220405070434.582365145@linuxfoundation.org>
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

From: Daniel González Cabanelas <dgcbueu@gmail.com>

[ Upstream commit 56cb61f70e547e1b0cdfe6ff5a1f1ce6242e6d96 ]

Some cx88 video cards may have transport stream status interrupts set
to 1 from cold start, causing errors like this:

  cx88xx: cx88_print_irqbits: core:irq mpeg  [0x100000] ts_err?*
  cx8802: cx8802_mpeg_irq: mpeg:general errors: 0x00100000

According to CX2388x datasheet, the interrupt status register should be
cleared before enabling IRQs to stream video.

Fix it by clearing the Transport Stream Interrupt Status register.

Signed-off-by: Daniel González Cabanelas <dgcbueu@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx88/cx88-mpeg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/pci/cx88/cx88-mpeg.c b/drivers/media/pci/cx88/cx88-mpeg.c
index 680e1e3fe89b..2c1d5137ac47 100644
--- a/drivers/media/pci/cx88/cx88-mpeg.c
+++ b/drivers/media/pci/cx88/cx88-mpeg.c
@@ -162,6 +162,9 @@ int cx8802_start_dma(struct cx8802_dev    *dev,
 	cx_write(MO_TS_GPCNTRL, GP_COUNT_CONTROL_RESET);
 	q->count = 0;
 
+	/* clear interrupt status register */
+	cx_write(MO_TS_INTSTAT,  0x1f1111);
+
 	/* enable irqs */
 	dprintk(1, "setting the interrupt mask\n");
 	cx_set(MO_PCI_INTMSK, core->pci_irqmask | PCI_INT_TSINT);
-- 
2.34.1



