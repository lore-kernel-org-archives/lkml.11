Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E7FC4707E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 17:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiEWRrs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 13:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243043AbiEWR2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D38E1B1;
        Mon, 23 May 2022 10:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E93EC60BD3;
        Mon, 23 May 2022 17:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC2BC385A9;
        Mon, 23 May 2022 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653326715;
        bh=GvPy1TSq0hpYJR7v+A8xk20wsgXU7QBU18utSfY49Sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oL7hp7WNU4H8sQK5xkWggjSJbw9H1Hl39sK4SMLZ+iqZS74dHtb92kZycOkM1Bl+c
         ChKMA+h4tNJ9BpFTzjuVE5KS3X5iaZVWlD1NM3x/quP0/JlAtD5lkTD+g8ZiSJVGDi
         9HKWOUi2T10tMny/ifJQG7KhMBfsj3wRWrbKBK0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Terry Bowman <terry.bowman@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@kernel.org>,
        Mario Limonciello <Mario.Limonciello@amd.com>
Subject: [PATCH 5.17 007/158] i2c: piix4: Move SMBus port selection into function
Date:   Mon, 23 May 2022 19:02:44 +0200
Message-Id: <20220523165831.776332856@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220523165830.581652127@linuxfoundation.org>
References: <20220523165830.581652127@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Terry Bowman <terry.bowman@amd.com>

commit fbafbd51bff52cb3a920fd98d4dae2a78dd433d0 upstream.

Move port selection code into a separate function. Refactor is in
preparation for following MMIO changes.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Cc: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-piix4.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -698,6 +698,20 @@ static void piix4_imc_wakeup(void)
 	release_region(KERNCZ_IMC_IDX, 2);
 }
 
+static int piix4_sb800_port_sel(u8 port)
+{
+	u8 smba_en_lo, val;
+
+	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
+	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
+
+	val = (smba_en_lo & ~piix4_port_mask_sb800) | port;
+	if (smba_en_lo != val)
+		outb_p(val, SB800_PIIX4_SMB_IDX + 1);
+
+	return (smba_en_lo & piix4_port_mask_sb800);
+}
+
 /*
  * Handles access to multiple SMBus ports on the SB800.
  * The port is selected by bits 2:1 of the smb_en register (0x2c).
@@ -714,8 +728,7 @@ static s32 piix4_access_sb800(struct i2c
 	unsigned short piix4_smba = adapdata->smba;
 	int retries = MAX_TIMEOUT;
 	int smbslvcnt;
-	u8 smba_en_lo;
-	u8 port;
+	u8 prev_port;
 	int retval;
 
 	retval = piix4_sb800_region_request(&adap->dev);
@@ -775,18 +788,12 @@ static s32 piix4_access_sb800(struct i2c
 		}
 	}
 
-	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
-	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
-
-	port = adapdata->port;
-	if ((smba_en_lo & piix4_port_mask_sb800) != port)
-		outb_p((smba_en_lo & ~piix4_port_mask_sb800) | port,
-		       SB800_PIIX4_SMB_IDX + 1);
+	prev_port = piix4_sb800_port_sel(adapdata->port);
 
 	retval = piix4_access(adap, addr, flags, read_write,
 			      command, size, data);
 
-	outb_p(smba_en_lo, SB800_PIIX4_SMB_IDX + 1);
+	piix4_sb800_port_sel(prev_port);
 
 	/* Release the semaphore */
 	outb_p(smbslvcnt | 0x20, SMBSLVCNT);


