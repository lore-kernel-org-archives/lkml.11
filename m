Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5A6C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 14:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbiGOOip (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGOOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:38:41 -0400
X-Greylist: delayed 478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 07:38:38 PDT
Received: from violet.hashi.re (13.169.3.93.rev.sfr.net [93.3.169.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B65C63FD;
        Fri, 15 Jul 2022 07:38:38 -0700 (PDT)
Received: from [192.168.43.7] (5.205.136.77.rev.sfr.net [77.136.205.5])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: elliu)
        by violet.hashi.re (Postfix) with ESMTPSA id BD00B860276;
        Fri, 15 Jul 2022 16:30:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hashi.re; s=mail;
        t=1657895438; bh=d7Q4OGi47iBgLbolyA/55pua9XUw9DdMbLz7RsFPDc8=;
        h=Date:From:Subject:To:From;
        b=Inu6cXsIXbPUcdFHLoKyLu74E/UkhHxnG5GzfR0AvfHCgSSA1VFffkaGMIPV9Snmw
         9PlASDnu57Ax5gvSHI1G5PFpRHVYKiQtirY5Z07UJfxICnAKlGCbtYYaiU20yBC+IN
         vWoa1reaZLBTihU8OrV7WSX4YvegpQYf+F6MxdZOMf2oPvn0R6WIfJnEOUe8MYeprm
         aqB56k03fklIJkNpNqczAqhTE7Kx3Jzk3TWQLK10bCo1QvXdNU/0BngZqB+5wEyhTy
         iDJriviib7cPp6AqpjzVzAzhaG5k+jAFE4gUjzOUmVWLuXhPL0/psZstfiou1VK6dJ
         vdyzUB85d5NqA==
Message-ID: <0e60fe4b-5bc6-19bb-a061-23acbfa606c4@hashi.re>
Date:   Fri, 15 Jul 2022 16:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Louis Goyard <louis.goyard@hashi.re>
Subject: [PATCH] staging: qlge: fix indentation
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Louis Goyard <louis.goyard@hashi.re>

Adhere to linux coding style. Reported by checkpatch:
WARNING: suspect code indent for conditional statements (16, 32)

Signed-off-by: Louis Goyard <louis.goyard@hashi.re>
---
  drivers/staging/qlge/qlge_main.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/qlge/qlge_main.c 
b/drivers/staging/qlge/qlge_main.c
index 1a378330d775..8eb0048c596d 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -3008,9 +3008,9 @@ static int qlge_start_rx_ring(struct qlge_adapter 
*qdev, struct rx_ring *rx_ring
  		base_indirect_ptr = rx_ring->lbq.base_indirect;

  		for (page_entries = 0; page_entries <
-			MAX_DB_PAGES_PER_BQ(QLGE_BQ_LEN); page_entries++)
-				base_indirect_ptr[page_entries] =
-					cpu_to_le64(tmp + (page_entries * DB_PAGE_SIZE));
+				MAX_DB_PAGES_PER_BQ(QLGE_BQ_LEN); page_entries++)
+			base_indirect_ptr[page_entries] =
+				cpu_to_le64(tmp + (page_entries * DB_PAGE_SIZE));
  		cqicb->lbq_addr = cpu_to_le64(rx_ring->lbq.base_indirect_dma);
  		cqicb->lbq_buf_size =
  			cpu_to_le16(QLGE_FIT16(qdev->lbq_buf_size));
@@ -3023,9 +3023,9 @@ static int qlge_start_rx_ring(struct qlge_adapter 
*qdev, struct rx_ring *rx_ring
  		base_indirect_ptr = rx_ring->sbq.base_indirect;

  		for (page_entries = 0; page_entries <
-			MAX_DB_PAGES_PER_BQ(QLGE_BQ_LEN); page_entries++)
-				base_indirect_ptr[page_entries] =
-					cpu_to_le64(tmp + (page_entries * DB_PAGE_SIZE));
+				MAX_DB_PAGES_PER_BQ(QLGE_BQ_LEN); page_entries++)
+			base_indirect_ptr[page_entries] =
+				cpu_to_le64(tmp + (page_entries * DB_PAGE_SIZE));
  		cqicb->sbq_addr =
  			cpu_to_le64(rx_ring->sbq.base_indirect_dma);
  		cqicb->sbq_buf_size = cpu_to_le16(SMALL_BUFFER_SIZE);
-- 
2.37.1
