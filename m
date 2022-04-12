Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1919EC352A8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382970AbiDLIfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353839AbiDLHZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6A0DF00;
        Tue, 12 Apr 2022 00:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17BE060B65;
        Tue, 12 Apr 2022 07:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5CBC385A1;
        Tue, 12 Apr 2022 07:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747092;
        bh=U2/FILndl4co+BlYvc00C3mSRpRj6SmZahSvs4PQbsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/E5R/U1r0oIyybkED+RzMUjYAl3WpautWoX/MqSL5Ua2tnM4HFl/iNRPxpqbB7px
         7cxYNTdSk4FIF/u9VvfFQJr+6H3Mv40qXBErT0IhbtM+SMINguueUfqHFEROMESOh5
         R36FQGIZcJenUN+p94lWYVArGbINek1nBPn2H7cE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Douglas Miller <doug.miller@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 5.16 239/285] RDMA/hfi1: Fix use-after-free bug for mm struct
Date:   Tue, 12 Apr 2022 08:31:36 +0200
Message-Id: <20220412062950.560954610@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062943.670770901@linuxfoundation.org>
References: <20220412062943.670770901@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Miller <doug.miller@cornelisnetworks.com>

commit 2bbac98d0930e8161b1957dc0ec99de39ade1b3c upstream.

Under certain conditions, such as MPI_Abort, the hfi1 cleanup code may
represent the last reference held on the task mm.
hfi1_mmu_rb_unregister() then drops the last reference and the mm is freed
before the final use in hfi1_release_user_pages().  A new task may
allocate the mm structure while it is still being used, resulting in
problems. One manifestation is corruption of the mmap_sem counter leading
to a hang in down_write().  Another is corruption of an mm struct that is
in use by another task.

Fixes: 3d2a9d642512 ("IB/hfi1: Ensure correct mm is used at all times")
Link: https://lore.kernel.org/r/20220408133523.122165.72975.stgit@awfm-01.cornelisnetworks.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/mmu_rb.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -80,6 +80,9 @@ void hfi1_mmu_rb_unregister(struct mmu_r
 	unsigned long flags;
 	struct list_head del_list;
 
+	/* Prevent freeing of mm until we are completely finished. */
+	mmgrab(handler->mn.mm);
+
 	/* Unregister first so we don't get any more notifications. */
 	mmu_notifier_unregister(&handler->mn, handler->mn.mm);
 
@@ -102,6 +105,9 @@ void hfi1_mmu_rb_unregister(struct mmu_r
 
 	do_remove(handler, &del_list);
 
+	/* Now the mm may be freed. */
+	mmdrop(handler->mn.mm);
+
 	kfree(handler);
 }
 


