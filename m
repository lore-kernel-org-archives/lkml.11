Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61721C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347624AbiBUJHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347559AbiBUJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:01:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B547C63E0;
        Mon, 21 Feb 2022 00:56:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 809ABB80EB6;
        Mon, 21 Feb 2022 08:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF60FC340E9;
        Mon, 21 Feb 2022 08:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645433800;
        bh=HG70MbETkzCGTixItJT/j1w2G8thigoGjoY2WCV0+4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqzYOdIuxdIyJbgznT7ml3gOKtOnvvNno69yOJsfOk63XjcY/P6dBQl4aDMt93+88
         2XrRuAhVMqsCLJh4BFfUhKYw3ocqNCQUrMELiaco5RoYwa+TV2rtg1E+rWzfkjQAMi
         JKX52sfDxfIZIx8upkXg/+X3k90LF5asMMAviDtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, david regan <dregan@mail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 46/58] mtd: rawnand: brcmnand: Fixed incorrect sub-page ECC status
Date:   Mon, 21 Feb 2022 09:49:39 +0100
Message-Id: <20220221084913.363565190@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084911.895146879@linuxfoundation.org>
References: <20220221084911.895146879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: david regan <dregan@mail.com>

[ Upstream commit 36415a7964711822e63695ea67fede63979054d9 ]

The brcmnand driver contains a bug in which if a page (example 2k byte)
is read from the parallel/ONFI NAND and within that page a subpage (512
byte) has correctable errors which is followed by a subpage with
uncorrectable errors, the page read will return the wrong status of
correctable (as opposed to the actual status of uncorrectable.)

The bug is in function brcmnand_read_by_pio where there is a check for
uncorrectable bits which will be preempted if a previous status for
correctable bits is detected.

The fix is to stop checking for bad bits only if we already have a bad
bits status.

Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
Signed-off-by: david regan <dregan@mail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/trinity-478e0c09-9134-40e8-8f8c-31c371225eda-1643237024774@3c-app-mailcom-lxa02
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index db18198f2834f..27bafb8fc35af 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1673,7 +1673,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 					mtd->oobsize / trans,
 					host->hwcfg.sector_size_1k);
 
-		if (!ret) {
+		if (ret != -EBADMSG) {
 			*err_addr = brcmnand_get_uncorrecc_addr(ctrl);
 
 			if (*err_addr)
-- 
2.34.1



