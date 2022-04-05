Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B43C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377853AbiDELat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbiDEIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:51:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA68CD338;
        Tue,  5 Apr 2022 01:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C8ACB81B92;
        Tue,  5 Apr 2022 08:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1699C385A3;
        Tue,  5 Apr 2022 08:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147933;
        bh=9hCBRRhKdCVoieEBBCzN/gKOJEsz/ukjx7l7GEHMlns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1IaPhFMeKwpL2UNrazrU4k+gD64YrIfdYbcSVSzDxH4dNH9LN+fT53lPIDkyxDFY
         8KRzLRkvzWlylPt77hIjUzmtqk1H8iiSGLd759Lih+dQHpE0RmmDW6Zg5wS8+q4ruQ
         7d364HTCORM/n7/d5ei3ujjSFMGE00z8TUvVledQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ameer Hamza <amhamza.mgc@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 5.16 0174/1017] media: venus: vdec: fixed possible memory leak issue
Date:   Tue,  5 Apr 2022 09:18:07 +0200
Message-Id: <20220405070359.394359234@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ameer Hamza <amhamza.mgc@gmail.com>

commit 8403fdd775858a7bf04868d43daea0acbe49ddfc upstream.

The venus_helper_alloc_dpb_bufs() implementation allows an early return
on an error path when checking the id from ida_alloc_min() which would
not release the earlier buffer allocation.

Move the direct kfree() from the error checking of dma_alloc_attrs() to
the common fail path to ensure that allocations are released on all
error paths in this function.

Addresses-Coverity: 1494120 ("Resource leak")

cc: stable@vger.kernel.org # 5.16+
Fixes: 40d87aafee29 ("media: venus: vdec: decoded picture buffer handling during reconfig sequence")
Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/helpers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -189,7 +189,6 @@ int venus_helper_alloc_dpb_bufs(struct v
 		buf->va = dma_alloc_attrs(dev, buf->size, &buf->da, GFP_KERNEL,
 					  buf->attrs);
 		if (!buf->va) {
-			kfree(buf);
 			ret = -ENOMEM;
 			goto fail;
 		}
@@ -209,6 +208,7 @@ int venus_helper_alloc_dpb_bufs(struct v
 	return 0;
 
 fail:
+	kfree(buf);
 	venus_helper_free_dpb_bufs(inst);
 	return ret;
 }


