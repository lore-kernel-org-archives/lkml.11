Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356A0C32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiHWIHr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiHWIHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ACB6BCFE;
        Tue, 23 Aug 2022 01:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E46066122D;
        Tue, 23 Aug 2022 08:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09A5C433D6;
        Tue, 23 Aug 2022 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661241901;
        bh=oPnoyrLnvcSPQog+slHYTPkPrz+FU/jYDqaLlPsJSjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIERPHDvPAer9aLOdKid3ky3YRXnthj7/HDKFYIEpcAQMzdLIIr+PtMbSYjAEDaH6
         pzTF0AzDwqJbCHZ1Ku2G7C2D9YOoTDI4b8D6VgGu+4TcsAn9zT1LbQMdy2bAfF7grj
         a86cxwfNDBVr+zCIytprEPWU6DC1zq8jL4ZwZsJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5.19 014/365] ata: libata-eh: Add missing command name
Date:   Tue, 23 Aug 2022 09:58:35 +0200
Message-Id: <20220823080118.776225344@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

commit d3122bf9aa4c974f5e2c0112f799757b3a2779da upstream.

Add the missing command name for ATA_CMD_NCQ_NON_DATA to
ata_get_cmd_name().

Fixes: 661ce1f0c4a6 ("libata/libsas: Define ATA_CMD_NCQ_NON_DATA")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-eh.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2122,6 +2122,7 @@ const char *ata_get_cmd_name(u8 command)
 		{ ATA_CMD_WRITE_QUEUED_FUA_EXT, "WRITE DMA QUEUED FUA EXT" },
 		{ ATA_CMD_FPDMA_READ,		"READ FPDMA QUEUED" },
 		{ ATA_CMD_FPDMA_WRITE,		"WRITE FPDMA QUEUED" },
+		{ ATA_CMD_NCQ_NON_DATA,		"NCQ NON-DATA" },
 		{ ATA_CMD_FPDMA_SEND,		"SEND FPDMA QUEUED" },
 		{ ATA_CMD_FPDMA_RECV,		"RECEIVE FPDMA QUEUED" },
 		{ ATA_CMD_PIO_READ,		"READ SECTOR(S)" },


