Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4025C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbiBUJP3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:15:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbiBUJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:09:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0912264F3;
        Mon, 21 Feb 2022 01:01:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ACC76112B;
        Mon, 21 Feb 2022 09:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82872C340E9;
        Mon, 21 Feb 2022 09:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645434104;
        bh=B3V/EFHY9+d/uJRBcFrB7LlPclALnd89vW1EiTlJXt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFUuudVPf2bBrP2Y7D9gIock/ItKDTMOBnQ6nBOHd/FSLsqBTig2Je9l6x+lP+TfO
         n4u11egMOSHx7BtYM/pq350DcB6TJ5KOOicncKl+2KpNpJNk7Ayx2FeBNQ8cP/BXj/
         EpFckTBjqg7ktEKlUdxfUJigTFGzRvFlsuLq+jt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.10 014/121] parisc: Fix sglist access in ccio-dma.c
Date:   Mon, 21 Feb 2022 09:48:26 +0100
Message-Id: <20220221084921.629623675@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084921.147454846@linuxfoundation.org>
References: <20220221084921.147454846@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John David Anglin <dave.anglin@bell.net>

commit d7da660cab47183cded65e11b64497d0f56c6edf upstream.

This patch implements the same bug fix to ccio-dma.c as to sba_iommu.c.
It ensures that only the allocated entries of the sglist are accessed.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/parisc/ccio-dma.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -1003,7 +1003,7 @@ ccio_unmap_sg(struct device *dev, struct
 	ioc->usg_calls++;
 #endif
 
-	while(sg_dma_len(sglist) && nents--) {
+	while (nents && sg_dma_len(sglist)) {
 
 #ifdef CCIO_COLLECT_STATS
 		ioc->usg_pages += sg_dma_len(sglist) >> PAGE_SHIFT;
@@ -1011,6 +1011,7 @@ ccio_unmap_sg(struct device *dev, struct
 		ccio_unmap_page(dev, sg_dma_address(sglist),
 				  sg_dma_len(sglist), direction, 0);
 		++sglist;
+		nents--;
 	}
 
 	DBG_RUN_SG("%s() DONE (nents %d)\n", __func__, nents);


