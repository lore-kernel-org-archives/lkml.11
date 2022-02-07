Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2617C4332F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 06:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354089AbiBGGiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 01:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbiBGGdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:33:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D1C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/NCdUINdSDF5KM2Tb0Dq1i00on9a3wMEZ1QazdYyuYI=; b=ooIei4pfJnCYjgGG+26anfZyxt
        7RPGv8eBlOliwSMzx5DHbMG1ml8zLJe9WG/7xmz++kRingnQ+IvxnuJTHlPCs1Hwm0do7LNzBLi48
        68VBDLLuGuVYNK7Iw0TK6gyltfjGMgLQ72FXo3g7g+myJm1KPzOnKffgXxRtNjKsiKuk2IQ1ZLCAh
        d0FhUJIcuwhbbJ05Q9J4VNkVt+7xskowLyUjFLZJ3GHD1iZ+b7MwEfcwP/jO5gGmbPetBVX4fWBLv
        zknna1w060pYHr37Om6EfjDULgdFda5Q+HPWdA3z5JG8pwz8w19XAjipmSILOVQe8fO6fqp2mXlbq
        P+0uB/VA==;
Received: from [2001:4bb8:188:3efc:2cbe:55d7:bb63:46d2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGxaL-0099Ok-Pz; Mon, 07 Feb 2022 06:33:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: [PATCH 8/8] fsdax: depend on ZONE_DEVICE || FS_DAX_LIMITED
Date:   Mon,  7 Feb 2022 07:32:49 +0100
Message-Id: <20220207063249.1833066-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207063249.1833066-1-hch@lst.de>
References: <20220207063249.1833066-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a depends on ZONE_DEVICE support or the s390-specific limited DAX
support, as one of the two is required at runtime for fsdax code to
actually work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index 05efea674bffa0..6e8818a5e53c45 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -48,6 +48,7 @@ config FS_DAX
 	bool "File system based Direct Access (DAX) support"
 	depends on MMU
 	depends on !(ARM || MIPS || SPARC)
+	depends on ZONE_DEVICE || FS_DAX_LIMITED
 	select FS_IOMAP
 	select DAX
 	help
-- 
2.30.2

