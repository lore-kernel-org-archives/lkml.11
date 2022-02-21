Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B76C43217
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 08:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345604AbiBUIwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:52:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbiBUIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:52:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A9E0A;
        Mon, 21 Feb 2022 00:51:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01AF4B80EAC;
        Mon, 21 Feb 2022 08:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146C3C340F1;
        Mon, 21 Feb 2022 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645433516;
        bh=zTb5/TrdAZinHH8UjTKuhV+YCXbhk4t2JVwIfm/NAu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ep+I0q1d9zGjdDtdvI8avL8fpIHVREUdWKGi4QWQGXpMhszyZOTqknTsQEvo3MMNh
         m57cPkqyfFP51SI2QKtN6Ih7wYdqvUCUXj2OGVc+zl8v9QkoZgnGXzMhwBAwyEKQkD
         jmGZBqxYXwWr0oCGWnScWeb5dF9QYzJgQsCeyzs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.9 05/33] parisc: Fix sglist access in ccio-dma.c
Date:   Mon, 21 Feb 2022 09:48:58 +0100
Message-Id: <20220221084908.739027464@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084908.568970525@linuxfoundation.org>
References: <20220221084908.568970525@linuxfoundation.org>
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
@@ -1008,7 +1008,7 @@ ccio_unmap_sg(struct device *dev, struct
 	ioc->usg_calls++;
 #endif
 
-	while(sg_dma_len(sglist) && nents--) {
+	while (nents && sg_dma_len(sglist)) {
 
 #ifdef CCIO_COLLECT_STATS
 		ioc->usg_pages += sg_dma_len(sglist) >> PAGE_SHIFT;
@@ -1016,6 +1016,7 @@ ccio_unmap_sg(struct device *dev, struct
 		ccio_unmap_page(dev, sg_dma_address(sglist),
 				  sg_dma_len(sglist), direction, 0);
 		++sglist;
+		nents--;
 	}
 
 	DBG_RUN_SG("%s() DONE (nents %d)\n", __func__, nents);


