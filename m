Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jan 2022 06:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbiA0Gm0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jan 2022 01:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiA0GmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:42:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B578C061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LmI+ZdF19e6WBJy1XUkn5HFwzjtddFdMKimyr8RDTnI=; b=BAgIwmhmDgYoSedcOGc52bMHOz
        NDaETZIH4cgwzYZt5Ltw+l8mycNlM7XjPe41RUFo2Fq28OBr6z7VldoYiNbxEubEERZ0jKcrZlsgO
        R19TRtzEMITQB8EG76P0drcVLSlabnPeuKJ2tyuEtswQgNCM1jYXRAKHbZN55BLTeQtVco+2Z4IpT
        nLecxuIsrvtk7weGArpjsrsE2+Ga6NjSa26Mur2LgPdfBm5Iok62IRiqeg4dUNfkGbPREYP+JmVYb
        8xRrSKcF0Gg3c9b6MI1bOBUakaHLiVskrsUWPAYmP2wOvkAq4IOsY0eFSiFs6vOtW+xgotD+J8iJU
        XpFeBCFQ==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyUA-00EZ9G-Uv; Thu, 27 Jan 2022 06:42:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add bio.h to the block section
Date:   Thu, 27 Jan 2022 07:42:21 +0100
Message-Id: <20220127064221.1314477-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bio.h is pater of the block layer, so list it in the MAINTAINERS file
as such.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c9143848..5a899f998d86f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3435,6 +3435,7 @@ F:	Documentation/ABI/stable/sysfs-block
 F:	Documentation/block/
 F:	block/
 F:	drivers/block/
+F:	include/linux/bio.h
 F:	include/linux/blk*
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
-- 
2.30.2

